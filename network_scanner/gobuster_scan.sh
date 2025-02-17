#!/bin/bash

# Vérifie si l'utilisateur a fourni une cible et une wordlist
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <target> <wordlist>"
    exit 1
fi

TARGET=$1
WORDLIST=$2

# Créer le répertoire de rapport s'il n'existe pas
mkdir -p reports

# Nom du fichier de rapport avec horodatage
REPORT_FILE="reports/gobuster_scan_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting Gobuster scan on $TARGET with wordlist $WORDLIST"
gobuster dir -u $TARGET -w $WORDLIST -o "$REPORT_FILE"
echo "Gobuster scan completed. Report saved as $REPORT_FILE"

