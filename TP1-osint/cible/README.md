# Cible TP1 - ACME-BE (PME fictive)

Empreinte numérique d'une PME **fictive**, pour l'exercice OSINT. 100% local, aucune vraie personne.

## Lancer
```bash
docker compose up -d        # sert le site sur http://localhost:8080
docker compose down         # arrêter
```

## Contenu
- `site/` : vitrine (Accueil, Équipe, Blog, Contact) + `robots.txt` + `/interne-old/` + `files/` + `webmail.html` (portail de login, cloné par SET en mission 6).
- `site/files/` : photos (EXIF/GPS), PDF et DOCX (métadonnées), `logo.png` (surprise), `notes.txt`, `qr.png`.
- `nginx.conf` : site par défaut + **directory listing** sur `/files/` (la « médiathèque » de l'accueil).

À vous d'explorer cette empreinte et d'y récolter les indices — voir l'énoncé du TP.
