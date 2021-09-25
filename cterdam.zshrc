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

# TMUX -----------------------------------------------------------------------

# Start tmux session "default" if tmux not running
if [ -z "$TMUX" ]
then
    tmux attach -t default || tmux new -s default
fi

# CLANGD ---------------------------------------------------------------------

# Include Clangd in path
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# ----------------------------------------------------------------------------

# Store all rc files in folder RCLOC
RCLOC="$HOME/cterdam/linuxrc"
alias allrcs="ls $RCLOC"
alias zshrc="vim $RCLOC/cterdam.zshrc"
alias vimrc="vim $RCLOC/cterdam.vimrc"
alias tmux.conf="vim $RCLOC/cterdam.tmux.conf"
