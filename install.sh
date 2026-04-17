#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Dotfiles Bootstrap Script
# Supports: macOS (Homebrew)
# =============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

require_macos() {
    if [[ "$(uname -s)" != "Darwin" ]]; then
        log_error "Unsupported OS. This repository supports macOS only."
        exit 1
    fi

    log_info "Detected OS: macos"
}

install_brewfile() {
    local brewfile="$1"
    local label="$2"

    if [[ ! -f "$brewfile" ]]; then
        log_warn "Missing Brewfile: $brewfile"
        return 1
    fi

    log_info "Installing $label via brew bundle..."
    brew bundle --file="$brewfile"
}

install_packages_macos() {
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    log_success "Homebrew is installed"
    install_brewfile "$DOTFILES_DIR/manifests/macos/core.brewfile" "core packages"
}

install_zinit() {
    if [[ -d "$HOME/.local/share/zinit/zinit.git" ]]; then
        log_success "Zinit is already installed"
        return
    fi

    log_info "Installing Zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    log_success "Zinit installed"
}

stow_package() {
    local package="$1"

    if [[ ! -d "$package" ]]; then
        log_warn "$package package not found, skipping"
        return
    fi

    log_info "Stowing $package..."
    stow -v "$package" 2>&1 | grep -v "^LINK:" || true
}

stow_packages() {
    local packages=(zsh tmux nvim git editorconfig ghostty)

    log_info "Applying dotfiles with stow..."
    cd "$DOTFILES_DIR"

    for pkg in "${packages[@]}"; do
        stow_package "$pkg"
    done

    if [[ -d "git-work" || -d "git-personal" ]]; then
        echo
        echo "Select git profile to stow:"
        echo "  [w] Work"
        echo "  [p] Personal"
        echo "  [s] Skip"
        read -r -p "Choice [w/p/s] (default: p): " -n 1 git_choice
        echo

        case "$git_choice" in
            w|W) stow_package "git-work" ;;
            p|P|"") stow_package "git-personal" ;;
            s|S) log_info "Skipping git profile stow" ;;
            *) log_warn "Unknown choice, skipping git profile stow" ;;
        esac
    fi

    log_success "Dotfiles applied"
}

set_zsh_default() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        log_success "zsh is already the default shell"
        return
    fi

    log_info "Setting zsh as default shell..."
    chsh -s "$(command -v zsh)"
    log_success "Default shell changed to zsh (restart terminal to apply)"
}

install_optional_packages() {
    echo
    echo "Optional package groups:"

    read -r -p "  Install CLI extras group? [y/N] " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_brewfile "$DOTFILES_DIR/manifests/macos/cli.brewfile" "CLI extras"
    fi

    read -r -p "  Install default GUI apps group? [y/N] " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_brewfile "$DOTFILES_DIR/manifests/macos/gui.brewfile" "default GUI apps"
    fi

    read -r -p "  Install dev tools group? [y/N] " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_brewfile "$DOTFILES_DIR/manifests/macos/dev.brewfile" "dev tools"
    fi

    read -r -p "  Install work apps group? [y/N] " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_brewfile "$DOTFILES_DIR/manifests/macos/work.brewfile" "work apps"
    fi

    read -r -p "  Install media and design apps group? [y/N] " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_brewfile "$DOTFILES_DIR/manifests/macos/media.brewfile" "media and design apps"
    fi
}

main() {
    echo "=============================================="
    echo "  Dotfiles Installation Script"
    echo "=============================================="
    echo

    require_macos
    install_packages_macos
    install_zinit
    stow_packages
    set_zsh_default
    install_optional_packages

    echo
    log_success "Installation complete!"
    log_info "Please restart your terminal or run: exec zsh"
}

main "$@"
