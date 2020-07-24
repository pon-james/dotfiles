#!/bin/bash

brews=(
  git
  node
  pyenv
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
  postman
  docker
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
  bungcip.better-toml
  capaj.vscode-standardjs-snippets
  christian-kohler.npm-intellisense
  dawhite.mustache
  dbaeumer.vscode-eslint
  dotjoshjohnson.xml
  esbenp.prettier-vscode
  felixfbecker.php-debug
  felixfbecker.php-intellisense
  file-icons.file-icons
  formulahendry.code-runner
  jpoissonnier.vscode-styled-components
  kumar-harsh.graphql-for-vscode
  marlon407.code-groovy
  ms-azuretools.vscode-docker
  ms-python.python
  ms-vscode.vscode-typescript-tslint-plugin
  orta.vscode-jest
  redhat.vscode-yaml
  shinnn.stylelint
  waderyan.gitblame
  wix.vscode-import-cost
  yzhang.markdown-all-in-one
  fauna.faunadb
  ms-vsliveshare.vsliveshare-pack
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
gem cleanup

# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install ZSH autocompletions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install GCloud SDK
curl https://sdk.cloud.google.com | bash


echo "Done! You may need to reboot your machine for all changes to take effect"
