# Contribuer — guide express (3 min)

Merci d'améliorer ces TP. Tout est bienvenu : coquilles, consignes ambiguës, meilleurs outils,
idées d'exercices, ou corrections directes dans le code.

## Le plus simple : depuis le site GitHub

1. Ouvrez le fichier à modifier dans le dépôt, cliquez sur l'icône **crayon** (*Edit*).
2. GitHub crée automatiquement **votre copie** (fork) — modifiez, puis **Propose changes**.
3. Cliquez **Create pull request** et décrivez votre idée en une ou deux phrases. C'est tout.

Pour un simple **retour** (sans toucher au code), le plus rapide est d'ajouter quelques lignes
dans [`retours/`](retours/) — c'est aussi une pull request, mais sans rien casser.

## En local (si vous préférez git)

```bash
# sur VOTRE fork
git clone https://github.com/<votre-compte>/secu_tp.git
cd secu_tp
git checkout -b mon-amelioration
# ... vos modifications ...
git commit -am "TP1 : corrige la coquille dans la mission 2"
git push origin mon-amelioration
# puis "Compare & pull request" sur GitHub
```

## Ce qui aide à accepter vite une PR

- **Une idée par PR**, un titre clair.
- Expliquez le **pourquoi** en une phrase (ce qui vous a bloqué ou ce que ça améliore).
- Pour une coquille : la correction suffit.

## Règles simples

- Restez **courtois et constructifs**.
- **Pas de vraies données personnelles** ni de cibles réelles (RGPD) : on reste sur les cibles
  **fictives** du TP.
- Ne publiez pas de **solutions complètes** (flags, réponses) : laissez le défi aux autres.

Rappel : les énoncés **officiels** et la remise notée sont sur **Moodle**. Ce dépôt est informatif,
mais vos contributions, elles, servent pour de vrai aux promotions suivantes.
