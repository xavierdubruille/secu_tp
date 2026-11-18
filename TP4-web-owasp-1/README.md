
# TP4 · Sécurité web : quand une donnée devient une instruction

Vous auditez une instance locale d'OWASP Juice Shop, dans votre VM Kali, sur l'application fournie. Réussir une attaque, ici, c'est le début de l'explication, pas la fin.

## Ce que vous allez faire

OWASP Juice Shop est une boutique en ligne volontairement vulnérable. Vous allez l'attaquer de trois façons : **vous connecter sans mot de passe** (SQL injection), **lire des données que la boutique ne devrait pas montrer** (SQL injection, UNION), puis **faire exécuter votre code dans le navigateur d'un autre utilisateur** (XSS). La finale, en binôme, pousse la dernière jusqu'à prendre la main sur la page de la victime (BeEF).

Une question tout du long : *à quel moment une donnée que vous envoyez devient-elle une instruction que le serveur, ou le navigateur, exécute ?*

Chaque attaque de ce tp et du suivant porte un nom dans l'OWASP Top 10 2025.  Dans ce TP, il s'agira surtout **A05 Injection**. Chacune a sa défense, et c'est ce que vous avez dû faire en dev3. 

## Cadre (comme d'habitude) 

Tout se passe dans votre VM/sur votre ordi, sur l'application fournie. Rejouer ces techniques sur un vrai site, un vrai réseau ou une personne non consentante est une infraction pénale ( art. 550bis, 314bis, 550ter), même « pour voir ». Ici, c'est permis : tout est isolé et à vous.

## Objectifs

À la fin, sur un cas qu'on vous donne, vous devez pouvoir :

1. intercepter et rejouer une requête HTTP avec Burp Suite ;
2. expliquer une SQL injection et une XSS et dire **où** le code s'exécute ;
3. montrer leur impact dans le labo et proposer une défense pour chacune.

## Démarrer

```bash
docker compose up -d
```

