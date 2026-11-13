# TP3 · Attaques réseau : ARP, DNS, TCP, qui croit qui ?

> **4 h**, avec des mises en commun et une pause. Tout se fait dans votre VM, sur les labos SEED
> lancés en Docker. Vous travaillez en autonomie entre les mises en commun.
> Les exercices sont ceux du document de préparation déjà publié.

## Ce que vous allez faire

Sur un réseau local, les protocoles font confiance à ce qu'on leur dit. Vous allez en profiter
trois fois : **vous mettre au milieu** d'une conversation (ARP), **envoyer une victime ailleurs**
(DNS), puis **rendre un service indisponible** (SYN flood). À chaque fois, posez-vous la même
question : *sur quoi repose la confiance, et l'attaquant peut-il l'imiter ?*

À la fin, vous devez pouvoir expliquer, sur un cas qu'on vous donne :

1. ce qu'un attaquant peut faire selon sa **position** (il ne voit rien, il voit passer, il est au milieu) ;
2. **pourquoi** ARP, DNS et TCP se laissent tromper ;
3. **une défense** pour chaque attaque, et ce qu'elles ont en commun.

**Fil rouge ATT&CK.** Deux tactiques nouvelles aujourd'hui : **Collection** et **Impact**.
*Credential Access* revient, par le réseau cette fois.

| Exercice | Technique ATT&CK | Tactique(s) |
|---|---|---|
| 1. ARP + MITM | T1557.002 ARP Cache Poisoning · T1040 Network Sniffing | Credential Access, Collection |
| 2. DNS | T1557 Adversary-in-the-Middle | Credential Access, Collection |
| 3. SYN flood | T1499.001 OS Exhaustion Flood | Impact |

## Cadre

- Tout reste **dans votre VM**, sur les réseaux Docker des labos (`10.9.0.0/24`, `10.8.0.0/24`).
- Sniffing, ARP spoofing ou SYN flood sur un vrai réseau (école, maison, Wi-Fi public) : c'est une
  **infraction**, même « pour voir ».

## Avant la séance

Les images Docker pèsent ~1,5 Go : si vous êtes sur votre laptop, essayez de les pull au plus tôt ! (idéalement avant la séance)

J'ai rajouté les ressources du TP sur le dépôt du cours (`secu_tp`, dossier `TP3-attaques-reseau/` : les
`Labsetup` des trois labos et leurs énoncés en PDF), dans l'espoir d'accélérer les choses. En soi, ce
n'est pas obligatoire : vous les trouverez aussi via l'énoncé original. Prenez l'une **ou** l'autre
option, puis lancez la dernière boucle.

```bash
# Option 1 : depuis le dépôt du cours
git clone https://github.com/xavierdubruille/secu_tp.git ~/secu_tp   # déjà cloné : cd ~/secu_tp && git pull
mkdir -p ~/tp3
cp -r ~/secu_tp/TP3-attaques-reseau/labos/. ~/tp3/

# Option 2 : directement chez SEED
mkdir -p ~/tp3 && cd ~/tp3
for lab in ARP_Attack DNS_Local TCP_Attacks; do
  mkdir -p $lab
  wget -q -O $lab/Labsetup.zip https://seedsecuritylabs.org/Labs_20.04/Files/$lab/Labsetup.zip
  unzip -q -o $lab/Labsetup.zip -d $lab
done

# Dans les deux cas : télécharger et construire les images
for lab in ARP_Attack DNS_Local TCP_Attacks; do
  (cd ~/tp3/$lab/Labsetup && docker compose up -d && docker compose down)
done
```

**Un seul labo à la fois** : les trois utilisent le même réseau `10.9.0.0/24`. Pendant un exercice,
pas de `docker compose down` (les adresses MAC changent). Entre deux exercices : `down` du labo
terminé, `up -d` du suivant.

## Exercice 1 · ARP cache poisoning, puis MITM

