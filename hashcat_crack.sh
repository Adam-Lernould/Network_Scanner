#!/bin/bash

# Vérification des paramètres d'utilisation
if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "\n\033[1;31m[!] Usage: $0 <fichier_hash> <fichier_wordlist>\033[0m"
    exit 1
fi

HASH_FILE="$1"
WORDLIST="$2"

if [ ! -f "$HASH_FILE" ]; then
    echo -e "\033[1;31m[✘] Le fichier de hash $HASH_FILE n'existe pas.\033[0m"
    exit 1
fi

if [ ! -f "$WORDLIST" ]; then
    echo -e "\033[1;31m[✘] Le fichier de wordlist $WORDLIST n'existe pas.\033[0m"
    exit 1
fi

# Fonction pour sélectionner le type de hash
select_hash_type() {
    echo "============================================================"
    echo " Choisissez le type de hash :"
    echo "------------------------------------------------------------"
    echo " 1. MD5"
    echo " 2. SHA-1"
    echo " 3. SHA-256"
    echo " 4. SHA-512"
    echo " 5. NTLM"
    echo " 6. NTLMv2"
    echo " 7. bcrypt"
    echo " 8. WPA/WPA2"
    echo " 9. PDF 128-bit"
    echo "10. Kerberos 5 AS-REP"
    echo "============================================================"
    while true; do
        read -p "→ Entrez le numéro correspondant (défaut 1 - MD5): " CHOICE
        case "$CHOICE" in
            ""|1) HASH_TYPE=0; break ;;
            2) HASH_TYPE=100; break ;;
            3) HASH_TYPE=1400; break ;;
            4) HASH_TYPE=1800; break ;;
            5) HASH_TYPE=500; break ;;
            6) HASH_TYPE=1000; break ;;
            7) HASH_TYPE=3200; break ;;
            8) HASH_TYPE=12400; break ;;
            9) HASH_TYPE=7400; break ;;
            10) HASH_TYPE=1300; break ;;
            *) echo "⛔ Choix invalide. Veuillez entrer un numéro entre 1 et 10." ;;
        esac
    done
}

# Fonction pour sélectionner le mode d'attaque
select_attack_mode() {
    echo "============================================================"
    echo " Choisissez le mode d'attaque :"
    echo "------------------------------------------------------------"
    echo " 1. Dictionary         → Essaye chaque mot d'une wordlist (le plus utilisé)"
    echo " 2. Combination        → Combine deux wordlists pour créer des mots complexes"
    echo " 3. Brute-force        → Teste toutes les combinaisons possibles (lent)"
    echo " 4. Hybrid dict + mask → Ajoute un masque (ex: chiffres) à chaque mot"
    echo " 5. Hybrid mask + dict → Ajoute une wordlist à un masque (rarement utilisé)"
    echo "============================================================"
    while true; do
        read -p "→ Entrez le numéro correspondant (défaut 1): " CHOICE
        case "$CHOICE" in
            ""|1) ATTACK_MODE=0; break ;;
            2) ATTACK_MODE=1; break ;;
            3) ATTACK_MODE=3; break ;;
            4) ATTACK_MODE=6; break ;;
            5) ATTACK_MODE=7; break ;;
            *) echo "⛔ Choix invalide. Veuillez entrer un numéro entre 1 et 5." ;;
        esac
    done
}

# Fonction de confirmation (y/n)
select_yes_no() {
    local prompt="$1"
    local default="$2"
    read -p "$prompt (y/n, défaut: $default): " CHOICE
    case "$CHOICE" in
        y|Y) echo "y" ;;
        n|N) echo "n" ;;
        *) echo "$default" ;;
    esac
}

# Configuration
OPTIONS=""
select_hash_type
OPTIONS="$OPTIONS -m $HASH_TYPE"
select_attack_mode
OPTIONS="$OPTIONS -a $ATTACK_MODE"

USE_INCREMENT=$(select_yes_no "→ Activer l'incrémentation ?" "n")
if [ "$USE_INCREMENT" == "y" ]; then
    read -p "   Longueur minimale (défaut: 6): " INC_MIN
    read -p "   Longueur maximale (défaut: 12): " INC_MAX
    INC_MIN=${INC_MIN:-6}
    INC_MAX=${INC_MAX:-12}
    OPTIONS="$OPTIONS --increment --increment-min $INC_MIN --increment-max $INC_MAX"
fi

USE_RULES=$(select_yes_no "→ Activer des règles de transformation ?" "n")
if [ "$USE_RULES" == "y" ]; then
    read -p "   Fichier de règle (défaut: rules/best64.rule): " RULE_FILE
    RULE_FILE=${RULE_FILE:-rules/best64.rule}
    if [ -f "$RULE_FILE" ]; then
        OPTIONS="$OPTIONS -r $RULE_FILE"
    else
        echo -e "\033[1;33m[!] Le fichier de règle '$RULE_FILE' est introuvable. Ignoré.\033[0m"
    fi
fi

mkdir -p reports
chmod 777 reports

REPORT_FILE="reports/hashcat_crack_report_$(date +%Y%m%d_%H%M%S).txt"

echo -e "\n\033[1;34m[+] Lancement de Hashcat avec les options :\033[0m"
echo "------------------------------------------------------------"
echo -e "\033[1;32mhashcat \"$HASH_FILE\" \"$WORDLIST\" $OPTIONS --force --remove | tee \"$REPORT_FILE\"\033[0m"
echo "------------------------------------------------------------"

hashcat "$HASH_FILE" "$WORDLIST" $OPTIONS --force --remove | tee "$REPORT_FILE"
chmod 664 "$REPORT_FILE"

if [ -f "$REPORT_FILE" ]; then
    echo -e "\n\033[1;36m[+] Résultat :\033[0m"
    cat "$REPORT_FILE"
else
    echo -e "\033[1;31m[!] Le rapport n'a pas pu être généré (vérifiez les permissions).\033[0m"
fi

echo -e "\n\033[1;32m✔ Crack terminé. Rapport enregistré dans $REPORT_FILE\033[0m"
