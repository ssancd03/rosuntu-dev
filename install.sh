
#!/bin/bash
# set -e

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Installing Chrome     ${RESET}"
echo -e "${GREEN}========================${RESET}"

sudo apt-get install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code 

echo -e "${GREEN}========================${RESET}"
echo -e "${GREEN}  Installing Chrome     ${RESET}"
echo -e "${GREEN}========================${RESET}"

wget -qO- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > google-chrome.gpg
sudo install -D -o root -g root -m 644 google-chrome.gpg /etc/apt/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
rm -f google-chrome.gpg

sudo apt update
sudo apt install -y google-chrome-stable

echo -e "${YELLOW}================================${RESET}"
echo -e "${YELLOW} Installing GNOME Tools and Git ${RESET}"
echo -e "${YELLOW}================================${RESET}"

sudo apt install -y gnome-control-center git

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE}  Installing Docker     ${RESET}"
echo -e "${BLUE}========================${RESET}"
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o docker.asc
sudo install -D -o root -g root -m 644 docker.asc /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
rm -f docker.asc

sudo apt update
sudo apt install -y docker-ce
sudo groupmod -g 1000 docker

echo -e "${BLUE}========================${RESET}"
echo -e "${BLUE} Installing ROS 2 Jazzy ${RESET}"
echo -e "${BLUE}========================${RESET}"
sudo apt install -y software-properties-common curl
sudo add-apt-repository universe -y
sudo apt update

curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o ros-archive-keyring.gpg
sudo install -D -o root -g root -m 644 ros-archive-keyring.gpg /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
rm -f ros-archive-keyring.gpg

wget -qO- https://packages.osrfoundation.org/gazebo.gpg | gpg --dearmor > gazebo-keyring.gpg
sudo install -D -o root -g root -m 644 gazebo-keyring.gpg /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
rm -f gazebo-keyring.gpg

sudo apt update
sudo apt install -y ros-jazzy-desktop ros-jazzy-ros-gz gz-harmonic