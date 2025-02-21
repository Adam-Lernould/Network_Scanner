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
    echo "1. Netdiscover (Découverte d'hôtes sur le réseau local)"
    echo "2. Nmap (Scan de ports et détection de services)"
    echo "3. Nikto (Scan de vulnérabilités web)"
    echo "4. Gobuster (Énumération de répertoires web)"
    echo "5. Hydra (Brute force sur les services réseau)"
    echo "6. SQLmap (Détection d'injections SQL)"
}

# Fonction pour afficher les options Nmap suggérées avec explications
show_nmap_options() {
    echo "Options Nmap suggérées :"
    echo "1. -sV (Détection de version : Identifie les versions des services détectés)"
    echo "2. -O (Détection du système d'exploitation : Devine l'OS de la cible)"
    echo "3. -sS (Scan SYN : Scan furtif utilisant des paquets SYN)"
    echo "4. -A (Scan agressif : Active la détection de version, l'OS, et les scripts NSE)"
    echo "5. -Pn (Scan sans ping : Ignore la découverte d'hôte et scan directement les ports)"
    echo "6. -p (Spécifier les ports : Scan des ports spécifiques, ex: 80,443 ou 1-1000)"
    echo "7. -T4 (Vitesse du scan : Augmente la vitesse du scan, niveau 4 sur 5)"
    echo "8. -sU (Scan UDP : Scan les ports UDP, utiles pour DNS, SNMP, etc.)"
    echo "9. -sC (Exécuter les scripts par défaut : Active les scripts NSE par défaut)"
    echo "10. -v (Mode verbeux : Affiche plus de détails pendant le scan)"
    echo "11. -oA (Exporter les résultats : Exporte dans trois formats : normal, XML, et grepable)"
    echo "12. --top-ports (Scanner les ports les plus courants : Ex: --top-ports 100)"
    echo "13. Aucune"
}

# Fonction pour afficher les scripts NSE suggérés avec explications
show_nmap_scripts() {
    echo "Scripts NSE suggérés :"
    echo "1. http-title (Récupère le titre des pages web)"
    echo "2. ssl-enum-ciphers (Énumère les chiffrements SSL/TLS supportés)"
    echo "3. dns-brute (Force brute sur les sous-domaines DNS)"
    echo "4. vuln (Recherche des vulnérabilités connues)"
    echo "5. smb-os-discovery (Détecte l'OS via SMB)"
    echo "6. ftp-anon (Vérifie si le serveur FTP permet une connexion anonyme)"
    echo "7. http-sql-injection (Détecte les vulnérabilités d'injection SQL)"
    echo "8. http-enum (Énumère les répertoires et fichiers sur un serveur web)"
    echo "9. ssh-auth-methods (Détecte les méthodes d'authentification SSH supportées)"
    echo "10. smb-vuln-ms17-010 (Vérifie la vulnérabilité EternalBlue sur SMB)"
    echo "11. http-shellshock (Détecte la vulnérabilité Shellshock sur les serveurs web)"
    echo "12. dns-zone-transfer (Tente un transfert de zone DNS)"
    echo "13. http-wordpress-enum (Énumère les plugins et thèmes WordPress)"
    echo "14. http-cors (Vérifie les en-têtes CORS pour les vulnérabilités)"
    echo "15. http-robots.txt (Récupère le fichier robots.txt d'un serveur web)"
    echo "16. rdp-enum-encryption (Énumère les méthodes de chiffrement RDP)"
    echo "17. snmp-info (Récupère des informations via SNMP)"
    echo "18. Aucun"
}

