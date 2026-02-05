#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Dotfiles Bootstrap Script
# Supports: macOS (Homebrew) / Arch Linux (pacman/yay)
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

# =============================================================================
# OS Detection
# =============================================================================
detect_os() {
    case "$(uname -s)" in
        Darwin) OS="macos" ;;
        Linux)
            if command -v pacman &>/dev/null; then
                OS="arch"
            else
                log_error "Unsupported Linux distribution. Only Arch-based systems are supported."
                exit 1
            fi
            ;;
        *) log_error "Unsupported OS"; exit 1 ;;
    esac
    log_info "Detected OS: $OS"
}

# =============================================================================
# Package Installation
# =============================================================================
COMMON_PACKAGES=(
    git
    git-delta
    stow
    zsh
    tmux
    neovim
    fzf
    zoxide
    eza
    bat
    thefuck
)

install_packages_macos() {
    # Install Homebrew if not present
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    log_success "Homebrew is installed"

    log_info "Installing packages via Homebrew..."
    # Note: git-delta is named 'delta' in Homebrew
    brew install git stow zsh tmux neovim fzf zoxide eza bat thefuck delta oh-my-posh zinit
}

install_packages_arch() {
    log_info "Updating system..."
    sudo pacman -Syu --noconfirm

    log_info "Installing packages via pacman..."
    sudo pacman -S --needed --noconfirm "${COMMON_PACKAGES[@]}"

    # Install AUR packages via paru or yay
    if command -v paru &>/dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &>/dev/null; then
        AUR_HELPER="yay"
    else
        log_info "Installing paru (AUR helper)..."
        sudo pacman -S --needed --noconfirm base-devel
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        (cd /tmp/paru && makepkg -si --noconfirm)
        rm -rf /tmp/paru
        AUR_HELPER="paru"
    fi

    log_info "Installing AUR packages with $AUR_HELPER..."
    $AUR_HELPER -S --needed --noconfirm oh-my-posh-bin zinit
}

# =============================================================================
# OpenCode Installation
# =============================================================================
install_opencode() {
    if command -v opencode &>/dev/null; then
        log_success "OpenCode is already installed"
        return
    fi

    case "$OS" in
        macos)
            if command -v brew &>/dev/null; then
                log_info "Installing OpenCode via Homebrew..."
                brew install opencode || log_warn "OpenCode install failed (Homebrew formula not found?)"
            else
                log_warn "Homebrew not found, skipping OpenCode"
            fi
            ;;
        arch)
            log_info "Installing OpenCode via pacman/AUR..."
            sudo pacman -S --needed --noconfirm opencode \
                || (command -v paru &>/dev/null && paru -S --needed --noconfirm opencode-bin) \
                || (command -v yay &>/dev/null && yay -S --needed --noconfirm opencode-bin) \
                || log_warn "OpenCode install failed (package not found)"
            ;;
        *)
            log_warn "Unsupported OS for OpenCode install"
            ;;
    esac
}

# =============================================================================
# Oh My OpenCode Installation
# =============================================================================
install_oh_my_opencode() {
    if [[ ! -f "$HOME/.config/opencode/opencode.json" ]]; then
        log_warn "OpenCode config not found, skipping oh-my-opencode install"
        return
    fi

    if grep -q "oh-my-opencode" "$HOME/.config/opencode/opencode.json"; then
        log_success "oh-my-opencode is already configured"
    fi

    local installer=""
    if command -v bunx &>/dev/null; then
        installer="bunx"
    elif command -v npx &>/dev/null; then
        installer="npx"
    else
        log_warn "bunx or npx not found, skipping oh-my-opencode installer"
        return
    fi

    read -p "Run oh-my-opencode installer now? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installing oh-my-opencode..."
        $installer oh-my-opencode install
        log_success "oh-my-opencode installer finished"
    fi
}

# =============================================================================
# Zinit Installation (fallback if not installed via package manager)
# =============================================================================
install_zinit() {
    if [[ ! -d "$HOME/.local/share/zinit/zinit.git" ]]; then
        log_info "Installing Zinit..."
        bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
        log_success "Zinit installed"
    else
        log_success "Zinit is already installed"
    fi
}

