#!/bin/bash

# Vérifie si l'utilisateur a fourni une cible
if [ -z "$1" ]; then
    echo "Usage: $0 <target> [wordlist]"
    echo "Exemple: $0 http://192.168.1.27"
    echo "Exemple: $0 http://example.com /chemin/custom_wordlist.txt"
    exit 1
fi

TARGET=$1
WORDLIST=${2:-"data/gobuster.txt"}  # Utilise data/gobuster.txt par défaut

# Vérifier si la wordlist existe
if [ ! -f "$WORDLIST" ]; then
    echo "Erreur : Le fichier de wordlist $WORDLIST n'existe pas."
    exit 1
fi

# Créer le répertoire de rapport
mkdir -p reports

# Nom du fichier de rapport avec horodatage
REPORT_FILE="reports/gobuster_scan_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting Gobuster scan on $TARGET"
echo "Wordlist utilisée : $WORDLIST"
gobuster dir -u "$TARGET" -w "$WORDLIST" -o "$REPORT_FILE"
echo "Gobuster scan completed. Rapport : $REPORT_FILE"