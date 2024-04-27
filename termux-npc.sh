#!/bin/bash
cd ~
clear
echo "正在安装基本组件..."
pkg update
pkg upgrade
echo "正在安装软件包..."
pkg install vim openssh
if [ $? -eq 0 ];then
    echo "基本组件成功安装！"
else
    echo "基本组件安装失败！"
fi
sleep 3

echo "基本组件安装完毕!"
sleep 1
echo "请输入ssh密码:"
passwd
if [ $? -eq 0 ];then
    echo ""
else
    passwd
fi

echo "启动ssh服务..."
sshd > /dev/null
if [ $? -eq 0 ];then
    echo "启动ssh成功！"
else
    echo "启动ssh失败！"
fi

echo ""
echo "安装npc服务"
echo "下载npc中..."
#下载npc
wget --no-check-certificate -O npc.tar.gz https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_arm64_client.tar.gz > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！请检查网络连接！"
fi

mkdir ~/npc
tar -zxvf npc.tar.gz -C ~/npc > /dev/null
cd ~/npc > /dev/null 2>&1

echo ""
echo "创建启动脚本"
touch npc.sh

echo -n "请输入服务器IP地址(address):"
read Address
echo -n "请输入要链接的密钥(vkey):"
read PassWord

echo ""

echo "设置服务器"
echo "~/npc/npc -server=$Address:8024 -vkey=$PassWord -type=tcp" > npc.sh
chmod 777 npc.sh
if [ $? -eq 0 ];then
    echo "设置成功"
else
    echo "设置失败"
fi

echo ""
echo "设置自启动"
#设置自动启动
mkdir -p $PREFIX/var/service/npc
touch $PREFIX/var/service/npc/run
cd $PREFIX/var/service/npc
echo "#!/data/data/com.termux/files/usr/bin/sh" >> run
echo "exec 2>&1" >> run
echo "exec ~/npc/npc.sh 2>&1" >> run

chmod +x $PREFIX/var/service/npc/run

mkdir -p $PREFIX/var/service/npc/log
touch $PREFIX/var/service/npc/log/run
cd $PREFIX/var/service/npc/log
echo "#!/data/data/com.termux/files/usr/bin/sh" >> run
echo "svlogger=\"/data/data/com.termux/files/usr/share/termux-services/svlogger\"" >> run
echo "exec \"${svlogger}\" \"$@\"" >> run
chmod +x $PREFIX/var/service/npc/log/run
if [ $? -eq 0 ];then
    echo "设置成功"
else
    echo "设置失败"
fi

cd ~/npc
#安装termux-services
echo ""
echo "安装守护进程"
pkg install termux-services
cd ~
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/autorun.sh > /dev/null 2>&1
echo "sh ~/autorun.sh" >> ~/.bashrc
if [ $? -eq 0 ];then
    echo "安装成功！"
else
    echo "安装失败！"
fi

echo ""

echo "下载重设服务"
cd ~/npc
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/reset-npc.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi

echo "alias npc-reset='sh ~/npc/reset-npc.sh'" >> ~/.bashrc
echo "alias npc-start='sv up npc'" >> ~/.bashrc
echo "alias npc-stop='sv down npc'" >> ~/.bashrc
echo "alias npc-status='sv status npc'" >> ~/.bashrc
echo "请输入exit退出并重启以完成安装！！！\n"
sleep 3
exit