#!/bin/bash

brews=(
  git
  node
  nvm
  yarn
  zsh
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

casks=(
  iterm2
  rectangle
  spotify
  visual-studio-code
)

npms=(
  npm
  yarn
  commitizen
  cz-conventional-changelog
  gatsby-cli
  netlify-cli
)

extlist=(
  andys8.jest-snippets-1.8.0
  bungcip.better-toml-0.3.2
  capaj.vscode-standardjs-snippets-0.8.12
  christian-kohler.npm-intellisense-1.3.0
  dawhite.mustache-1.1.1
  dbaeumer.vscode-eslint-2.1.8
  dotjoshjohnson.xml-2.5.1
  esbenp.prettier-vscode-5.1.3
  felixfbecker.php-debug-1.13.0
  felixfbecker.php-intellisense-2.3.14
  file-icons.file-icons-1.0.24
  formulahendry.code-runner-0.11.0
  jpoissonnier.vscode-styled-components-0.0.29
  kumar-harsh.graphql-for-vscode-1.15.3
  marlon407.code-groovy-0.1.2
  ms-azuretools.vscode-docker-1.3.1
  ms-python.python-2020.7.94776
  ms-vscode.vscode-typescript-tslint-plugin-1.2.3
  orta.vscode-jest-3.2.0
  redhat.vscode-yaml-0.9.1
  shinnn.stylelint-0.51.0
  waderyan.gitblame-4.1.0
  wix.vscode-import-cost-2.12.0
  yzhang.markdown-all-in-one-3.1.0
)

set +e # Enables checking of commands
set -x # Print each command before it is executed

function prompt() {
  read -p "Hit Enter to $1 ..."
}

function install() {
  cmd=$1
  shift
  for pkg in $@;
  do
    exec="$cmd $pkg"
    echo "execute: $exec"
    if ${exec} ; then
      echo "installed $pkg"
    else
      echo "failed to execute: $exec"
    fi
  done
}

# Ask sudo access upfront
sudo -v

# Update Mac Software
sudo softwareupdate -i -a

# BREW
if test ! $(which brew); then
  prompt "install XCode"
  xcode-select --install

  prompt "install homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  prompt "update homebrew"

  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade
fi

# Disable sending data to Brew
brew analytics off

# RUBY
echo "update ruby"

# Install RVM and Ruby 2.5.0
brew install gpg
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BD
curl -sSL https://get.rvm.io | bash -s stable --ruby=2.5.0
ruby -v
sudo gem update --system

# BREW PACKAGES
echo "install brew packages"
install 'brew install' ${brews[@]}

# BREW CASK PACKAGES
echo "install brew cask packages"
install 'brew cask install' ${casks[@]}

# SECONDARY PACKAGES
echo "install secondary packages"
install 'npm install --global' ${npms[@]}

# VS Code Extensions
echo "install vs code packages"
install 'code --install-extension' ${extlist[@]}

# Remove outdated versions from the cellar.
echo "clean up"
brew cleanup
brew cask cleanup
gem cleanup

# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install ZSH autocompletions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Setup Mac OS
#echo "install Mac OS defaults"
#sh macos.sh

# SETUP PATH
# http://sourabhbajaj.com/mac-setup/Homebrew/
# https://github.com/driesvints/dotfiles/blob/master/path.zsh
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# Setup dock
#dockutil --no-restart --remove all
#dockutil --no-restart --add "/Applications/Firefox Developer Edition.app"
#dockutil --no-restart --add "/Applications/Hyper.app"
#dockutil --no-restart --add "/Applications/Visual Studio Code.app"
#dockutil --no-restart --add "/Applications/Spotify.app"

#killall Dock

echo "Done! You may need to reboot your machine for all changes to take effect"
