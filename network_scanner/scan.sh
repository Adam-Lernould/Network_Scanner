#!/bin/bash

# Nettoyer le terminal
clear

# ASCII Art
cat << 'EOF'
 _   _      _                      _        _____
| \ | |    | |                    | |      /  ___|
|  \| | ___| |___      _____  _ __| | __   \ `--.  ___ __ _ _ __  _ __   ___ _ __
| . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ /    `--. \/ __/ _` | '_ \| '_ \ / _ \ '__|
| |\  |  __/ |_ \ V  V / (_) | |  |   <    /\__/ / (_| (_| | | | | | |  __/ |
|_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\   \____/ \___\__,_|_| |_|_| |_|\___|_

EOF

# Fonction pour afficher le menu principal
show_menu() {
    echo "Choisissez un outil de scan ou tapez 'exit' pour quitter :"
    echo "1. Netdiscover"
    echo "2. Nmap"
    echo "3. Nikto"
    echo "4. Gobuster"
}

# Fonction pour afficher les options Nmap suggérées
show_nmap_options() {
    echo "Options Nmap suggérées :"
    echo "1. -sV (Détection de version)"
    echo "2. -O (Détection du système d'exploitation)"
    echo "3. -sS (Scan SYN)"
    echo "4. -A (Scan agressif)"
    echo "5. -Pn (Scan sans ping)"
    echo "6. Aucune"
}

# Fonction pour afficher les scripts NSE suggérés
show_nmap_scripts() {
    echo "Scripts NSE suggérés :"
    echo "1. http-title"
    echo "2. ssl-enum-ciphers"
    echo "3. dns-brute"
    echo "4. vuln"
    echo "5. smb-os-discovery"
    echo "6. ftp-anon"
    echo "7. http-sql-injection"
    echo "8. Aucun"
}

# Fonction pour afficher les options Netdiscover suggérées
show_netdiscover_options() {
    echo "Options Netdiscover suggérées :"
    echo "1. -i (Interface réseau)"
    echo "2. -r (Plage d'adresses IP)"
    echo "3. -l (Nom de fichier pour les résultats)"
    echo "4. -F (Filtrer les résultats)"
    echo "5. Aucune"
}

# Fonction pour exécuter Netdiscover
run_netdiscover() {
    # Options Netdiscover
    show_netdiscover_options
    read -p "Choisissez les options (numéros séparés par des espaces, ou '5' pour aucune): " OPTION_CHOICES
    OPTIONS=""
    for choice in $OPTION_CHOICES; do
        case $choice in
            1) read -p "Entrez l'interface réseau (ex: eth0): " INTERFACE; OPTIONS="$OPTIONS -i $INTERFACE" ;;
            2) read -p "Entrez la plage d'adresses IP (ex: 192.168.1.0/24): " RANGE; OPTIONS="$OPTIONS -r $RANGE" ;;
            3) read -p "Entrez le nom de fichier pour les résultats (ex: results.txt): " FILE; OPTIONS="$OPTIONS -l $FILE" ;;
            4) read -p "Entrez le filtre (ex: nom_du_filtre): " FILTER; OPTIONS="$OPTIONS -F $FILTER" ;;
            5) OPTIONS="$OPTIONS" ;;
            *) echo "Option invalide: $choice" ;;
        esac
    done

    echo "Starting Netdiscover scan with options: $OPTIONS"
    netdiscover $OPTIONS
}

# Fonction pour exécuter Nmap
run_nmap() {
    read -p "Entrez la cible (IP/URL): " TARGET

    # Options Nmap
    show_nmap_options
    read -p "Choisissez les options (numéros séparés par des espaces, ou '6' pour aucune): " OPTION_CHOICES
    OPTIONS=""
    for choice in $OPTION_CHOICES; do
        case $choice in
            1) OPTIONS="$OPTIONS -sV" ;;
            2) OPTIONS="$OPTIONS -O" ;;
            3) OPTIONS="$OPTIONS -sS" ;;
            4) OPTIONS="$OPTIONS -A" ;;
            5) OPTIONS="$OPTIONS -Pn" ;;
            6) OPTIONS="$OPTIONS" ;;
            *) echo "Option invalide: $choice" ;;
        esac
    done

    # Scripts NSE
    read -p "Activer les scripts NSE? (y/n): " ENABLE_SCRIPTS
    SCRIPTS=""
    if [ "$ENABLE_SCRIPTS" == "y" ]; then
        show_nmap_scripts
        read -p "Choisissez les scripts (numéros séparés par des espaces, ou '8' pour aucun): " SCRIPT_CHOICES
        for script in $SCRIPT_CHOICES; do
            case $script in
                1) [ -z "$SCRIPTS" ] && SCRIPTS="http-title" || SCRIPTS="$SCRIPTS,http-title" ;;
                2) [ -z "$SCRIPTS" ] && SCRIPTS="ssl-enum-ciphers" || SCRIPTS="$SCRIPTS,ssl-enum-ciphers" ;;
                3) [ -z "$SCRIPTS" ] && SCRIPTS="dns-brute" || SCRIPTS="$SCRIPTS,dns-brute" ;;
                4) [ -z "$SCRIPTS" ] && SCRIPTS="vuln" || SCRIPTS="$SCRIPTS,vuln" ;;
                5) [ -z "$SCRIPTS" ] && SCRIPTS="smb-os-discovery" || SCRIPTS="$SCRIPTS,smb-os-discovery" ;;
                6) [ -z "$SCRIPTS" ] && SCRIPTS="ftp-anon" || SCRIPTS="$SCRIPTS,ftp-anon" ;;
                7) [ -z "$SCRIPTS" ] && SCRIPTS="http-sql-injection" || SCRIPTS="$SCRIPTS,http-sql-injection" ;;
                8) SCRIPTS="$SCRIPTS" ;;
                *) echo "Script invalide: $script" ;;
            esac
        done
    fi

    # Créer le répertoire de rapport s'il n'existe pas
    mkdir -p reports

    # Chemin du fichier de rapport avec horodatage
    REPORT_FILE="reports/nmap_scan_report_$(date +%Y%m%d_%H%M%S).txt"

    echo "Starting Nmap scan on $TARGET with options: $OPTIONS and scripts: $SCRIPTS"
    nmap $OPTIONS --script=$SCRIPTS $TARGET -oN "$REPORT_FILE"
    echo "Nmap scan completed. Report saved as $REPORT_FILE"
}

# Fonction pour exécuter Nikto
run_nikto() {
    read -p "Entrez la cible (IP/URL): " TARGET
    ./nikto_scan.sh $TARGET
}

# Fonction pour exécuter Gobuster
run_gobuster() {
    read -p "Entrez la cible (IP/URL): " TARGET
    read -p "Entrez le chemin vers la wordlist: " WORDLIST
    ./gobuster_scan.sh $TARGET $WORDLIST
}

# Boucle principale
while true; do
    show_menu
    read -p "Choisissez une option (1-4) ou tapez 'exit' pour quitter: " CHOICE
    case $CHOICE in
        1) run_netdiscover ;;
        2) run_nmap ;;
        3) run_nikto ;;
        4) run_gobuster ;;
        exit) echo "Au revoir!"; break ;;
        *) echo "Option invalide. Veuillez réessayer." ;;
    esac
done

