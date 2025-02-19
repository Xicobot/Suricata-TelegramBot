#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y suricata

echo "Detectando interfaces de red disponibles..."
ip -o link show | awk -F': ' '{print NR". "$2}'

echo ""
read -p "Selecciona el número de la interfaz que deseas usar: " choice

INTERFACE=$(ip -o link show | awk -F': ' '{print $2}' | sed -n "${choice}p")

if [ -z "$INTERFACE" ]; then
    echo "Opción inválida. Saliendo..."
    exit 1
fi

echo "Has seleccionado la interfaz: $INTERFACE"

echo "Añadiendo la interfaz al archivo /etc/suricata/suricata.yaml"
sudo sed -i "s/interface: .*/interface: $INTERFACE/" /etc/suricata/suricata.yaml

IP=$(ip -4 addr show "$INTERFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [ -z "$IP" ]; then
    echo "No se encontró una IP para $INTERFACE. Saliendo..."
    exit 1
fi

echo "Dirección IP detectada: $IP"

read -p "¿Quieres agregar esta IP a Suricata? (s/n): " confirm

if [ "$confirm" = "s" ] || [ "$confirm" = "S" ]; then

    echo "¿Qué reglas quieres usar?"
    echo "1: Reglas personalizadas"
    echo "2: Suricata con reglas de repositorios (Recomendado) "
    read -p "Elige una opción (1 o 2): " OP1

    if [ -z "$OP1" ]; then
        echo "Opción inválida. Saliendo..."
        exit 1
    fi

    if [ "$OP1" = "1" ]; then
        sudo tee -a /var/lib/suricata/rules/local.rules > /dev/null <<EOL
alert tcp $IP any -> any any (msg:"Nmap SYN scan detected on $INTERFACE"; flags:S; threshold:type both, track by_src, count 10, seconds 10; sid:1000011; rev:1;)
alert tcp $IP any -> any any (msg:"Nmap Xmas scan detected on $INTERFACE"; flags:FPU; threshold:type both, track by_src, count 5, seconds 10; sid:1000012; rev:1;)
alert tcp $IP any -> any 22 (msg:"SSH brute force login attempt on $INTERFACE"; flow:to_server,established; content:"SSH-"; offset:0; threshold:type both, track by_src, count 5, seconds 60; classtype:attempted-dos; sid:1000013; rev:1;)
alert http $IP any -> any any (msg:"Potential SQL injection attempt on $INTERFACE"; flow:to_server,established; content:"select "; nocase; pcre:"/select\s+.*\s+from/i"; classtype:web-application-attack; sid:1000014; rev:1;)
alert udp $IP any -> any 53 (msg:"Potential DNS tunneling attempt on $INTERFACE"; content:"|00 00 29|"; offset:2; depth:4; threshold:type both, track by_src, count 10, seconds 60; sid:1000015; rev:1;)
EOL

        sudo sed -i 's/^\([[:space:]]*-\s*\)suricata\.rules/\1local.rules/' /etc/suricata/suricata.yaml
	suricata -T
	systemctl restart suricata
        echo "¡Suricata listo y acabado!"
    elif [ "$OP1" = "2" ]; then
        echo "Recargando Suricata..."
	sudo suricata-update list-sources
	sudo suricata-update update-sources
 	suricata -T
        sudo systemctl restart suricata

        echo "¡Suricata reiniciado!"
    else
        echo "No se hicieron cambios. Saliendo..."
    fi

fi
