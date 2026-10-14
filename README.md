# secu_tp — ressources des TP · Sécurité des réseaux (EPHEC)

Ressources **à télécharger pour les travaux pratiques** du cours de Sécurité des réseaux.
Un dossier par TP (docker-compose, scripts, cibles, énoncé).

> Les consignes officielles, la remise et les points restent sur **Moodle**.
> Ce dépôt ne sert qu'à **récupérer les fichiers** facilement.

## Récupérer les fichiers

Tout le dépôt :

```bash
git clone https://github.com/xavierdubruille/secu_tp.git
cd secu_tp
```

Pour mettre à jour plus tard : `git pull`.

## Les TP

| Dossier | TP |
|---|---|
| [`TP1-osint/`](TP1-osint/) | TP1 — OSINT : l'empreinte d'une entreprise, du renseignement au phishing |

*(d'autres TP s'ajouteront au fil de l'année)*

## Usage

À l'intérieur d'un dossier de TP, lis d'abord son `README.md`, puis lance la cible :

```bash
cd TP1-osint/cible
docker compose up -d        # site sur http://localhost:8080
```
