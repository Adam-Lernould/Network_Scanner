#!/bin/bash

# Vérifie si l'utilisateur a fourni une cible
if [ -z "$1" ]; then
    echo "Usage: $0 <target_url>"
    exit 1
fi

TARGET=$1

# Créer le répertoire de rapport s'il n'existe pas
mkdir -p reports

# Nom du fichier de rapport avec horodatage
REPORT_FILE="reports/whatweb_scan_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting WhatWeb scan on $TARGET"
whatweb -v $TARGET | tee "$REPORT_FILE"
echo "WhatWeb scan completed. Report saved as $REPORT_FILE"