# Fonction pour afficher les options Netdiscover suggérées
show_netdiscover_options() {
    echo "Options Netdiscover suggérées :"
    echo "1. -i (Interface réseau : Spécifie l'interface à utiliser)"
    echo "2. -r (Plage d'adresses IP : Scan une plage d'adresses spécifique)"
    echo "3. -l (Nom de fichier pour les résultats : Sauvegarde les résultats dans un fichier)"
    echo "4. -F (Filtrer les résultats : Applique un filtre sur les résultats)"
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
    read -p "Choisissez les options (numéros séparés par des espaces, ou '13' pour aucune): " OPTION_CHOICES
    OPTIONS=""
    for choice in $OPTION_CHOICES; do
        case $choice in
            1) OPTIONS="$OPTIONS -sV" ;;
            2) OPTIONS="$OPTIONS -O" ;;
            3) OPTIONS="$OPTIONS -sS" ;;
            4) OPTIONS="$OPTIONS -A" ;;
            5) OPTIONS="$OPTIONS -Pn" ;;
            6) read -p "Entrez les ports à scanner (ex: 80,443 ou 1-1000): " PORTS; OPTIONS="$OPTIONS -p $PORTS" ;;
            7) OPTIONS="$OPTIONS -T4" ;;
            8) OPTIONS="$OPTIONS -sU" ;;
            9) OPTIONS="$OPTIONS -sC" ;;
            10) OPTIONS="$OPTIONS -v" ;;
            11) OPTIONS="$OPTIONS -oA reports/nmap_scan_$(date +%Y%m%d_%H%M%S)" ;;
            12) read -p "Entrez le nombre de ports à scanner (ex: 100): " TOP_PORTS; OPTIONS="$OPTIONS --top-ports $TOP_PORTS" ;;
            13) OPTIONS="$OPTIONS" ;;
            *) echo "Option invalide: $choice" ;;
        esac
    done

    # Scripts NSE
    read -p "Activer les scripts NSE? (y/n): " ENABLE_SCRIPTS
    SCRIPTS=""
    if [ "$ENABLE_SCRIPTS" == "y" ]; then
        show_nmap_scripts
        read -p "Choisissez les scripts (numéros séparés par des espaces, ou '18' pour aucun): " SCRIPT_CHOICES
        for script in $SCRIPT_CHOICES; do
            case $script in
                1) [ -z "$SCRIPTS" ] && SCRIPTS="http-title" || SCRIPTS="$SCRIPTS,http-title" ;;
                2) [ -z "$SCRIPTS" ] && SCRIPTS="ssl-enum-ciphers" || SCRIPTS="$SCRIPTS,ssl-enum-ciphers" ;;
                3) [ -z "$SCRIPTS" ] && SCRIPTS="dns-brute" || SCRIPTS="$SCRIPTS,dns-brute" ;;
                4) [ -z "$SCRIPTS" ] && SCRIPTS="vuln" || SCRIPTS="$SCRIPTS,vuln" ;;
                5) [ -z "$SCRIPTS" ] && SCRIPTS="smb-os-discovery" || SCRIPTS="$SCRIPTS,smb-os-discovery" ;;
                6) [ -z "$SCRIPTS" ] && SCRIPTS="ftp-anon" || SCRIPTS="$SCRIPTS,ftp-anon" ;;
                7) [ -z "$SCRIPTS" ] && SCRIPTS="http-sql-injection" || SCRIPTS="$SCRIPTS,http-sql-injection" ;;
                8) [ -z "$SCRIPTS" ] && SCRIPTS="http-enum" || SCRIPTS="$SCRIPTS,http-enum" ;;
                9) [ -z "$SCRIPTS" ] && SCRIPTS="ssh-auth-methods" || SCRIPTS="$SCRIPTS,ssh-auth-methods" ;;
                10) [ -z "$SCRIPTS" ] && SCRIPTS="smb-vuln-ms17-010" || SCRIPTS="$SCRIPTS,smb-vuln-ms17-010" ;;
                11) [ -z "$SCRIPTS" ] && SCRIPTS="http-shellshock" || SCRIPTS="$SCRIPTS,http-shellshock" ;;
                12) [ -z "$SCRIPTS" ] && SCRIPTS="dns-zone-transfer" || SCRIPTS="$SCRIPTS,dns-zone-transfer" ;;
                13) [ -z "$SCRIPTS" ] && SCRIPTS="http-wordpress-enum" || SCRIPTS="$SCRIPTS,http-wordpress-enum" ;;
                14) [ -z "$SCRIPTS" ] && SCRIPTS="http-cors" || SCRIPTS="$SCRIPTS,http-cors" ;;
                15) [ -z "$SCRIPTS" ] && SCRIPTS="http-robots.txt" || SCRIPTS="$SCRIPTS,http-robots.txt" ;;
                16) [ -z "$SCRIPTS" ] && SCRIPTS="rdp-enum-encryption" || SCRIPTS="$SCRIPTS,rdp-enum-encryption" ;;
                17) [ -z "$SCRIPTS" ] && SCRIPTS="snmp-info" || SCRIPTS="$SCRIPTS,snmp-info" ;;
                18) SCRIPTS="$SCRIPTS" ;;
                *) echo "Script invalide: $script" ;;
            esac
        done
    fi

    # Exécuter le script nmap_scan.sh
    echo "Starting Nmap scan on $TARGET with options: $OPTIONS and scripts: $SCRIPTS"
    ./nmap_scan.sh "$TARGET" "$OPTIONS" "$SCRIPTS"
}

