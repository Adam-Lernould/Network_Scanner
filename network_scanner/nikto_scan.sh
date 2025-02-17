#!/bin/bash

# Vérifie si l'utilisateur a fourni une cible
if [ -z "$1" ]; then
    echo "Usage: $0 <target>"
    exit 1
fi

TARGET=$1

# Créer le répertoire de rapport s'il n'existe pas
mkdir -p reports

# Nom du fichier de rapport avec horodatage
REPORT_FILE="reports/nikto_scan_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting Nikto scan on $TARGET"
nikto -h $TARGET -Format txt -output "$REPORT_FILE"
echo "Nikto scan completed. Report saved as $REPORT_FILE"

