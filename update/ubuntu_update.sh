#!/bin/bash
echo "Ubuntu Update Start."

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean -y

# sudo reboot
echo "Ubuntu Update Finished."