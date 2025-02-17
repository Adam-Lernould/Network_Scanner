#!/bin/bash

# Vérifie si l'utilisateur a fourni une cible
if [ -z "$1" ]; then
    echo "Usage: $0 <target> [options] [scripts]"
    exit 1
fi

TARGET=$1
OPTIONS=${2:-""}  # Options par défaut
SCRIPTS=${3:-""}

# Créer le répertoire de rapport s'il n'existe pas
mkdir -p reports

# Nom du fichier de rapport avec horodatage
REPORT_FILE="reports/nmap_scan_report_$(date +%Y%m%d_%H%M%S).txt"

echo "Starting Nmap scan on $TARGET with options: $OPTIONS and scripts: $SCRIPTS"
nmap $OPTIONS --script=$SCRIPTS $TARGET -oN "$REPORT_FILE"
echo "Nmap scan completed. Report saved as $REPORT_FILE"

