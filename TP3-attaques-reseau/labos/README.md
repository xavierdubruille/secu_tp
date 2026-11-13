# Labsetup des trois labos SEED du TP3

Copie non modifiée des archives officielles `Labsetup.zip`, téléchargées le 13/11/2026 :

| Dossier | Archive d'origine |
|---|---|
| `ARP_Attack/Labsetup/` | https://seedsecuritylabs.org/Labs_20.04/Files/ARP_Attack/Labsetup.zip |
| `DNS_Local/Labsetup/` | https://seedsecuritylabs.org/Labs_20.04/Files/DNS_Local/Labsetup.zip |
| `TCP_Attacks/Labsetup/` | https://seedsecuritylabs.org/Labs_20.04/Files/TCP_Attacks/Labsetup.zip |

Seule différence : un fichier temporaire d'éditeur (`.docker-compose.yml.swp`) oublié dans l'archive TCP a été retiré.

Pour les placer là où l'énoncé les attend (`~/tp3/<labo>/Labsetup`) :

```bash
mkdir -p ~/tp3
cp -r ~/secu_tp/TP3-attaques-reseau/labos/. ~/tp3/
```

## Attribution

Source : **SEED Labs** (CC BY-NC-SA 4.0), Wenliang Du, https://seedsecuritylabs.org. Redistribué sans modification, à des fins pédagogiques (EPHEC).