# Fonction pour exécuter Nikto
run_nikto() {
    read -p "Entrez la cible (IP/URL): " TARGET
    ./nikto_scan.sh "$TARGET"
}

# Fonction pour exécuter Gobuster
run_gobuster() {
    echo "Choisissez le type de cible :"
    echo "1. Adresse IP"
    echo "2. URL"
    read -p "Entrez votre choix (1 ou 2): " TARGET_TYPE

    if [ "$TARGET_TYPE" == "1" ]; then
        read -p "Entrez l'adresse IP (ex: 192.168.1.27): " TARGET
    elif [ "$TARGET_TYPE" == "2" ]; then
        read -p "Entrez l'URL (ex: http://example.com): " TARGET
    else
        echo "Choix invalide. Utilisation de l'adresse IP par défaut."
        read -p "Entrez l'adresse IP (ex: 192.168.1.27): " TARGET
    fi

    # Chemin par défaut
    DEFAULT_WORDLIST="data/gobuster.txt"
    
    # Demander la wordlist
    read -p "Entrez le chemin vers la wordlist [défaut: $DEFAULT_WORDLIST]: " WORDLIST
    WORDLIST=${WORDLIST:-$DEFAULT_WORDLIST}

    # Vérifier l'existence du fichier
    if [ ! -f "$WORDLIST" ]; then
        echo "Erreur : Fichier $WORDLIST introuvable!"
        return
    fi

    # Lancer le scan
    echo -e "\n=== Lancement de Gobuster ==="
    ./gobuster_scan.sh "$TARGET" "$WORDLIST"
}


