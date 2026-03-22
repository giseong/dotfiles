#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# System Update Script
# Supports: macOS (Homebrew)
# =============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}==>${NC} $1"; }
log_success() { echo -e "${GREEN}==>${NC} $1"; }
log_warn()    { echo -e "${YELLOW}==>${NC} $1"; }
log_error()   { echo -e "${RED}==>${NC} $1"; }
log_section() { echo -e "\n${YELLOW}━━━ $1 ━━━${NC}\n"; }

require_macos() {
    if [[ "$(uname -s)" != "Darwin" ]]; then
        log_error "Unsupported OS. This repository supports macOS only."
        exit 1
    fi
}

update_macos() {
    log_section "macOS System Updates"

    if command -v brew &>/dev/null; then
        log_info "Updating Homebrew..."
        brew update
        log_info "Upgrading packages (including casks)..."
        brew upgrade --greedy
        log_info "Cleaning up..."
        brew cleanup --prune=7
        log_success "Homebrew done"
    else
        log_warn "Homebrew not found, skipping"
    fi

    if command -v mas &>/dev/null; then
        log_info "Updating App Store apps..."
        mas upgrade
        log_success "App Store done"
    else
        log_warn "mas not found, skipping App Store"
    fi
}

update_dev_tools() {
    log_section "Development Tools"

    if [[ -d "$HOME/.local/share/zinit" ]]; then
        log_info "Updating Zinit plugins..."
        zsh -ic "zinit self-update && zinit update --parallel" 2>/dev/null || log_warn "Zinit update failed"
        log_success "Zinit done"
    fi

    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Updating Tmux plugins..."
        "$HOME/.tmux/plugins/tpm/bin/update_plugins" all 2>/dev/null || log_warn "TPM update failed"
        log_success "Tmux plugins done"
    fi

    if command -v nvim &>/dev/null; then
        log_info "Updating Neovim plugins..."
        nvim --headless "+Lazy! sync" +qa 2>/dev/null || log_warn "Neovim update failed"
        log_success "Neovim plugins done"
    fi

    if command -v npm &>/dev/null; then
        log_info "Updating npm global packages..."
        npm update -g 2>/dev/null || log_warn "npm update failed"
        log_success "npm done"
    fi

    if command -v pip &>/dev/null; then
        log_info "Checking pip packages..."
        pip list --outdated --user 2>/dev/null | tail -n +3 | cut -d' ' -f1 | while read -r pkg; do
            [[ -z "$pkg" ]] && continue
            pip install --user --upgrade "$pkg" 2>/dev/null || true
        done
        log_success "pip done"
    fi
}

main() {
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║        System Update Script            ║"
    echo "╚════════════════════════════════════════╝"
    echo ""

    require_macos
    log_info "Detected OS: macos"

    update_macos
    update_dev_tools

    log_section "Complete"
    log_success "All updates finished!"
}

main "$@"
