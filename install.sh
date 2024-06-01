#!/bin/bash

# Install required dependencies
yay -S --needed base-devel strawberry brightnessctl network-manager-applet telegram-desktop wofi konsole blueman ark dolphin ffmpegthumbs playerctl kvantum polkit-kde-agent ttf-font-awesome-5 jq gufw qt5ct tar gammastep wl-clipboard nwg-look-bin visual-studio-code-bin firefox easyeffects hyprpicker hyprshot-git bc sysstat kitty sassc systemsettings ttf-font-awesome-5 orchis-theme-git acpi fish kde-material-you-colors plasma5support plasma5-integration plasma-framework5 aylurs-gtk-shell-git ttf-jetbrains-mono-nerd ttf-fantasque-nerd powerdevil gnome-bluetooth-3.0 power-profiles-daemon libjpeg6-turbo

# Clone the Hyprland configuration repository
git clone git@github.com:AhmedSaadi0/my-hyprland-config.git

# Backup existing configuration files
mv ~/.config/hypr/ ~/.config/hypr-old
mv ~/.config/ags/ ~/.config/ags-old
mv ~/.config/wofi/ ~/.config/wofi-old
mv ~/.config/easyeffects ~/.config/easyeffects-old
cp ~/.config/fish/config.fish ~/.config/fish/config.back.fish

# Copy new configuration files
cp -r my-hyprland-config ~/.config/hypr
cp -r ~/.config/hypr/config/ags ~/.config/ags
cp -r ~/.config/hypr/config/wofi ~/.config/wofi
cp ~/.config/hypr/config/config.fish ~/.config/fish/config.fish

# Set permissions for scripts
sudo chmod +x ~/.config/hypr/scripts/*
sudo chmod +x ~/.config/ags/scripts/*

# Setup environment
sudo cp /etc/environment /etc/environmentOLD
echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment

# Copy EasyEffects settings
cp -r ~/.config/hypr/config/easyeffects ~/.config/easyeffects

# Copy theme files
mkdir -p ~/.local/share/color-schemes/
mkdir -p ~/.local/share/konsole/
mkdir -p ~/.config/Kvantum/
mkdir -p ~/.config/qt5ct/
mkdir -p ~/.config/qt6ct/

cp -r ~/.config/hypr/config/plasma-colors/* ~/.local/share/color-schemes/
cp -r ~/.config/hypr/config/kvantum-themes/* ~/.config/Kvantum/
cp -r ~/.config/hypr/config/konsole/* ~/.local/share/konsole/
cp ~/.config/hypr/config/qt5ct.conf ~/.config/qt5ct/
cp ~/.config/hypr/config/qt6ct.conf ~/.config/qt6ct/

# Install fonts
mkdir -p ~/.fonts
cp -r ~/.config/hypr/config/.fonts/* ~/.fonts

# Install icons
mkdir -p ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/BeautySolar.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Delight-brown-dark.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Gradient-Dark-Icons.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Infinity-Dark-Icons.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/kora-grey-light-panel.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Magma.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/NeonIcons.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/la-capitaine-icon-theme.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/oomox-aesthetic-dark.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Vivid-Dark-Icons.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Windows11-red-dark.tar.gz -C ~/.local/share/icons
tar xvf ~/.config/hypr/config/icons/Zafiro-Nord-Dark-Black.tar.gz -C ~/.local/share/icons

# Install GTK themes
mkdir -p ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Cabinet-Light-Orange.tar.gz -C ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Kimi-dark.tar.gz -C ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Nordic-darker-standard-buttons.tar.gz -C ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Orchis-Green-Dark-Compact.tar.gz -C ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Shades-of-purple.tar.xz -C ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Tokyonight-Dark-BL.tar.gz -C ~/.themes
tar xvf ~/.config/hypr/config/gtk-themes/Dracula.tar.gz -C ~/.themes

# Create crontab for battery 40-80 rule
(crontab -l 2>/dev/null; echo "* * * * * ~/.config/hypr/scripts/battery.sh") | crontab -

# Update battery script path
sed -i 's|home_path="/home/rr-h"|home_path="'$HOME'"|' ~/.config/hypr/scripts/battery.sh

# Create configuration file
cat <<EOL > ~/.rr-h-config.json
{
  "username": "rr-h",
  "networkTimeout": 300,
  "networkInterval": 1000,
  "darkM3WallpaperPath": "/home/rr-h/wallpapers/dark",
  "lightM3WallpaperPath": "/home/rr-h/wallpapers/light",
  "weatherLocation": "cambridge",
  "city": "cambridge",
  "country": "united kingdom"
}
EOL

echo "Installation and setup complete. Please reboot your system."
