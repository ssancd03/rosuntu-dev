
#!/bin/bash
# set -e

echo
echo "########################################################################"
echo "###### 1 Visual Studio Code"
echo "########################################################################"
echo

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