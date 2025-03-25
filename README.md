# 🔍 Network Scanner Toolkit v1.0

## Description
Ce projet est un **outil de scan réseau** automatisé en **Bash**, regroupant plusieurs outils puissants comme :
- **Netdiscover** : Découverte d'hôtes sur le réseau local.
- **Nmap** : Scan de ports et détection de services.
- **Nikto** : Scan de vulnérabilités web.
- **Gobuster** : Énumération de répertoires web.
- **Hydra** : Brute force sur les services réseau.
- **SQLmap** : Détection d'injections SQL.
- **WhatWeb** : Analyse des technologies utilisées par un site web.

L'outil possède une **interface en ligne de commande (CLI) interactive** pour une expérience utilisateur simplifiée et efficace.

---

## Installation

### Cloner le projet

Pour récupérer le projet depuis GitHub, exécutez la commande suivante :
```bash
 git clone https://github.com/Adam-Lernould/Network_Scanner.git
 cd Network_Scanner
```

### Prérequis
Le script nécessite plusieurs outils de sécurité que vous pouvez installer à l'aide du fichier `requirements.txt`.

### Installation automatique des dépendances
Exécutez la commande suivante pour installer les outils nécessaires :
```bash
sudo apt update && xargs -a requirements.txt sudo apt install -y
pip install sqlmap  # Si sqlmap n'est pas dispo via apt
```

Vous pouvez également installer manuellement les outils un par un :
```bash
sudo apt install -y nmap netdiscover nikto gobuster hydra whatweb
pip install sqlmap
```

---

## Utilisation

Lancez le script principal `scan.sh` pour accéder à l'interface interactive :
```bash
./scan.sh
```
Vous verrez alors un menu permettant de choisir l'outil que vous souhaitez utiliser.

### Exemple d'utilisation
```plaintext
Choisissez un outil de scan ou tapez 'exit' pour quitter :
1. Netdiscover (Découverte d'hôtes sur le réseau local)
2. Nmap (Scan de ports et détection de services)
3. Nikto (Scan de vulnérabilités web)
4. Gobuster (Énumération de répertoires web)
5. Hydra (Brute force sur les services réseau)
6. SQLmap (Détection d'injections SQL)
7. WhatWeb (Analyse des technologies d'un site web)
```

Sélectionnez une option et suivez les instructions pour exécuter le scan.

---

## Arborescence du projet
```
.
├── scan.sh           # Script principal
├── nmap_scan.sh      # Script pour exécuter Nmap
├── sqlmap_scan.sh    # Script pour exécuter SQLmap
├── hydra_scan.sh     # Script pour exécuter Hydra
├── gobuster_scan.sh  # Script pour exécuter Gobuster
├── nikto_scan.sh     # Script pour exécuter Nikto
├── whatweb_scan.sh   # Script pour exécuter WhatWeb
├── requirements.txt  # Liste des dépendances
├── data/             # Contient les wordlists et fichiers de dictionnaire
└── reports/          # Contient les rapports générés par les scans
```

---

## Améliorations futures
- Ajouter d'autres outils de reconnaissance.
- Ajouter un mode "rapport complet" pour générer un fichier récapitulatif après chaque scan.

---

## Disclaimer
Cet outil est destiné à un usage **éthique et légal uniquement**. L'utilisation de ce scanner sans autorisation explicite du propriétaire du réseau est **strictement interdite**.

---

## Contribuer
Les contributions sont les bienvenues ! Forkez ce projet, améliorez-le et proposez vos modifications via une **Pull Request** ! 🚀

---

## Licence
Ce projet est sous licence **MIT**. Vous êtes libre de l'utiliser, de le modifier et de le distribuer tout en respectant les termes de la licence.

---

**Auteur :** *[Adam Lernould / Adam-Lernould]*
