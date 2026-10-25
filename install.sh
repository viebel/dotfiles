#!/usr/bin/env bash
# Installs dependencies and symlinks dotfiles into $HOME.
# Safe to re-run: existing non-symlink files are moved to a backup dir.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# --- Homebrew -----------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew ~/.linuxbrew/bin/brew; do
  [[ -x $b ]] && eval "$("$b" shellenv)" && break
done

# --- Packages -----------------------------------------------------------------
FORMULAE=(
  zsh zinit starship zoxide fzf ripgrep the_silver_searcher lsd bat jq
  tmux neovim git gnupg htop node python cmake stow
)
info "Installing brew formulae"
brew install "${FORMULAE[@]}"

if [[ $OS == Darwin ]]; then
  info "Installing casks"
  brew install --cask font-sauce-code-pro-nerd-font alacritty || true
fi

# --- Symlinks -----------------------------------------------------------------
info "Linking dotfiles into $HOME"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
cd "$DOTFILES"
git ls-files | grep -v -e '^README' -e '^etc/' -e '^opt/' \
  -e '^\.gitignore$' -e '^\.gitmodules$' -e '^install\.sh$' |
while read -r f; do
  target="$HOME/$f"
  mkdir -p "$(dirname "$target")"
  if [[ -e $target && ! -L $target ]]; then
    mkdir -p "$BACKUP/$(dirname "$f")"
    mv "$target" "$BACKUP/$f"
    echo "  backed up $f"
  fi
  ln -sfn "$DOTFILES/$f" "$target"
done
chmod 700 "$HOME/.gnupg" "$HOME/.ssh"
[[ -d $BACKUP ]] && info "Backups saved in $BACKUP"

# --- tmux plugins -------------------------------------------------------------
TPM="$HOME/.tmux/plugins/tpm"
if [[ ! -d $TPM ]]; then
  info "Installing tmux plugin manager"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM"
fi
info "Installing tmux plugins"
"$TPM/bin/install_plugins" || true

info "Done. Open a new terminal (or run: exec zsh -l)."
