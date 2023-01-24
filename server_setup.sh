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
sudo apt-get -qq install zsh golang-go mono-complete vim-nox rustc octave bat git-extras less tree tldr vim

alert '>>> Installing snap packages'
sudo snap install node --classic

alert '>>> Installing npm packages'
sudo npm install --global yarn bash-language-server

alert '>>> Installing other packages'
# Install tmux plugin manager
git clone --quiet https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

alert '>>> Cloning dotfiles >>>'
git clone --quiet --recursive git@github.com:cterdam/dotfiles.git $HOME/cterdam/dotfiles

alert '>>> Linking up dotfiles'
rm $HOME/.*.pre-oh-my-zsh* || true
rm $HOME/.zshrc || true
mkdir -p $HOME/.config
sudo chown -R $(whoami) $HOME/.config
ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc

alert '>>> Installing oh-my-zsh'
alert '    Remember to make zsh default.'
rm -rf $HOME/.oh-my-zsh || true
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
