#!/bin/bash
# =====================================
# 🔥 Firewall Automático com IPTables
# Autor: Guilherme Aires Gomes
# =====================================

LOG_FILE="logs/firewall.log"
DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$DATE] Aplicando regras de firewall..." | tee -a "$LOG_FILE"

# Limpa regras antigas
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Políticas padrão
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir tráfego local (localhost)
iptables -A INPUT -i lo -j ACCEPT

# Permitir conexões já estabelecidas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir SSH (porta 22)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Permitir HTTP e HTTPS
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT

# Bloquear IP malicioso de exemplo
iptables -A INPUT -s 192.168.100.50 -j DROP

# Logar tentativas bloqueadas
iptables -A INPUT -m limit --limit 3/min -j LOG --log-prefix "FirewallDrop: " --log-level 4

echo "[$DATE] Regras aplicadas com sucesso." | tee -a "$LOG_FILE"

# Salvar regras para persistência
iptables-save > /etc/iptables/rules.v4
