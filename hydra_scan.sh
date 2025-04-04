#!/bin/bash

# Vérifie si les arguments sont fournis
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
    echo "Usage: $0 <target> <service> <userlist> <passlist>"
    echo "Exemple: $0 192.168.1.1 http data/users.txt data/passwords.txt"
    exit 1
fi

TARGET=$1
SERVICE=$2
USERLIST=$3
PASSLIST=$4

# Vérifie si les fichiers de listes existent
if [ ! -f "$USERLIST" ]; then
    echo "Erreur : Le fichier d'utilisateurs $USERLIST n'existe pas."
    exit 1
fi

if [ ! -f "$PASSLIST" ]; then
    echo "Erreur : Le fichier de mots de passe $PASSLIST n'existe pas."
    exit 1
fi

# Crée le répertoire de rapports s'il n'existe pas
mkdir -p reports

# Nom du fichier de rapport avec horodatage
REPORT_FILE="reports/hydra_scan_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting Hydra brute force on $TARGET for service $SERVICE"
echo "Userlist: $USERLIST"
echo "Passlist: $PASSLIST"

# Exécute Hydra avec les listes d'utilisateurs et de mots de passe
hydra -L "$USERLIST" -P "$PASSLIST" "$TARGET" "$SERVICE" -o "$REPORT_FILE"

echo "Hydra scan completed. Report saved as $REPORT_FILE"
