#!/bin/bash
BACKUP_DIR="backup"
mkdir -p "$BACKUP_DIR"

DATE=$(date +"%Y%m%d_%H%M%S")
iptables-save > "$BACKUP_DIR/iptables_rules_$DATE.txt"

echo "Backup criado: $BACKUP_DIR/iptables_rules_$DATE.txt"
