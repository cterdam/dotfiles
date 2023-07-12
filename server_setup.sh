# Define output text style
RED=$(tput setaf 1)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
alert () {
    echo -e "${RED}${BOLD}$@${NORMAL}"
}

alert '>>> Setting system password'
sudo passwd $(whoami)

alert '>>> Installing apt-get packages'
sudo apt-get -qq update
# Preambles for installing mono
# adapted from https://www.mono-project.com/download/stable/#download-lin-ubuntu
sudo apt-get -qq install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt -qq update
# Add apt repo to install latest vim
sudo add-apt-repository ppa:jonathonf/vim
# Finally install all desired packages
sudo apt-get -qq install zsh golang-go mono-complete vim-nox rustc octave bat git-extras less tree tldr vim ruby-full build-essential zlib1g-dev shellcheck
pip install vim-vint

alert '>>> Installing snap packages'
sudo snap install node --classic

alert '>>> Installing npm packages'
sudo npm install --global yarn bash-language-server

alert '>>> Installing other packages'
# Install tmux plugin manager
git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
# Install Jekyll
gem install jekyll bundler

alert '>>> Cloning dotfiles >>>'
git clone --quiet --recursive git@github.com:cterdam/dotfiles.git $HOME/cterdam/dotfiles

alert '>>> Other prep'
mkdir -p $HOME/.config
sudo chown -R $(whoami) $HOME/.config

alert '>>> Installing oh-my-zsh'
alert '    Remember to make zsh default.'
rm -rf $HOME/.oh-my-zsh || true
# Install Conda completion plugin
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/conda-zsh-completion
# Install p10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
