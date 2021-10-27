# vim:foldmethod=marker

# cterdam.zshrc: cterdam's own zshrc file.
# See https://github.com/cterdam/linuxrc

# TMUX {{{

# Start tmux session "default" if tmux not running
if [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
fi

# }}}
# OHMYZSH {{{

# Path to oh-my-zsh installation
export ZSH="/Users/sterdam/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes
ZSH_THEME="candy"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
)

# Rest of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# }}}
# CTERDAMHOME {{{

# Intended directory structure:
# - CTERDAMHOME
#   - CTERDAMRC
#   - CTERDAMBIN

# CTERDAMHOME directory to hold all my terminal material
export CTERDAMHOME="$HOME/cterdam"

# Make sure that CTERDAMHOME exists (if exists, nothing changes)
mkdir -p $CTERDAMHOME

# }}}
# CTERDAMRC {{{

# CTERDAMRC directory to hold all cterdam's custom rc files
# CTERDAMRC should be named linuxrc as cloned from my git repo.
export CTERDAMRC="$CTERDAMHOME/dotfiles"

# These rc file names should all start with "cterdam" as in my git repo.
# The files are all sourced from from their default location.
# This directory should be git cloned, not made.

# cterdam's vimrc file
export CTERDAMVIMRC="$CTERDAMRC/cterdam.vimrc"
# cterdam's zshrc file
export CTERDAMZSHRC="$CTERDAMRC/cterdam.zshrc"
# cterdam's tmux.conf file
export CTERDAMTMUXCONF="$CTERDAMRC/cterdam.tmux.conf"

# Edit dotfiles with vim
rc () {
    case $1 in
        "vim")
            # Default file at ~/.vim/vimrc
            $EDITOR $CTERDAMVIMRC
            ;;
        "zsh")
            # Default file at ~/.zshrc
            $EDITOR $CTERDAMZSHRC
            ;;
        "tmux")
            # Default file at ~/.tmux.conf
            $EDITOR $CTERDAMTMUXCONF
            ;;
        "" )
            cd $CTERDAMRC
            ;;
    esac
}

# Some things to consider in the future:
# - symlinking the original rc files to the cterdam ones instead of sourcing

# }}}
# CTERDAMBIN {{{

# CTERDAMBIN directory to hold all my executables.
# This will be given priority in PATH.
export CTERDAMBIN="$CTERDAMHOME/bin"

# Make sure that CTERDAMBIN exists (if exists, nothing changes)
mkdir -p $CTERDAMBIN

# Symlink all vim binaries from homebrew to CTERDAMBIN, if not already present
# Reason is homebrew on Mac installs vim with more options than the default vim
homebrewbinloc="/opt/homebrew/bin"
for hbvimbin in $homebrewbinloc/*vim*
do
    slvimbin="$CTERDAMBIN/$(basename $hbvimbin)" 
    if [[ ! -f $slvimbin ]]; then
        ln -s $hbvimbin $slvimbin
    fi
done

# }}}
# PATH {{{

# Print each PATH directory on its own line (assumes no ':' in directory names)
alias showpath='echo $PATH | tr ":" "\n"'

# Delete from PATH (BUGGY)
delpath() {
    echo $PATH | sed "s/(\:|^)K(\:|$)//g"
}

# Returns true iff argument in PATH
inpath() {
    # Altrenative one-line implementation
    # [[ :$PATH: == *:$1:* ]]
    if [[ :$PATH: == *:$1:* ]]; then
        true
    else
        false
    fi
}

# Add something to PATH, head or tail, if not already included
addpath() {
    if ! inpath $1; then
        if [[ $2 == "head" ]]; then
            export PATH="$1:$PATH"
        else # default on tail
            export PATH="$PATH:$1"
        fi
    fi
}

# Append clangd (installed with brew) if not included already
clangdpath="/opt/homebrew/opt/llvm/bin"
addpath $clangdpath tail

# Prepend CTERDAMBIN if not included aleady
addpath $CTERDAMBIN head

# }}}
# GENERAL {{{

# Edit anything with vim
export EDITOR="vim"

# Conveniently source zshrc
alias so='source ~/.zshrc'

# Play youtube music
alias pipecat='rlwrap python3 $CTERDAMHOME/PipeCat/main.py'

# Show Chinese characters
alias tree='tree -N'

# Do actual work here
cd $CTERDAMHOME

# }}}