# Fonction pour exécuter Hydra
run_hydra() {
    read -p "Entrez la cible (IP/URL): " TARGET

    # Demander le service à utiliser
    echo "Choisissez le service :"
    echo "1. http-get   - Attaque brute force sur les requêtes HTTP GET (par exemple, les pages web simples)."
    echo "2. http-post  - Attaque brute force sur les requêtes HTTP POST (par exemple, les formulaires de connexion)."
    echo "3. ftp        - Attaque brute force sur le service FTP (File Transfer Protocol)."
    echo "4. ssh        - Attaque brute force sur le service SSH (Secure Shell)."
    read -p "Entrez le numéro du service (1-4): " SERVICE_CHOICE

    case $SERVICE_CHOICE in
        1) SERVICE="http-get" ;;
        2) SERVICE="http-post" ;;
        3) SERVICE="ftp" ;;
        4) SERVICE="ssh" ;;
        *) echo "Choix invalide. Utilisation de http-get par défaut."; SERVICE="http-get" ;;
    esac

    # Demander le port (par défaut : 80 pour HTTP, 21 pour FTP, 22 pour SSH)
    DEFAULT_PORT=80
    if [ "$SERVICE" == "ftp" ]; then
        DEFAULT_PORT=21
    elif [ "$SERVICE" == "ssh" ]; then
        DEFAULT_PORT=22
    fi

    read -p "Entrez le port (défaut: $DEFAULT_PORT): " PORT
    if [ -z "$PORT" ]; then
        PORT="$DEFAULT_PORT"
    fi

    # Définir le nombre de tâches parallèles (par défaut : 4)
    DEFAULT_TASKS=4
    read -p "Entrez le nombre de tâches parallèles (défaut: $DEFAULT_TASKS): " TASKS
    if [ -z "$TASKS" ]; then
        TASKS="$DEFAULT_TASKS"
    fi

    # Définir les fichiers par défaut (chemins relatifs)
    DEFAULT_USERLIST="data/users.txt"
    DEFAULT_PASSLIST="data/passwords.txt"

    # Demander le chemin vers la liste d'utilisateurs
    read -p "Entrez le chemin vers la liste d'utilisateurs (ex: data/users.txt) [défaut: $DEFAULT_USERLIST]: " USERLIST
    if [ -z "$USERLIST" ]; then
        USERLIST="$DEFAULT_USERLIST"
    fi

    # Demander le chemin vers la liste de mots de passe
    read -p "Entrez le chemin vers la liste de mots de passe (ex: data/passwords.txt) [défaut: $DEFAULT_PASSLIST]: " PASSLIST
    if [ -z "$PASSLIST" ]; then
        PASSLIST="$DEFAULT_PASSLIST"
    fi

    # Vérifier si les fichiers existent
    if [ ! -f "$USERLIST" ]; then
        echo "Erreur : Le fichier d'utilisateurs $USERLIST n'existe pas."
        return
    fi

    if [ ! -f "$PASSLIST" ]; then
        echo "Erreur : Le fichier de mots de passe $PASSLIST n'existe pas."
        return
    fi

    # Exécuter Hydra
    echo "Starting Hydra brute force on $TARGET for service $SERVICE (port: $PORT, tâches: $TASKS)"
    echo "Userlist: $USERLIST"
    echo "Passlist: $PASSLIST"
    ./hydra_scan.sh "$TARGET" "$SERVICE" "$PORT" "$TASKS" "$USERLIST" "$PASSLIST"
}

# Fonction pour exécuter SQLmap
run_sqlmap() {
    read -p "Entrez l'IP/URL de base (ex: http://192.168.1.27): " BASE_URL
    read -p "Entrez le chemin et les paramètres (ex: /login?user=admin): " PATH_PARAMS

    # Construire l'URL complète
    TARGET="${BASE_URL%/}${PATH_PARAMS}"

    # Vérifier si l'URL contient des paramètres ou un chemin dynamique
    if [[ "$TARGET" != *"?"* ]] && [[ "$PATH_PARAMS" != *"/"* ]]; then
        echo "Attention : L'URL ne contient pas de paramètres (ex: ?id=1) ou de chemin dynamique."
        read -p "Voulez-vous continuer malgré tout ? (y/n): " CONTINUE
        if [ "$CONTINUE" != "y" ]; then
            return
        fi
    fi

    # Demander le niveau d'agressivité
    read -p "Niveau de risque (1-3, défaut: 1): " RISK
    read -p "Niveau de test (1-5, défaut: 1): " LEVEL

    # Définir les valeurs par défaut
    RISK=${RISK:-1}
    LEVEL=${LEVEL:-1}

    # Exécuter SQLmap
    ./sqlmap_scan.sh "$TARGET" "$RISK" "$LEVEL"
}

# Boucle principale
while true; do
    show_menu
    read -p "Choisissez une option (1-6) ou tapez 'exit' pour quitter: " CHOICE
    case $CHOICE in
        1) run_netdiscover ;;
        2) run_nmap ;;
        3) run_nikto ;;
        4) run_gobuster ;;
        5) run_hydra ;;
        6) run_sqlmap ;;
        exit) echo "Au revoir!"; break ;;
        *) echo "Option invalide. Veuillez réessayer." ;;
    esac
done