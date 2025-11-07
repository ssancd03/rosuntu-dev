#!/usr/bin/env bash
set -e

GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}   Update and Upgrade   ${RESET}"
echo -e "${GREEN}========================${RESET}"
apt update && apt upgrade -y

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE} Installing ROS 2 Jazzy ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install software-properties-common -y
add-apt-repository universe -y
apt update && apt install curl -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list
wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list
apt update
apt install -y ros-jazzy-desktop ros-jazzy-ros-gz gz-harmonic

echo -e "${YELLOW}================================${RESET}"
echo -e "${YELLOW} Installing GNOME Tools and Git ${RESET}"
echo -e "${YELLOW}================================${RESET}"
apt install gnome-control-center git -y

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}  Installing Kernel     ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install -y linux-generic
update-initramfs -c -k all

echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN}  Installing VSCode     ${RESET}"
echo -e "${CYAN}========================${RESET}"
apt install -y apt-transport-https wget
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
apt update
apt install -y code

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Installing Chrome     ${RESET}"
echo -e "${GREEN}========================${RESET}"
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt update
apt install -y google-chrome-stable

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}  Installing Docker     ${RESET}"
echo -e "${BLUE}========================${RESET}"
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce -y
groupmod -g 1000 docker

echo -e "${YELLOW}========================${RESET}"
echo -e "${YELLOW}  Preparing Plymouth    ${RESET}"
echo -e "${YELLOW}========================${RESET}"
mkdir -p /usr/share/plymouth/themes/rosuntu
cp plymouth/*.png /usr/share/plymouth/themes/rosuntu/
cp plymouth/rosuntu.script /usr/share/plymouth/themes/rosuntu/
cp plymouth/rosuntu.plymouth /usr/share/plymouth/themes/rosuntu/
update-alternatives --install "/usr/share/plymouth/themes/default.plymouth" "default.plymouth" "/usr/share/plymouth/themes/rosuntu/rosuntu.plymouth" 160

echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN}  Setting Login Screen  ${RESET}"
echo -e "${CYAN}========================${RESET}"
cp logo/ROSuntu_logo-small.png /usr/share/pixmaps/ubuntu-logo.png
cp logo/ROSuntu_logo.png /usr/share/pixmaps/ubuntu-logo-text.png

echo -e "${GREEN}================================${RESET}"
echo -e "${GREEN}Configuring Installer Slideshow ${RESET}"
echo -e "${GREEN}================================${RESET}"
rm -rf /usr/share/desktop-provision/slides
mkdir -p /usr/share/desktop-provision/slides
cp -r slides/* /usr/share/desktop-provision/slides/

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Preparing Wallpapers  ${RESET}"
echo -e "${GREEN}========================${RESET}"
mkdir -p /usr/share/backgrounds/rosuntu
cp wallpaper/*.png /usr/share/backgrounds/rosuntu/
cp wallpaper/rosuntu-wallpapers.xml /usr/share/gnome-background-properties/rosuntu-wallpapers.xml

echo -e "${YELLOW}========================${RESET}"
echo -e "${YELLOW} Configuring Defaults   ${RESET}"
echo -e "${YELLOW}========================${RESET}"
cp conf/90_ubuntu-settings.gschema.override /usr/share/glib-2.0/schemas/
glib-compile-schemas /usr/share/glib-2.0/schemas
mkdir -p /etc/dconf/profile
cp conf/dconf-profile-user /etc/dconf/profile/user
mkdir -p /etc/dconf/db/local.d
cp conf/00-favorite-apps /etc/dconf/db/local.d/00-favorite-apps
cp conf/01-background /etc/dconf/db/local.d/01-background
dconf update

echo -e "${CYAN}========================${RESET}"
echo -e "${CYAN} Configuring .bashrc    ${RESET}"
echo -e "${CYAN}========================${RESET}"
echo "source /opt/ros/jazzy/setup.bash" >> /etc/skel/.bashrc