const BASH_SCRIPT = `#!/usr/bin/env bash
# ==============================================================================
# 🪄 DISPEL MAGIC (dispelmagic.sh / dispelmagic.ai)
# 3rd-Level Abjuration against Vibe-Coded AI Slop
# ==============================================================================
set -euo pipefail

PURPLE='\\033[0;35m'
CYAN='\\033[0;36m'
YELLOW='\\033[1;33m'
RED='\\033[0;31m'
GREEN='\\033[0;32m'
DIM='\\033[2m'
NC='\\033[0m'

echo -e "\${PURPLE}🪄  Casting DISPEL MAGIC (3rd-Level Abjuration)...\${NC}"
sleep 0.4
echo -e "\${CYAN}Scanning local ether for hallucinated dependencies & vibe-coded illusions...\${NC}"
sleep 0.5

ROLL=$((RANDOM % 20 + 1))
echo -e "🎲 Ability Check (d20): \${YELLOW}\${ROLL}\${NC}"

if [ "\$ROLL" -ge 12 ]; then
  echo -e "\${GREEN}⚡ SPELL SUCCESS! 4.2 GB of neural slop purged from the astral plane.\${NC}"
else
  echo -e "\${RED}💀 SPELL FAILED! The .cursorrules ward is too strong. Upcast using a 9th-level slot.\${NC}"
fi

echo -e "\${DIM}------------------------------------------------------------------\${NC}"
echo -e "\${DIM}[arcane registry] dispelmagic (.ai / .sh / .dev / .io) bundle inquiries: https://dispelmagic.ai\${NC}"
`;