Ouvrez `http://127.0.0.1:3001` dans le navigateur intégré à Burp Suite. Le **Score Board** (`/#/score-board`) liste tous les défis de l'application ; suivez les missions ci-dessous pour ce TP mais je vous invite a en faire d'avantage !  (et on en fera d'autres au prochain TP) 

## Mission 1 · Se connecter en admin sans son mot de passe

Le formulaire de connexion construit sa requête SQL à partir de ce que vous tapez.

1. Interceptez une tentative de connexion dans Burp. Repérez les champs envoyés.
2. Dans Repeater, modifiez l'email pour que la condition SQL tombe toujours sur le compte admin. Comparez la requête normale et la vôtre.
3. Gardez une capture de la requête modifiée et de la réponse.

> **Fini quand** vous accédez au compte admin et savez dire pourquoi l'application a validé une identité sans mot de passe valide.

**Défense.** Requête paramétrée : votre saisie n'est jamais collée au code de la requête, elle ne peut donc plus en changer le sens. En appui, un compte de base de données aux droits minimaux. Échapper à la main ne suffit pas.

## Mission 2 · Lire plus que ce que la boutique affiche

La recherche de produits, elle aussi, passe votre texte dans une requête SQL.

1. Dans Burp, repérez la requête qui porte votre recherche.
2. Provoquez une erreur contrôlée, puis déduisez combien de colonnes la requête renvoie.
3. Avec un UNION, faites apparaître une donnée de votre choix dans les résultats. Lancez ensuite sqlmap sur ce seul paramètre et comparez sa conclusion à votre raisonnement manuel.
4. Notez deux défenses : une qui corrige la faille, une qui limite l'impact si la première cède.

> **Fini quand** vous avez une requête manuelle que vous savez expliquer et une sortie sqlmap que vous savez lire.

**Défense.** La même qu'en mission 1 : requête paramétrée. En plus, des messages d'erreur avares : une application qui affiche ses erreurs SQL en clair indique à l'attaquant le bon nombre de colonnes. sqlmap va plus vite que vous, mais il n'invente pas l'hypothèse : il l'amplifie.

## Mission 3 · Faire exécuter votre code chez un autre utilisateur

1. Réalisez le défi **DOM XSS** depuis le champ de recherche : votre texte s'exécute dans votre propre page.
2. Créez ensuite un compte de test dont l'email contient une XSS stockée. Connectez-vous en admin (mission 1), ouvrez l'administration, et observez : le code se déclenche chez quelqu'un d'autre.
3. Dites qui a envoyé le code, qui l'exécute, et pourquoi le stockage change l'ampleur.

> **Fini quand** vous distinguez une XSS déclenchée par votre propre URL d'une XSS déclenchée quand un autre utilisateur consulte une donnée stockée.

**Défense.** Encoder la sortie selon son contexte (HTML, attribut, JavaScript ne s'encodent pas pareil), pour que votre texte reste du texte. En appui : cookies de session en `HttpOnly` (le JavaScript ne lit plus la session) et une CSP qui limite ce qu'une page peut charger. La plupart des frameworks encodent par défaut — on ne désactive pas cette protection.

## Finale · BeEF en binôme

En binôme, un Attaquant et une Victime ; vous inverserez les rôles si vous avez l'occasion (et vous la jouez schizophrène si vous êtes seul ;) . On reprend la XSS stockée de la mission 3, mais cette fois elle charge un *hook* BeEF : l'Attaquant pilote le navigateur de la Victime à distance.

**Montage.** L'idéal est d'avoir un site distant, et victime sur une machine et attaquant sur une autre.  Pas sûr que ça fonctionne niveau réseau, alors on va faire au mieux (on en parle en classe) et, en fallback: une seule VM par binôme, deux profils de navigateur bien séparés — pas deux onglets du même profil, qui partagent les cookies et brouillent la démo. La cible et BeEF tournent dans cette VM. Entre deux postes : seulement si le prof a testé le réseau de la salle.

**Déroulé.**
1. L'Attaquant reprend la XSS stockée de la mission 3 et y met le hook BeEF à la place du marqueur (le prof donne la ligne ; BeEF l'affiche à son démarrage).
2. La Victime ouvre la page concernée comme le ferait un admin. Son navigateur apparaît dans BeEF, côté Attaquant.
3. L'Attaquant lance deux actions visibles, choisies à l'avance : par exemple lire les infos du navigateur, puis modifier la page de la Victime ou afficher une fausse boîte de reconnexion.
4. Inversez les rôles. Chacun doit savoir expliquer comment son code est arrivé chez l'autre.

La Victime n'a rien installé ni téléchargé : elle a ouvert une page de l'application, en confiance, et son navigateur obéit à l'Attaquant. En HTTPS, le cadenas serait resté vert : le chiffrement protège le transport, pas la qualité du code, qui s'exécute une fois la page déchiffrée.

**Défense.** Pas de XSS, pas de hook : l'encodage en sortie coupe le problème à la racine. En défense en profondeur, une CSP qui interdit les scripts externes empêche le hook de se charger, et des cookies `HttpOnly`, `SameSite`, `Secure` réduisent ce qu'on peut voler.

> C'est une expérience, pas une condition de réussite. Si BeEF ou un module ne répond pas, le seul fait que votre code s'exécute dans le navigateur du binôme prouve l'essentiel. On ne cible jamais un vrai poste, un vrai compte, ni le réseau de l'école.

## La défense, en un tableau

Les trois attaques ont la même forme, et presque la même parade.

| Attaque | Ce qui l'a permise | La défense (côté dev) |
|---|---|---|
| SQL injection | votre saisie mélangée au code de la requête | requête paramétrée + compte de base aux droits minimaux |
| XSS (reflected, stored) | votre sortie réaffichée sans encodage | output encoding selon le contexte + CSP |
| Prise de main (BeEF) | une XSS, un cookie lisible, un script externe autorisé | corriger la XSS ; en profondeur CSP + cookies `HttpOnly`, `SameSite`, `Secure` |

Ne jamais croire la saisie sur parole, neutraliser en sortie, donner le moins de droits possible : c'est ce que votre cours de développement demandait déjà.

## Remise Moodle et examen

Remettez une capture d'une requête Burp modifiée, son résultat, et une phrase qui explique le mécanisme et sa défense. Les captures de la finale (binôme hooké, action réussie) sont un bonus. On veut des données et une explication, pas un flag.

Pour l'examen : expliquer SQL injection et XSS, dire qui exécute quoi et où, distinguer le transport (HTTPS) de la sécurité de l'application, et proposer une défense adaptée. Les payloads, commandes et menus ne sont pas à apprendre par cœur.
