# Arch Linux

---

##  安装

```
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect <name>
exit
```

```
lsblk
gdisk /dev/nvme
x
z
```

>archinstall

---
### 网络管理

> nmcli deivice wifi list
> nmcli device wifi connect <name> password <pass>

### 编辑系统文件

>su - 
EDITOR=nano visudo 
nvim etc/environment 
nvim /etc/pacman.conf 
nvim /etc/locale.gen && locale-gen
nvim /boot/loader/loader.conf
nvim /usr/share/icons/default/index.theme
sudo pacman -Syyu

### AUR 工具与开发环境

```
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru 
makepkg-si
```

### 安装资源

>sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono-nerd ttf-roboto

### keyd

```
sudo pacman -S keyd
systemctl enable keyd --now
sudo nvim /etc/keyd/default.conf

```

```
[ids]

*

[main]

capslock = leftmeta
leftmeta = capslock

[shift]

esc = S-grave

```
>sudo keyd reload 

### shared

```
sudo pacman -S nvim 
sudo pacman -S fastfetch ncdu man wev
sudo pacman -S timeshift
sudo pacman -S foot fish starship
sudo pacman -S awww waybar rofi
sudo pacman -S mako libnotify
sudo pacman -S yazi ueberzug 7zip unzip unrar
sudo pacman -S btop
sudo pacman -S wl-clipboard cliphist 
sudo pacman -S brightnessctl
sudo pacman -S grim slurp tesseract 
sudo pacman -S mpd mpc mpv
sudo pacman -S ffmpeg imagemagick
sudo pacman -S fcitx5-im fcitx5-chinese-addons
sudo pacman -S obsidian zathura zathura-pdf-mupdf
sudo pacman -S opencode
sudo pacman -S tree-sitter-cli make bear ripgrep
sudo pacman -S python python-requests
sudo pacman -S openssh sshfs

paru -Sy brave-origin-bin



```

### hyprland 

```
sudo pacman -S hyprland 
sudo pacman -S hyprpolkitagent
sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
sudo pacman -S qt5-wayland qt6-wayland 
sudo pacman -S hypridle hyprlock hyprpicker 

```
### 固件配置

```
sudo pacman -S --needed sof-firmware alsa-ucm-conf alsa-firmware 
sudo pacman -S --needed pipewire wireplumber pipewire-pulse pipewire-alsa pipewire-jack 
systemctl --user enable --now pipewire pipewire-pulse wireplumber

sudo pacman -S --needed bluez
sudo systemctl enable --now bluetooth
```

### 驱动配置
```
sudo pacman -S linux-headers

sudo pacman -S nvidia-open-dkms nvidia-settings nvidia-utils lib32-nvidia-utils
sudo pacman -S libva-nvidia-driver


sudo pacman -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel 
sudo pacman -S intel-media-driver

sudo pacman -S libva-utils
vainfo
```

```
ls -l /dev/dri/by-path
lspci | grep -E "VGA|3D"
```

https://github.com/niri-wm/niri/issues/2516

```
# /etc/modprobe.d/nvidia.conf
options nvidia_drm modeset=1
options nvidia NVreg_EnableGpuFirmware=1
options nvidia NVreg_PreserveVideoMemoryAllocations=1
options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerDefault=0x1; PowerMizerDefaultAC=0x1; PerfLevelSrc=0x2222"


```

```shell
sudo mkinitcpio -P
```

```
/etc/mkinitcpio.conf

MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm ...)
```

https://niri-wm.github.io/niri/Nvidia.html

https://wiki.hypr.land/Nvidia/


### 启动自动登录和会话

```
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/

sudoedit /etc/systemd/system/getty@tty1.service.d/autologin.conf

[Service]
ExecStart=
ExecStart=-/sbin/agetty --noreset --noclear --autologin lzx ${TERM}
```

``` .bash_profile

if [ -z "$DISPLAY" ] && [ "$(tty)" == "/dev/tty1" ]; then
     exec 
fi
```

___

### 配置

```
sudo pacman -S zram-generator
sudo nvim /etc/systemd/zram-generator.conf

sudo pacman -S power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon 
powerprofilesctl set performance

sudo pacman -S rate-mirrors
rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist
 
sudoedit /etc/systemd/resolved.conf
[Resolved]
DNS=1.1.1.1 1.0.0.1
FallbackDNS=8.8.8.8 8.8.4.4
systemctl restart systemd-resolved

systemctl start sshd
systemctl enable sshd --now
ssh lzx@192.168.0.1
sshfs lzx@192.168.0.1:/home/lzx ~/Directory

sudo pacman -S envyconrtol
sudo envycontrol -s hybrid

sudoedit /etc/timeshift/default.json
```





