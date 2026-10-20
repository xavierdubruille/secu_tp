# Ressources du TP2 — les cibles locales

Les sept cibles ACME et le serveur Apache se lancent dans **votre VM Kali**, avec Docker Compose.
Lisez l'énoncé pour les exercices. Dans le dépôt étudiant, le Compose est directement dans
`~/secu_tp/TP2-reconnaissance-reseau`, à côté de ce fichier `ressources-README.md`.

## Démarrer avec les images préparées

```bash
cd ~/secu_tp/TP2-reconnaissance-reseau
bash verifier-labo.sh
docker compose up -d --no-build --pull never
bash verifier-labo.sh --pret
# Mission 3, quand vous y arrivez :
docker compose -f apache-cve/docker-compose.yml up -d --no-build --pull never
```

Le premier contrôle vérifie les outils, Docker Compose et les images, **sans rien installer**.
`--pret` attend que les services ACME répondent. Une erreur ? Montrez-la au professeur avec
`docker compose ps` et `docker compose logs --tail=30`. Ne reconstruisez pas tout pendant l'exercice.

Kali atteint les deux bridges Docker directement. Les cibles ACME ne publient aucun port ; Apache
publie **seulement** `127.0.0.1:8080`. Ce n'est pas une simulation de pare-feu entre DMZ et LAN.
L'extension Metasploitable2 utilise son propre Compose et n'est pas nécessaire au tronc commun.

## Préparation des images — avant la séance

Depuis ce dossier, sur le poste qui prépare la distribution :

```bash
bash charger-images.sh
```

Le script télécharge les images tierces, construit SSH et Apache, puis exporte `tp2-images.tar.gz`.
Il conserve exactement l'image Samba épinglée par son digest et lui donne un **nom local exportable**,
`tp2-acme-smb:20261020`. Cette archive volumineuse se transmet par partage/clé USB, **pas par Git**.
Les tags tiers peuvent évoluer : préparez une archive commune validée, puis utilisez-la sur les VM.

Sur chaque VM étudiante, avant le cours :

```bash
bash charger-images.sh --load /chemin/vers/tp2-images.tar.gz
bash verifier-labo.sh
```

Les outils nécessaires sont Docker/Compose v2, Nmap, smbclient, client MySQL/MariaDB, snmpwalk,
tshark, curl, nc et ip. Searchsploit sert à la recherche M3 ; le guide Vulhub et l'avis Apache
permettent de poursuivre s'il manque. Le script de préparation de VM du cours installe ces outils.
L'import d'images ne les installe pas.

## Origine, adaptations et licences

| Ressource | Source | Licence conservée |
|---|---|---|
| `cibles/` : web, SSH, Redis, hôte discret, SMB, MySQL et SNMP | [Michael Borck, Ethical Hacking Docker Labs](https://github.com/michael-borck/ethical-hacking-docker-labs), week4 et week5 | `LICENSE.borck-MIT` |
| `apache-cve/` : Apache 2.4.49 / CVE-2021-41773 | [Vulhub](https://github.com/vulhub/vulhub/tree/master/httpd/CVE-2021-41773) | `LICENSE.vulhub-MIT` |
| `metasploitable/` : extension historique | image référencée `tleemcjr/metasploitable2` | image tierce, pas de copie de ses sources dans ce dépôt |

Les notices MIT accompagnent les copies des cibles : **gardez-les avec les ressources**.
Les fichiers de données fictives de Borck restent inchangés (ils mentionnent EnumCorp).

Adaptations : Kali remplace le conteneur attaquant ; LDAP est retiré ; les adresses de l'énoncé
priment sur les guides ; les ports des cibles ACME ne sont pas publiés. SSH est installé au build,
pas au démarrage. Apache garde la configuration et la requête de traversée du labo Vulhub.
Ne lancez pas les Compose des guides d'origine en parallèle : leurs adresses peuvent se chevaucher.

## Arrêter

Depuis le dossier TP2 :

```bash
docker compose -f apache-cve/docker-compose.yml down
docker compose -f metasploitable/docker-compose.yml down
docker compose down
```

Les scans, votre fiche et le PCAP sont vos résultats : sauvegardez-les dans votre dépôt personnel.
