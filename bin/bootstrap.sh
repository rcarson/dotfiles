#!/usr/bin/env bash
# =============================================================================
# Dotfiles Bootstrap Script
# Usage: bash bootstrap.sh
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# Config — edit these before running
# -----------------------------------------------------------------------------
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/rcarson/dotfiles.git}"
DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
info()    { echo -e "\033[0;34m[INFO]\033[0m  $*"; }
success() { echo -e "\033[0;32m[OK]\033[0m    $*"; }
warn()    { echo -e "\033[0;33m[WARN]\033[0m  $*"; }
die()     { echo -e "\033[0;31m[ERROR]\033[0m $*" >&2; exit 1; }

config() {
    /usr/bin/git --git-dir="${DOTFILES_DIR}" --work-tree="${HOME}" "$@"
}

# -----------------------------------------------------------------------------
# Preflight checks
# -----------------------------------------------------------------------------
info "Checking dependencies..."
command -v git >/dev/null 2>&1 || die "git is not installed. Run: sudo apt install git"

# Check SSH agent has keys loaded if using SSH remote
if [[ "${DOTFILES_REPO}" == git@* ]]; then
    ssh-add -l >/dev/null 2>&1 || warn "No SSH keys in agent. Clone may fail if repo is private. Consider running: ssh-add ~/.ssh/id_rsa"
fi

# -----------------------------------------------------------------------------
# Clone bare repo
# -----------------------------------------------------------------------------
if [[ -d "${DOTFILES_DIR}" ]]; then
    warn "~/.dotfiles already exists — skipping clone"
else
    info "Cloning dotfiles repo..."
    git clone --bare "${DOTFILES_REPO}" "${DOTFILES_DIR}" || die "Clone failed. Check your repo URL and SSH access."
    success "Repo cloned to ${DOTFILES_DIR}"
fi

# -----------------------------------------------------------------------------
# Checkout dotfiles into $HOME
# -----------------------------------------------------------------------------
info "Checking out dotfiles..."

# Try checkout — if it fails, conflicting files already exist
if ! config checkout 2>/dev/null; then
    warn "Existing files conflict with dotfiles. Backing them up to ${BACKUP_DIR}"
    mkdir -p "${BACKUP_DIR}"

    # Collect conflicting files and back them up
    config checkout 2>&1 \
        | grep "^\s" \
        | awk '{print $1}' \
        | while read -r f; do
            mkdir -p "${BACKUP_DIR}/$(dirname "${f}")"
            mv "${HOME}/${f}" "${BACKUP_DIR}/${f}"
          done

    # Try again after backup
    config checkout || die "Checkout failed even after backup. Check ${BACKUP_DIR} and resolve manually."
    success "Conflicting files backed up to ${BACKUP_DIR}"
fi

success "Dotfiles checked out"

# -----------------------------------------------------------------------------
# Config: hide untracked files
# -----------------------------------------------------------------------------
config config --local status.showUntrackedFiles no
success "Git config set (untracked files hidden)"

# -----------------------------------------------------------------------------
# Set up .bashrc.d sourcing (if not already in .bashrc)
# -----------------------------------------------------------------------------
BASHRC="${HOME}/.bashrc"
SOURCING_BLOCK='
# Source all files in .bashrc.d/
if [ -d "${HOME}/.bashrc.d" ]; then
    for f in "${HOME}"/.bashrc.d/*.sh; do
        [ -r "$f" ] && source "$f"
    done
    unset f
fi'

if [[ -f "${BASHRC}" ]] && grep -q '.bashrc.d' "${BASHRC}"; then
    info ".bashrc.d sourcing already present — skipping"
else
    info "Adding .bashrc.d sourcing to ${BASHRC}..."
    echo "${SOURCING_BLOCK}" >> "${BASHRC}"
    success "Sourcing block added to ${BASHRC}"
fi

mkdir -p "${HOME}/.bashrc.d"

# -----------------------------------------------------------------------------
# Add config alias (if not already present)
# -----------------------------------------------------------------------------
ALIAS_LINE="alias config='/usr/bin/git --git-dir=\${HOME}/.dotfiles/ --work-tree=\$HOME'"
ALIAS_FILE="${HOME}/.bashrc.d/dotfiles.sh"

if [[ -f "${ALIAS_FILE}" ]] && grep -q 'alias config=' "${ALIAS_FILE}"; then
    info "config alias already present — skipping"
else
    info "Adding config alias to ${ALIAS_FILE}..."
    echo "# Dotfiles bare repo alias" > "${ALIAS_FILE}"
    echo "${ALIAS_LINE}" >> "${ALIAS_FILE}"
    success "config alias written to ${ALIAS_FILE}"
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "============================================="
success "Bootstrap complete!"
echo "============================================="
echo ""
echo "  Dotfiles repo : ${DOTFILES_DIR}"
if [[ -d "${BACKUP_DIR}" ]]; then
echo "  Backed up to  : ${BACKUP_DIR}"
fi
echo ""
echo "  Reload your shell or run:"
echo "    source ~/.bashrc"
echo ""
echo "  Then use 'config' just like git:"
echo "    config status"
echo "    config add ~/.vimrc"
echo "    config commit -m 'update vimrc'"
echo "    config push"
echo ""