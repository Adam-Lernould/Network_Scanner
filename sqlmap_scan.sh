#!/bin/bash

# Vérifie si l'utilisateur a fourni une URL cible
if [ -z "$1" ]; then
    echo "Usage: $0 <target_url> <port> [risk] [level]"
    exit 1
fi

TARGET=$1
PORT=${2:-80}  # Valeur par défaut : 80
RISK=${3:-1}  # Valeur par défaut : 1
LEVEL=${4:-1} # Valeur par défaut : 1

# Validation des paramètres
if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
    echo "Erreur : Le port doit être un nombre."
    exit 1
fi

if ! [[ "$RISK" =~ ^[1-3]$ ]]; then
    echo "Erreur : Le niveau de risque doit être entre 1 et 3."
    exit 1
fi

if ! [[ "$LEVEL" =~ ^[1-5]$ ]]; then
    echo "Erreur : Le niveau de test doit être entre 1 et 5."
    exit 1
fi

# Construire l'URL avec le port
FULL_TARGET="${TARGET%/}:${PORT}"

# Créer le répertoire de rapport
REPORT_DIR="reports/sqlmap_scan_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$REPORT_DIR"

echo "Starting SQLmap scan on $FULL_TARGET (risk=$RISK, level=$LEVEL)"
sqlmap -u "$FULL_TARGET" --batch --risk="$RISK" --level="$LEVEL" --output-dir="$REPORT_DIR"

# Renommer le fichier de log
LOG_FILE="$REPORT_DIR/log"
if [ -f "$LOG_FILE" ]; then
    mv "$LOG_FILE" "$REPORT_DIR/sqlmap_report.txt"
fi

echo "SQLmap scan completed. Report saved in $REPORT_DIR"
