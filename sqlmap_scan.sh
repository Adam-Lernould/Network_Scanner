#!/bin/bash

# Vérifie si l'utilisateur a fourni une URL cible
if [ -z "$1" ]; then
    echo "Usage: $0 <target_url> [risk] [level]"
    exit 1
fi

TARGET=$1
RISK=${2:-1}  # Valeur par défaut : 1
LEVEL=${3:-1} # Valeur par défaut : 1

# Validation des paramètres
if ! [[ "$RISK" =~ ^[1-3]$ ]]; then
    echo "Erreur : Le niveau de risque doit être entre 1 et 3."
    exit 1
fi

if ! [[ "$LEVEL" =~ ^[1-5]$ ]]; then
    echo "Erreur : Le niveau de test doit être entre 1 et 5."
    exit 1
fi

# Créer le répertoire de rapport
REPORT_DIR="reports/sqlmap_scan_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$REPORT_DIR"

echo "Starting SQLmap scan on $TARGET (risk=$RISK, level=$LEVEL)"
sqlmap -u "$TARGET" --batch --risk="$RISK" --level="$LEVEL" --output-dir="$REPORT_DIR"

# Renommer le fichier de log
LOG_FILE="$REPORT_DIR/log"
if [ -f "$LOG_FILE" ]; then
    mv "$LOG_FILE" "$REPORT_DIR/sqlmap_report.txt"
fi

echo "SQLmap scan completed. Report saved in $REPORT_DIR"