#!/bin/bash
if [ -z "$1" ]; then
    echo "Uso: ./restore_rules.sh <arquivo_de_backup>"
    exit 1
fi

iptables-restore < "$1"
echo "Regras restauradas a partir de $1"
