#!/usr/bin/env bash
# Contrôle AVANT le TP : ne télécharge, n'installe et ne démarre rien.
set -euo pipefail
cd "$(dirname "$0")"
missing=0
for tool in docker nmap smbclient mysql snmpwalk tshark curl nc ip timeout; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'MANQUANT : %s\n' "$tool"
    missing=1
  fi
done
if ! command -v searchsploit >/dev/null 2>&1; then
  printf 'INFO : searchsploit absent ; utiliser le guide Vulhub et l’avis Apache pour M3.\n'
fi
if ! command -v docker >/dev/null 2>&1; then
  printf 'Préparation de la VM à terminer avant la séance.\n'
  exit 1
fi
if ! docker compose version >/dev/null 2>&1; then
  printf 'MANQUANT : Docker Compose v2 (docker compose). Appeler le professeur.\n'
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  printf 'Docker inaccessible : service démarré et droits de votre session à vérifier.\n'
  exit 1
fi
docker compose config --quiet
docker compose -f apache-cve/docker-compose.yml config --quiet
if (( missing )); then
  printf 'Arrêt : préparer les outils avant le travail. Voir ressources-README.md.\n'
  exit 1
fi
absent=0
while IFS= read -r img; do
  if ! docker image inspect "$img" >/dev/null 2>&1; then
    printf 'À TÉLÉCHARGER : %s\n' "$img"
    absent=1
  fi
done < <(docker compose config --images; docker compose -f apache-cve/docker-compose.yml config --images)
if (( absent )); then
  printf 'OK : outils et Docker présents. Images absentes : le premier lancement les télécharge (connexion requise).\n'
else
  printf 'OK : outils, Docker et images du tronc commun présents.\n'
fi
printf 'Démarrer : docker compose up -d\n'
printf 'MySQL et Samba peuvent demander environ 90 secondes au premier lancement.\n'

if [[ "${1:-}" == "--pret" ]]; then
  printf 'Attente des services du réseau ACME (environ 90 s)...\n'
  deadline_tp2=$(( SECONDS + 90 ))
  while (( SECONDS < deadline_tp2 )); do
    ready_tp2=1
    for endpoint_tp2 in 172.21.0.10:80 172.21.0.11:22 172.21.0.13:6379 172.22.0.12:3306 172.22.0.13:445; do
      host_tp2="${endpoint_tp2%:*}"; port_tp2="${endpoint_tp2##*:}"
      if ! timeout 1 bash -c 'exec 3<>/dev/tcp/"$1"/"$2"' _ "$host_tp2" "$port_tp2" 2>/dev/null; then
        ready_tp2=0
      fi
    done
    if ! snmpwalk -t 1 -r 0 -v2c -c public 172.22.0.14 1.3.6.1.2.1.1.1.0 >/dev/null 2>&1; then
      ready_tp2=0
    fi
    if (( ready_tp2 )); then
      printf 'OK : web, SSH, Redis, MySQL, SMB et SNMP répondent. L’hôte discret n’a pas de service.\n'
      exit 0
    fi
    sleep 2
  done
  printf 'Un service ne répond pas : montrer docker compose ps / logs au professeur.\n'
  exit 1
fi
