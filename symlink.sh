
#!/bin/bash

# CONFIGURE GIT
#ln -sf $(pwd)/.gitconfig ~/.gitconfig
#ln -sf $(pwd)/.gitignore_global ~/.gitignore_global

# VS Code
echo "symlink VS code settings"
ln -sf $(pwd)/vs-code-settings.json ~/Library/Application\ Support/Code/User/settings.json

# SETUP ALIASES ETC
#echo "symlink aliases and functions"
#ln -sf $(pwd)/env.sh ~/env.sh

echo "symlink zshrc config"
ln -sf $(pwd)/.zshrc ~/.zshrc

echo "symlink czrc config"
ln -sf $(pwd)/.czrc ~/.czrc

#echo "symlink hyper config"
#ln -sf $(pwd)/.hyper.js ~/.hyper.js

#echo "symlink gemrc"
#ln -sf $(pwd)/.gemrc ~/.gemrc

#echo "symlink .npmrc"
#ls -sf $(pwd)/.npmrc ~/.npmrc
