#!/bin/bash

# Function to update and upgrade the system
update_system() {
    sudo apt update && sudo apt upgrade -y
}

# Function to install ZSH
install_zsh() {
    sudo apt install -y zsh
    chsh -s $(which zsh)
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    sudo apt install -y curl git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Function to install Zinit and add plugins
install_zinit_and_plugins() {
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

    # Ensure the Zinit configuration is added only once
    if ! grep -q "zinit light zdharma-continuum/fast-syntax-highlighting" ~/.zshrc; then
        cat << 'EOF' >> ~/.zshrc

# Zinit configuration
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir -p ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

EOF
    fi
}

# Function to install Nerd Fonts
install_nerd_fonts() {
    mkdir -p ~/.fonts
    wget -P ~/.fonts 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/BitstreamVeraSansMono.zip'
    unzip ~/.fonts/BitstreamVeraSansMono.zip -d ~/.fonts
    fc-cache -fv
}

# Function to install Fira Code font
install_fira_code_font() {
    sudo apt install -y fonts-firacode
}

#Function that install git
install_git(){
    add-apt-repository ppa:git-core/ppa
    sudo apt install -y git
}

#Function that install python
install_python(){
    sudo add-apt-repository ppa:deadsnakes/ppa ;sudo apt update
    sudo apt install -y python3.12
}

# Main function to run all steps
main() {
    update_system
    install_zsh
    install_oh_my_zsh
    install_zinit_and_plugins

    # Uncomment the following lines to install Nerd Fonts and Fira Code font
    # install_nerd_fonts
    # install_fira_code_font

    echo "Please log out and log back in for the changes to take effect."
}

# Run the main function
main