#!/usr/bin/env bash
# Pré-chargement des images du TP2 pour une séance HORS-LIGNE.
#   ./charger-images.sh                 -> build + pull, puis exporte tp2-images.tar.gz
#   ./charger-images.sh --load <fichier> -> importe les images (côté poste étudiant)
# À lancer depuis le dossier ressources/.
set -euo pipefail
cd "$(dirname "$0")"

OUT="tp2-images.tar.gz"

# Images tierces (pullées telles quelles).
PULL=(
  httpd:2.4
  redis:7
  alpine:3.22
  mysql:8.0.43
  tandrup/snmpsim:v0.4
  tleemcjr/metasploitable2          # mission 4 (optionnelle)
)
# Images construites localement (cf. Dockerfiles).
SAMBA_ORIGIN="ghcr.io/servercontainers/samba@sha256:1215a7322d5f1c297b91d47fb3688c3e7f1eaccb2a34d99d42059e23a15bd02d"
SAMBA_LOCAL="tp2-acme-smb:20261020"
BUILT=( tp2-acme-ssh:latest tp2-acme-apache-2449:latest "$SAMBA_LOCAL" )

if [[ "${1:-}" == "--load" ]]; then
  FILE="${2:-$OUT}"
  echo "Import des images depuis $FILE ..."
  docker load -i "$FILE"
  echo "OK. Lancer ensuite :  docker compose up -d --no-build --pull never   (et apache-cve/ pour M3)."
  exit 0
fi

# Un tag nommé est conservé dans l’archive ; le digest distant seul ne constitue
# pas un nom de distribution hors ligne fiable sur un nouveau démon Docker.
docker pull "$SAMBA_ORIGIN"
docker tag "$SAMBA_ORIGIN" "$SAMBA_LOCAL"

echo "== build des cibles locales =="
docker compose build ssh                       # tp2-acme-ssh:latest
docker compose -f apache-cve/docker-compose.yml build   # tp2-acme-apache-2449:latest

echo "== pull des images tierces =="
for img in "${PULL[@]}"; do
  echo "  - $img"
  docker pull "$img" >/dev/null
done

echo "== export -> $OUT =="
docker save "${PULL[@]}" "${BUILT[@]}" | gzip > "$OUT"
echo "OK : $OUT ($(du -h "$OUT" | cut -f1)). À distribuer (clé USB / partage) puis :"
echo "    ./charger-images.sh --load $OUT"
