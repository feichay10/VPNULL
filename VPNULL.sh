# Autor Cheuk Kelly Ng Pante
# Correo Institucional: alu0101364544@ull.edu.es
# Version 1.0
# Descripcion: Script que permite la automatizacion con la conexcion VPN con la Universidad de La Laguna

#!/bin/bash

VPNC="which vpnc"
option=
option_install=
etiqueta=0

$VPNC > /dev/null || etiqueta=1

if [ "$etiqueta" == "0" ]; then
  echo "Script para entrar a la VPN de la ULL
        0) Para salir
        1) Para conectarse a la VPN
        2) Para desconectarse a la VPN
  "
  echo -n "Introduzca una opcion: "
  read opcion
  
  case $opcion in
    0)
      exit
    ;;
    1)
      echo "Conectando con la VPN de la ULL..."
      sudo vpnc ull.conf
    ;;
    2)
      echo "Desconectando de la VPN de la ULL..."
      sudo vpnc-disconnect
    ;;
    *)
      echo "Opcion no valida. 0) Salir, 1) Para conectarse, 2) Para desconectarse"
  esac
else
  echo "No se encuentra el programa vpnc"
  echo "¿Quiere instalar el programa vpnc? (s/n)"
  read option_install
  if [ $option_install == "S" ] || [ $option_install == "s" ]; then
    if [ "$(whoami)" == "root" ]; then
      apt-get -y update
      apt install -y network-manager-vpnc-gnome
      touch /etc/vpnc/ull.conf
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