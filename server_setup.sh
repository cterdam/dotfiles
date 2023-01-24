# To scp GitHub key into instance, run this:
# scp -i <key> <github_key_file> <username>@<ip4add>:~/.ssh
# For example:
# scp -i "~/.ssh/joshlee_asb.pem" ~/.ssh/id_ed25519 ubuntu@ec2-3-89-155-29.compute-1.amazonaws.com:~/.ssh

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
# Finally install all desired packages
sudo apt-get -qq install zsh golang-go mono-complete vim-nox rustc octave bat git-extras less tree tldr

alert '>>> Installing snap packages'
sudo snap install node --classic

alert '>>> Installing npm packages'
sudo npm install --global yarn bash-language-server

alert '>>> Installing other packages'
# Install tmux plugin manager
git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

alert '>>> Cloning dotfiles >>>'
git clone --quiet --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles

alert '>>> Installing oh-my-zsh'
alert '    Remember to make zsh default.'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

alert 'Here!'