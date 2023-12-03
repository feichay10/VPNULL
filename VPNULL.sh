#!/bin/bash

# Autor Cheuk Kelly Ng Pante
# Correo Institucional: alu0101364544@ull.edu.es
# Version 2.0
# Descripcion: Script que permite la automatizacion con la conexcion VPN con la Universidad de La Laguna

VPNC="which vpnc"
file="/etc/vpnc/ull.conf"
CHECK_FILE="test -f $file"
option=
option_install=
etiqueta=0

$VPNC > /dev/null || etiqueta=1

if [ $etiqueta == "0" ]; then
  $CHECK_FILE > /dev/null
else 
  etiqueta=2
fi

if [ $etiqueta == "0" ]; then
  echo "Script para entrar a la VPN de la ULL
        0) Para salir
        1) Para conectarse a la VPN
        2) Para desconectarse de la VPN
  "
  echo -n "Introduzca una opcion: "
  read opcion
  
  case $opcion in
    0)
      exit
    ;;
    1)
      echo "Conectando con la VPN de la ULL..."
      sudo vpnc --username "$(cat vpnuser.txt)" --password "$(cat vpnpass.txt)" ull.conf
    ;;
    2)
      echo "Desconectando de la VPN de la ULL..."
      sudo vpnc-disconnect
    ;;
    *)
      echo "Opcion no valida. 0) Salir, 1) Para conectarse, 2) Para desconectarse"
  esac
elif [ $etiqueta == "2" ]; then
  echo "No se encuentra el archivo ull.conf"
  echo "¿Quiere instalar el archivo ull.conf? (s/n)"
  read option_install
  if [ $option_install == "S" ] || [ $option_install == "s" ]; then
    if [ "$(whoami)" == "root" ]; then
      apt-get -y update
      apt install -y network-manager-vpnc-gnome
      echo "IPSec gateway vpn.ull.es" > /etc/vpnc/ull.conf
      echo "IPSec ID ULL" >> /etc/vpnc/ull.conf
      echo "IPSec secret usu4r10s" >> /etc/vpnc/ull.conf
    else
      echo "Para instalar el archivo ull.conf es necesario ser root"
    fi
  elif [ $option_install == "N" ] || [ $option_install == "n" ]; then
    echo "No se instalará el archivo ull.conf"
  else
    echo "Opcion no valida"
  fi
else
  echo "No se encuentra el programa vpnc"
  echo "¿Quiere instalar el programa vpnc? (s/n)"
  read option_install
  if [ $option_install == "S" ] || [ $option_install == "s" ]; then
    if [ "$(whoami)" == "root" ]; then
      apt-get -y update
      apt install -y network-manager-vpnc-gnome
      echo "IPSec gateway vpn.ull.es" > /etc/vpnc/ull.conf
      echo "IPSec ID ULL" >> /etc/vpnc/ull.conf
      echo "IPSec secret usu4r10s" >> /etc/vpnc/ull.conf
    else
      echo "Para instalar el programa vpnc es necesario ser root"
    fi
  elif [ $option_install == "N" ] || [ $option_install == "n" ]; then
    echo "No se instalará el programa vpnc"
  else
    echo "Opcion no valida"
  fi
fi
