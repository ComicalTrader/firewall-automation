#!/bin/bash
# 🔰 Configuração automática do UFW

ufw --force reset
ufw default deny incoming
ufw default allow outgoing

ufw allow 22/tcp comment "SSH"
ufw allow 80,443/tcp comment "Web Traffic"

ufw deny from 192.168.100.50 comment "Bloqueio IP malicioso"

ufw --force enable
ufw status verbose
