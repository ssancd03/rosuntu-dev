
#!/bin/bash
# set -e

echo
echo "########################################################################"
echo "###### 1 Visual Studio Code"
echo "########################################################################"
echo

apt install -y apt-transport-https wget
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
apt update
apt install -y code
