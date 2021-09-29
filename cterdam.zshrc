# OHMYZSH --------------------------------------------------------------------

# Path to oh-my-zsh installation
export ZSH="/Users/sterdam/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
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

source $ZSH/oh-my-zsh.sh

# LINUXRC --------------------------------------------------------------------

# Store all rc files in folder RCLOC.
# Each of the following files are sourced from the default rc file above.
# Some things to consider in the future:
# - symlinking the original rc files to the cterdam ones instead of sourcing

RCLOC="$HOME/cterdam/linuxrc"

# ~/.zshrc
alias zshrc="vim $RCLOC/cterdam.zshrc"
# ~/.vimrc
alias vimrc="vim $RCLOC/cterdam.vimrc"
# ~/.tmux.conf
alias tmux.conf="vim $RCLOC/cterdam.tmux.conf"

# PATH  ----------------------------------------------------------------------

# Append clangd (installed with brew) if not included already
clangdpath="/opt/homebrew/opt/llvm/bin"
if [[ :$PATH: != *:$clangdpath:* ]]; then
    export PATH=$PATH:$clangdpath
fi

# GENERAL --------------------------------------------------------------------

# Show each directory on its own line
alias showpath="echo $PATH | sed 's/\:/\n/g'"

# Edit anything with vim
export EDITOR="vim"

# TMUX -----------------------------------------------------------------------

# Start tmux session "default" if tmux not running
if [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
fi
