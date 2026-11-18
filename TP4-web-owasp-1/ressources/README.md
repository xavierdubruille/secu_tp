# Ressources TP4 : cible du lab

> Tout ce qu'il faut pour faire tourner le TP. Tout reste **local**, rien n'est exposé au réseau.

## Lancer la cible

```bash
docker compose up -d        # puis http://127.0.0.1:3001 (dans le navigateur de Burp)
docker compose down         # pour arrêter
```

La cible est **OWASP Juice Shop**, une application web volontairement vulnérable, servie uniquement sur
`127.0.0.1`. Première fois : l'image se télécharge (quelques dizaines de Mo), puis l'appli est prête en
une quinzaine de secondes.

## La finale (BeEF)

BeEF (Browser Exploitation Framework) est **préinstallé dans Kali** : `sudo beef-xss` (panneau sur
`/ui/panel`, hook sur le port 3000). Il n'est pas dans le `docker-compose` : on le lance à part, au
moment de la finale, en binôme. Détails dans l'énoncé.

## Source et licence

- **OWASP Juice Shop**, par Bjoern Kimminich et l'OWASP Foundation. Licence **MIT**.
  Dépôt : <https://github.com/juice-shop/juice-shop>. Image officielle utilisée :
  `bkimminich/juice-shop:v20.3.0` (version figée pour la stabilité des corrigés).
- On **utilise l'image officielle** (on ne recopie pas le code source dans le dépôt) : le crédit
  ci-dessus suffit au titre de la licence MIT.
- **BeEF** : projet `beefproject/beef`. Lancé depuis Kali, non redistribué ici.

## Note de configuration

Le `docker-compose.yml` fixe `NODE_ENV=unsafe` : sans cela, Juice Shop neutralise volontairement les
XSS stockées, dont on a besoin pour la mission 3 et la finale.
