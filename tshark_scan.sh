#!/bin/bash

# Vérifie si l'utilisateur a fourni une interface réseau
if [ -z "$1" ]; then
    echo "Usage: $0 <interface> [output_file]"
    echo "Exemple: $0 eth0"
    echo "Exemple: $0 eth0 capture.pcap"
    exit 1
fi

INTERFACE=$1
OUTPUT_FILE=${2:-"reports/tshark_capture_$(date +%Y%m%d_%H%M%S).pcap"}

# Créer le répertoire de rapport s'il n'existe pas
mkdir -p reports

echo "Starting Tshark capture on interface $INTERFACE"
echo "Output will be saved to $OUTPUT_FILE"

# Exécuter Tshark pour capturer le trafic réseau
tshark -i "$INTERFACE" -w "$OUTPUT_FILE"

echo "Tshark capture completed. Output saved to $OUTPUT_FILE"
