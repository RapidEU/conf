#!/bin/sh

https://www.kali.org/docs/virtualization/install-vmware-guest-tools/

############################################################################
# vmware stuff
############################################################################

# Kali installation
sudo apt update
sudo apt install -y --reinstall open-vm-tools-desktop fuse
#sudo reboot -f

# Shared folders enable
cat <<EOF | sudo tee /usr/local/sbin/mount-shared-folders
#!/bin/sh
vmware-hgfsclient | while read folder; do
  vmwpath="/mnt/hgfs/\${folder}"
  echo "[i] Mounting \${folder}   (\${vmwpath})"
  sudo mkdir -p "\${vmwpath}"
  sudo umount -f "\${vmwpath}" 2>/dev/null
  sudo vmhgfs-fuse -o allow_other -o auto_unmount ".host:/\${folder}" "\${vmwpath}"
done
sleep 2s
EOF
sudo chmod +x /usr/local/sbin/mount-shared-folders
sudo mount-shared-folders
# mount drivers at /mnt/hgfs/

############################################################################
# Update and shit
############################################################################
sudo apt update

############################################################################
# Tools
############################################################################

# Install golang
#TODO

cd /home/kali/Documents
git clone https://github.com/maurosoria/dirsearch.git
git clone https://github.com/drwetter/testssl.sh.git
git clone https://github.com/irsdl/IIS-ShortName-Scanner.git


cd /bin/
# Symoblic Link for quick access
sudo ln -s /home/kali/Documents/dirsearch/dirsearch.py dirsearch
sudo ln -s /home/kali/Documents/testssl.sh/testssl.sh testssl
sudo ln -s /home/kali/Documents/IIS-ShortName-Scanner/iis_shortname_scanner.jar iis_sn_scan
