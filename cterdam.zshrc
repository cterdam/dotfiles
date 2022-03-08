# vim:foldmethod=marker

# cterdam.zshrc: cterdam's own zshrc file.
# See https://github.com/cterdam/dotfiles

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

# Disable auto-setting terminal title
DISABLE_AUTO_TITLE="true"

# Use case-sensitive completion
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
# CTERDAMRC should be named dotfiles as cloned from my git repo.
export CTERDAMRC="$CTERDAMHOME/dotfiles"

# These rc file names should all start with "cterdam" as in my git repo.
# The files are all symlinked to their default location.
# This directory should be git cloned.

# VIM ========================================================================

# cterdam's vimrc file
export CTERDAMVIMRC="$CTERDAMRC/cterdam.vimrc"

# Location for vimrc
export VIMRCLOC="$HOME/.vim/vimrc"

# Symlink, if not already present
if [[ ! -f $VIMRCLOC ]]; then
    ln -s $CTERDAMVIMRC $VIMRCLOC
fi

# ZSH ========================================================================

# cterdam's zshrc file
export CTERDAMZSHRC="$CTERDAMRC/cterdam.zshrc"

# Location for zshrc
export ZSHRCLOC="$HOME/.zshrc"

# Symlink, if not already present
# Actually this doesn't work, symlinking has to be done manually.
# If there is no zshrc in the appointed location, how can we execute any script?
if [[ ! -f $ZSHRCLOC ]]; then
    ln -s $CTERDAMZSHRC $ZSHRCLOC
fi

# TMUX =======================================================================

# cterdam's tmux.conf file
export CTERDAMTMUXCONF="$CTERDAMRC/cterdam.tmux.conf"

# Location for tmux.conf
export TMUXCONFLOC="$HOME/.tmux.conf"

# Symlink, if not already present
if [[ ! -f $TMUXCONFLOC ]]; then
    ln -s $CTERDAMTMUXCONF $TMUXCONFLOC
fi

# RIME =======================================================================

# CTERDAMRIMERC directory for all Rime dotfiles
export CTERDAMRIMERC="$CTERDAMRC/cterdam.rime"

# Make sure that CTERDAMRIMERC exists (if exists, nothing changes)
mkdir -p $CTERDAMRIMERC

# Symlink all my rime rc files into the correct location for Rime
rimeloc="$HOME/Library/Rime"
for cterdamrimercfile in $CTERDAMRIMERC/*
do
    rimercfile="$rimeloc/$(basename $cterdamrimercfile)"
    if [[ ! -f $rimercfile ]]; then
        ln -s $cterdamrimercfile $rimercfile
    fi
done

# ============================================================================

# Edit dotfiles with vim
rc () {
    case $1 in
        vim | vi)
            # Default file at ~/.vim/vimrc
            $EDITOR $CTERDAMVIMRC
            ;;
        zsh)
            # Default file at ~/.zshrc
            $EDITOR $CTERDAMZSHRC
            ;;
        tmux)
            # Default file at ~/.tmux.conf
            $EDITOR $CTERDAMTMUXCONF
            ;;
        rime)
            # Default folder at ~/Library/Rime
            cd $CTERDAMRIMERC
            ;;
        -h)
            echo "Available configs: vi(m), zsh, tmux, rime"
            ;;
        '')
            echo "Entering $CTERDAMRC"
            cd $CTERDAMRC
            ;;
        *)
            echo "No config for $1!"
            ;;
    esac
}

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

# Symlink rime-install to CTERDAMBIN, if not already present
plumloc="$CTERDAMHOME/plum"
if [[ ! -f $CTERDAMBIN/rime-install ]]; then
    ln -s $plumloc/rime-install $CTERDAMBIN/rime-install
fi

# }}}
# PATH {{{

# Prints each PATH directory on its own line
# (assumes no ':' in directory names)
alias showpath='echo $PATH | tr ":" "\n"'

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

# Adds something to PATH, head or tail, if not already included
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
