# All my important variables are named to start with "CTERDAM" and exported
# TODO: Remove extra variables and just keep CTERDAMHOME

# GENERAL --------------------------------------------------------------------

# Print each directory on its own line
# TODO: Fix this bug where it will not reflect changes in PATH
alias showpath="echo ${PATH} | sed 's/\:/\n/g'"

# Edit anything with vim
export EDITOR="vim"

# CTERDAMHOME directory to hold all my terminal material
export CTERDAMHOME="$HOME/cterdam"

# Make sure that CTERDAMHOME exists (if exists, nothing changes)
mkdir -p $CTERDAMHOME

# Intended directory structure:
# CTERDAMHOME
#   - CTERDAMBIN
#   - CTERDAMRCLOC

# CTERDAMBIN directory to hold all my executables
export CTERDAMBIN="$CTERDAMHOME/bin"

# Make sure that CTERDAMBIN exists (if exists, nothing changes)
mkdir -p $CTERDAMBIN

# PATH  ----------------------------------------------------------------------

# Append clangd (installed with brew) if not included already
clangdpath="/opt/homebrew/opt/llvm/bin"
if [[ :$PATH: != *:$clangdpath:* ]]; then
    export PATH=$PATH:$clangdpath
fi

# Prepend CTERDAMBIN (with priority) if not included aleady
# TODO: This still does not come ahead of other paths
if [[ :$PATH: != *:$CTERDAMBIN:* ]]; then
    export PATH=$CTERDAMBIN:$PATH
fi

# OHMYZSH --------------------------------------------------------------------

# Path to oh-my-zsh installation
export ZSH="/Users/sterdam/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes
ZSH_THEME="candy"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
)

# Rest of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# LINUXRC --------------------------------------------------------------------

# CTERDAMRCLOC to hold all my custom rc files
# CTERDAMRCLOC should be named linuxrc as my git repo.
# These rc file names should all start with "cterdam" as in my git repo.
export CTERDAMRCLOC="$CTERDAMHOME/linuxrc"

# Each of the following files are sourced into from their default location:

# ~/.zshrc
alias zshrc="$EDITOR $CTERDAMRCLOC/cterdam.zshrc"
# ~/.vimrc
alias vimrc="$EDITOR $CTERDAMRCLOC/cterdam.vimrc"
# ~/.tmux.conf
alias tmux.conf="$EDITOR $CTERDAMRCLOC/cterdam.tmux.conf"

# Some things to consider in the future:
# - symlinking the original rc files to the cterdam ones instead of sourcing

# TMUX -----------------------------------------------------------------------

# Start tmux session "default" if tmux not running
if [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
fi
