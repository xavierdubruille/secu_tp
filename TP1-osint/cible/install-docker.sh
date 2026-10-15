#!/usr/bin/env bash
# TP1 - installe Docker + compose sur Kali/Debian, une seule fois.
# Usage : bash install-docker.sh
set -euo pipefail

if command -v docker >/dev/null 2>&1; then
  echo "[=] Docker est deja installe : $(docker --version)"
else
  echo "[*] Installation de Docker (apt)..."
  sudo apt update
  sudo apt install -y docker.io docker-compose
fi

echo "[*] Demarrage du service Docker..."
sudo systemctl enable --now docker

echo "[*] Ajout de $USER au groupe docker (pour eviter sudo)..."
sudo usermod -aG docker "$USER"

echo
echo "[OK] Termine."
echo "    -> Deconnecte/reconnecte ta session (ou lance : newgrp docker)"
echo "       pour utiliser 'docker' sans sudo."
echo "    -> Ensuite : cd TP1-osint/cible && docker compose up -d && docker ps"
echo "       (selon la version : 'docker compose' avec espace, ou 'docker-compose' avec tiret)"