Énoncé : **SEED ARP Cache Poisoning Attack Lab**
(`enonces-seed/1-ARP_Attack.pdf` ou https://seedsecuritylabs.org/Labs_20.04/Networking/ARP_Attack/).

| À faire | À sauter |
|---|---|
| **Task 1** : la variante A (request) à fond ; B (reply) et C (gratuitous ARP) : essayez et notez ce que vous observez | **Task 3** (MITM sur Netcat) : même idée que la Task 2 |
| **Task 2** : MITM sur Telnet. **Pendant l'interception, lancez Wireshark** et regardez ce qui passe, même si l'énoncé ne le demande pas | |

> **Fini quand** : `arp -n` sur la victime montre la MAC de l'attaquant (Task 1), et vous lisez
> l'identifiant et le mot de passe dans votre capture (Task 2).
> **Avant le débrief** : les trois variantes de la Task 1 ont-elles toutes marché ? Qu'est-ce qui
> aurait empêché la Task 2 de vous montrer le mot de passe ? On en discute ensemble.

## Exercice 2 · DNS cache poisoning

Énoncé : **SEED Local DNS Attack Lab**
(`enonces-seed/2-DNS_Local.pdf` ou https://seedsecuritylabs.org/Labs_20.04/Networking/DNS/DNS_Local/).
Ce labo a besoin d'Internet dans la VM.

| À faire | À sauter |
|---|---|
| **Task 2** : cache poisoning du serveur DNS local. Le script fourni fait aussi les **Tasks 3 et 5** (faux NS, section additionnelle) : regardez ce qu'il ajoute | **Task 1** et **Task 4** |

> **Fini quand** : depuis la machine utilisateur, `dig` sur le nom visé renvoie l'adresse de
> l'attaquant, **et** le cache du serveur DNS contient les fausses entrées. (L'énoncé parle de
> `www.example.com`, l'exemple de script de `www.example.net` : choisissez-en un et restez-y.)
> **Avant le débrief** : combien de temps la victime restera-t-elle trompée ? Pour quels noms ?

## Exercice 3 · Rendre un service indisponible (SYN flood)

Énoncé : **SEED TCP/IP Attack Lab**
(`enonces-seed/3-TCP_Attacks.pdf` ou https://seedsecuritylabs.org/Labs_20.04/Networking/TCP_Attacks/).

| À faire | À sauter |
|---|---|
| **Task 1.1** : SYN flood en Python | **Task 1.2** (version C) : l'image n'a pas de compilateur |
| **Task 1.3** (SYN cookies) : on la fait ensemble en fin de séance ; si vous êtes en avance, faites-la | **Task 3** et **Task 4** (session hijacking, reverse shell) |
| *Facultatif, si vous êtes en avance* : **Task 2** (RST sur Telnet) | |

> **Fini quand** : pendant le flood, un utilisateur légitime ne parvient plus à se connecter à la
> victime, puis y parvient de nouveau quand vous arrêtez.
> **Avant le débrief** : pourquoi le labo désactive-t-il exprès une protection sur la victime ?

## Bon à savoir

- Gardez **un terminal par machine**, ouvert toute la séance.
- Mettez les adresses IP et MAC **en variables en tête de vos scripts** : relevez-les vous-mêmes
  (`ip addr` dans chaque conteneur), elles ne sont pas celles des exemples.
- Faites vos **captures d'écran au fil de l'eau**, pas à la fin.
- Avant de conclure « ça ne marche pas », lancez la commande de contrôle (`arp -n`, `dig`,
  `netstat -tn`). Souvent, c'est un cache ou une adresse périmée.

## À rendre

Un **ZIP** sur le devoir Moodle du TP3 : un court **README** par exercice (ce que vous avez fait,
observé, compris) et les captures d'écran des moments clés :

- **Exercice 1** : le cache ARP de la victime avant / après ; votre capture Wireshark où l'on lit
  l'identifiant et le mot de passe.
- **Exercice 2** : le `dig` qui renvoie la fausse adresse ; les fausses entrées dans le cache du serveur.
- **Exercice 3** : le nombre de connexions `SYN_RECV` pendant le flood ; la connexion légitime qui échoue.

## Bonus (à la maison)

- **Cap ou Pcap** (Hackropole, ANSSI) : https://hackropole.fr/fr/challenges/forensics/fcsc2020-forensics-cap-ou-pcap/
  Retrouver une information dans une capture réseau : l'envers du décor, côté défenseur.

## À retenir pour l'examen

À savoir **expliquer**, sur un cas qu'on vous donne :

1. Les trois positions d'un attaquant réseau et ce que chacune permet.
2. Pourquoi une request ARP forgée et une reply ARP non sollicitée n'ont pas le même effet.
3. Comment un faux enregistrement NS détourne toute une zone DNS, et le rôle du TTL.
4. Pourquoi le serveur est vulnérable dès le SYN, et comment les SYN cookies le protègent.
5. Une défense par attaque (chiffrer, segmenter, détecter) et le classement ATT&CK de chacune.
6. Le pilier CIA (confidentialité, intégrité, disponibilité) que menace chaque attaque.

- **Pas à apprendre par cœur** : la syntaxe Scapy, les adresses du labo, les options des commandes.