# =============================================================================
# Stow Dotfiles
# =============================================================================
stow_packages() {
    log_info "Applying dotfiles with stow..."
    cd "$DOTFILES_DIR"

    # List of packages to stow
    local packages=(zsh tmux nvim git wezterm editorconfig bin fabric)
    if [[ "$OS" == "macos" ]]; then
        packages+=(ghostty-macos)
    elif [[ "$OS" == "arch" ]]; then
        packages+=(ghostty-linux)
    fi

    for pkg in "${packages[@]}"; do
        if [[ -d "$pkg" ]]; then
            log_info "Stowing $pkg..."
            stow -v "$pkg" 2>&1 | grep -v "^LINK:" || true
        fi
    done

    # Git profile selection
    if [[ -d "git-work" || -d "git-personal" ]]; then
        echo
        echo "Select git profile to stow:"
        echo "  [w] Work"
        echo "  [p] Personal"
        echo "  [s] Skip"
        read -r -p "Choice [w/p/s] (default: p): " -n 1 git_choice
        echo
        case "$git_choice" in
            w|W)
                if [[ -d "git-work" ]]; then
                    log_info "Stowing git-work..."
                    stow -v "git-work" 2>&1 | grep -v "^LINK:" || true
                else
                    log_warn "git-work package not found, skipping"
                fi
                ;;
            p|P)
                if [[ -d "git-personal" ]]; then
                    log_info "Stowing git-personal..."
                    stow -v "git-personal" 2>&1 | grep -v "^LINK:" || true
                else
                    log_warn "git-personal package not found, skipping"
                fi
                ;;
            s|S)
                log_info "Skipping git profile stow"
                ;;
            "")
                if [[ -d "git-personal" ]]; then
                    log_info "Stowing git-personal..."
                    stow -v "git-personal" 2>&1 | grep -v "^LINK:" || true
                else
                    log_warn "git-personal package not found, skipping"
                fi
                ;;
            *)
                log_warn "Unknown choice, skipping git profile stow"
                ;;
        esac
    fi

    # OpenCode profile selection
    if [[ -d "opencode-work" || -d "opencode-personal" ]]; then
        echo
        echo "Select opencode profile to stow:"
        echo "  [w] Work"
        echo "  [p] Personal"
        echo "  [s] Skip"
        read -r -p "Choice [w/p/s] (default: p): " -n 1 opencode_choice
        echo
        case "$opencode_choice" in
            w|W)
                if [[ -d "opencode-work" ]]; then
                    log_info "Stowing opencode-work..."
                    stow -v "opencode-work" 2>&1 | grep -v "^LINK:" || true
                else
                    log_warn "opencode-work package not found, skipping"
                fi
                ;;
            p|P)
                if [[ -d "opencode-personal" ]]; then
                    log_info "Stowing opencode-personal..."
                    stow -v "opencode-personal" 2>&1 | grep -v "^LINK:" || true
                else
                    log_warn "opencode-personal package not found, skipping"
                fi
                ;;
            s|S)
                log_info "Skipping opencode profile stow"
                ;;
            "")
                if [[ -d "opencode-personal" ]]; then
                    log_info "Stowing opencode-personal..."
                    stow -v "opencode-personal" 2>&1 | grep -v "^LINK:" || true
                else
                    log_warn "opencode-personal package not found, skipping"
                fi
                ;;
            *)
                log_warn "Unknown choice, skipping opencode profile stow"
                ;;
        esac
    fi

    log_success "Dotfiles applied"
}

# =============================================================================
# Change Default Shell
# =============================================================================
set_zsh_default() {
    if [[ "$SHELL" != *"zsh"* ]]; then
        log_info "Setting zsh as default shell..."
        chsh -s "$(which zsh)"
        log_success "Default shell changed to zsh (restart terminal to apply)"
    else
        log_success "zsh is already the default shell"
    fi
}

# =============================================================================
# Optional: Development Tools
# =============================================================================
install_dev_tools() {
    read -p "Install development tools (pyenv, nvm)? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # pyenv
        if [[ ! -d "$HOME/.pyenv" ]]; then
            log_info "Installing pyenv..."
            curl https://pyenv.run | bash
        fi

        # nvm
        if [[ ! -d "$HOME/.nvm" ]]; then
            log_info "Installing nvm..."
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        fi

        log_success "Development tools installed"
    fi
}

# =============================================================================
# Main
# =============================================================================
main() {
    echo "=============================================="
    echo "  Dotfiles Installation Script"
    echo "=============================================="
    echo

    detect_os

    case "$OS" in
        macos) install_packages_macos ;;
        arch)  install_packages_arch ;;
    esac

    install_opencode
    install_oh_my_opencode
    install_zinit
    stow_packages
    set_zsh_default
    install_dev_tools

    echo
    log_success "Installation complete!"
    log_info "Please restart your terminal or run: exec zsh"
}

main "$@"
