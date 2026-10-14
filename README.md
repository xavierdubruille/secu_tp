# secu_tp — ressources des TP · Sécurité des réseaux (EPHEC)

Ressources **à télécharger pour les travaux pratiques** du cours de Sécurité des réseaux.
Un dossier par TP (docker-compose, scripts, cibles, énoncé).

> Les énoncés **officiels** (PDF), la remise et les points sont sur **Moodle**.
> Ici, c'est une **copie pratique des fichiers**, à titre **purement informatif**.

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

## Améliorer les TP — je suis preneur

Ce dépôt est **ouvert**, et vos retours comptent vraiment. Une coquille, une consigne pas claire,
un outil plus malin, une idée pour rendre un TP plus intéressant ? **Proposez-le.** Les bonnes idées
seront intégrées aux prochaines éditions — et **créditées**.

Deux façons, au choix (pas besoin d'être expert, une remarque d'une ligne a déjà de la valeur) :

- **Un retour rapide** — conseil, remarque, « ça a coincé ici » : ajoutez quelques lignes dans
  [`retours/`](retours/) (mode d'emploi dans le dossier).
- **Une correction ou une amélioration directe** dans les fichiers : ouvrez une *pull request*.

> Jamais fait de *pull request* ? C'est l'occasion parfaite d'apprendre — voir
> [`CONTRIBUTING.md`](CONTRIBUTING.md) (3 minutes).

## Usage

À l'intérieur d'un dossier de TP, lis d'abord son `README.md`, puis lance la cible :

```bash
cd TP1-osint/cible
docker compose up -d        # site sur http://localhost:8080
```
