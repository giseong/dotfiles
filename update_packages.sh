#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# System Update Script
# Supports: macOS (Homebrew) / Arch Linux (pacman/yay)
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

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if command -v pacman &>/dev/null; then
                echo "arch"
            else
                echo "linux"
            fi
            ;;
        *) echo "unknown" ;;
    esac
}

OS=$(detect_os)

# =============================================================================
# macOS Updates
# =============================================================================
update_macos() {
    log_section "macOS System Updates"

    # Homebrew
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

    # Mac App Store (mas)
    if command -v mas &>/dev/null; then
        log_info "Updating App Store apps..."
        mas upgrade
        log_success "App Store done"
    else
        log_warn "mas not found, skipping App Store"
    fi
}

# =============================================================================
# Arch Linux Updates
# =============================================================================
update_arch() {
    log_section "Arch Linux System Updates"

    # Pacman
    log_info "Updating system with pacman..."
    sudo pacman -Syu --noconfirm
    log_success "Pacman done"

    # AUR (paru or yay)
    if command -v paru &>/dev/null; then
        log_info "Updating AUR packages with paru..."
        paru -Sua --noconfirm
        log_success "AUR done"
    elif command -v yay &>/dev/null; then
        log_info "Updating AUR packages with yay..."
        yay -Sua --noconfirm
        log_success "AUR done"
    else
        log_warn "No AUR helper found, skipping AUR"
    fi

    # Clean package cache
    log_info "Cleaning package cache..."
    sudo pacman -Sc --noconfirm 2>/dev/null || true
    if command -v paru &>/dev/null; then
        paru -Sc --noconfirm 2>/dev/null || true
    elif command -v yay &>/dev/null; then
        yay -Sc --noconfirm 2>/dev/null || true
    fi
}

# =============================================================================
# Development Tools Updates
# =============================================================================
update_dev_tools() {
    log_section "Development Tools"

    # Zinit (Zsh plugins)
    if [[ -d "$HOME/.local/share/zinit" ]]; then
        log_info "Updating Zinit plugins..."
        zsh -ic "zinit self-update && zinit update --parallel" 2>/dev/null || log_warn "Zinit update failed"
        log_success "Zinit done"
    fi

    # Tmux plugins (TPM)
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Updating Tmux plugins..."
        "$HOME/.tmux/plugins/tpm/bin/update_plugins" all 2>/dev/null || log_warn "TPM update failed"
        log_success "Tmux plugins done"
    fi

    # Neovim plugins (lazy.nvim)
    if command -v nvim &>/dev/null; then
        log_info "Updating Neovim plugins..."
        nvim --headless "+Lazy! sync" +qa 2>/dev/null || log_warn "Neovim update failed"
        log_success "Neovim plugins done"
    fi

    # npm global packages
    if command -v npm &>/dev/null; then
        log_info "Updating npm global packages..."
        npm update -g 2>/dev/null || log_warn "npm update failed"
        log_success "npm done"
    fi

    # pip (user packages)
    if command -v pip &>/dev/null; then
        log_info "Checking pip packages..."
        pip list --outdated --user 2>/dev/null | tail -n +3 | cut -d' ' -f1 | while read -r pkg; do
            pip install --user --upgrade "$pkg" 2>/dev/null || true
        done
        log_success "pip done"
    fi

    update_superpowers
}

update_superpowers() {
    local superpowers_repo="$HOME/.config/opencode/superpowers"

    if [[ ! -d "$superpowers_repo/.git" ]]; then
        log_warn "Superpowers not found, skipping"
        return
    fi

    log_info "Updating superpowers..."
    git -C "$superpowers_repo" pull --ff-only 2>/dev/null || {
        log_warn "Superpowers update failed"
        return
    }
    log_success "Superpowers done"
}

# =============================================================================
# Main
# =============================================================================
main() {
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║        System Update Script            ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    log_info "Detected OS: $OS"

    case "$OS" in
        macos) update_macos ;;
        arch)  update_arch ;;
        *)     log_error "Unsupported OS"; exit 1 ;;
    esac

    update_dev_tools

    log_section "Complete"
    log_success "All updates finished!"
}

main "$@"
