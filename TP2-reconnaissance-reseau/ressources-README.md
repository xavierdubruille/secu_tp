# Ressources — cibles du TP2 (réseau d'ACME)

> Tout ce qu'il faut pour **faire tourner** les cibles du TP2. À lancer dans la VM Kali de l'étudiant.
> **Doc prof** pour l'origine/les licences ; l'étudiant n'a besoin que de la section « Lancer ».

## Lancer

```bash
# Réseau d'ACME (7 cibles, 2 segments) — missions 1 et 2
MATRICULE=<votre_matricule> docker compose up -d
# ... TP ...
docker compose down

# Serveur exposé vulnérable (Apache 2.4.49) — mission 3
cd apache-cve && docker compose up -d --build        # http://127.0.0.1:8080
docker compose down
```

Depuis Kali, on **scanne directement les sous-réseaux Docker** (`172.21.0.0/24`, `172.22.0.0/24`) :
les cibles ne publient **aucun port** (elles ne sont **pas** exposées hors de la VM). La mission 4
(Metasploitable2, optionnelle) se lance à la demande — voir l'énoncé.

## Origine et licences (important)

Ces cibles sont des **copies adaptées** de laboratoires **open source**, pour garantir la disponibilité
hors-ligne et pouvoir traduire/raccourcir l'énoncé. Les **originaux intacts** vivent dans
`../../../70-labos-sources/` (base de connaissances prof).

| Ce qu'on utilise | Origine | Licence | Fichier |
|---|---|---|---|
| `cibles/` (web, ssh, redis, silent, smb, db, snmp) | **Michael Borck — Ethical Hacking Docker Labs** (week4 + week5) | **MIT** | `LICENSE.borck-MIT` |
| `apache-cve/` (Apache 2.4.49, CVE-2021-41773) | **vulhub** | **MIT** | `LICENSE.vulhub-MIT` |
| mission 4 (optionnelle) | **Metasploitable 2** (Rapid7) — image **référencée**, non redistribuée | — | — |

> **MIT** : réutilisation/traduction/redistribution libres **à condition de conserver la notice de
> copyright + la licence** → c'est le rôle des fichiers `LICENSE.*-MIT` de ce dossier, qui doivent
> **rester** à côté des cibles (y compris dans la copie publiée aux étudiants).

## Adaptations par rapport aux originaux (et pourquoi)

- **Sans conteneur `attacker`** : l'étudiant attaque depuis **sa** VM Kali (donc pas de `make
  build-base` ni d'`apt` au démarrage côté attaquant).
- **Sans LDAP** : retiré du périmètre pédagogique du TP2 (concept non vu par les étudiants).
- **Sans ports publiés** : cibles non exposées hors VM (cadre légal) ; on scanne le sous-réseau Docker.
- **`ssh` cuit** : openssh installé **au build** (`cibles/ssh/Dockerfile`) → **aucune dépendance
  internet** en séance.
- Les **seeds** (partages SMB, `init.sql`, `public.snmprec`, page web) sont **copiés verbatim** de borck
  (non modifiés) pour ne pas casser le comportement éprouvé.

## Pré-charger les images (séance hors-ligne)

```bash
./charger-images.sh            # construit/pull puis exporte un tar.gz à distribuer (clé/partage)
./charger-images.sh --load tp2-images.tar.gz    # côté poste étudiant : importe
```
