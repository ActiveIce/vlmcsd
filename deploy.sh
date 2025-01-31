 #!/bin/bash

if [ 0 == $UID ]; then
    echo -e "当前用户是root用户，进入安装流程"
    sleep 3
else
    echo -e "当前用户不是root用户，请用 sudo su 命令切换到root用户后重新执行脚本"
    exit 1    
fi

apt update && apt upgrade -y && apt autoremove -y

if [[ -f /usr/bin/vlmcsd ]]; then
    echo -e "更新vlmcsd"
    systemctl stop vlmcsd
    wget --no-check-certificate -O /usr/bin/vlmcsd https://raw.githubusercontent.com/ActiveIce/vlmcsd/master/vlmcsd
    systemctl start vlmcsd
    echo -e "vlmcsd更新成功"
    exit 0
fi

echo -e "开始安装vlmcsd"
wget --no-check-certificate -O /usr/bin/vlmcsd https://raw.githubusercontent.com/ActiveIce/vlmcsd/master/vlmcsd
wget --no-check-certificate -O /etc/systemd/system/vlmcsd.service https://raw.githubusercontent.com/ActiveIce/vlmcsd/master/vlmcsd.service
chmod +x /usr/bin/vlmcsd
systemctl start vlmcsd
systemctl enable vlmcsd
echo -e "vlmcsd安装成功"

exit 0
