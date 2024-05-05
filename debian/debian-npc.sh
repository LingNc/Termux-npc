#! /bin/bash

echo "准备安装npc"
PATH=$(pwd)
cd /opt/
#下载npc
echo ""
echo "下载npc中..."
wget --no-check-certificate -O npc.tar.gz https://raw.githubusercontent.com/LingNc/Termux-npc/master/file/linux_arm64_client.tar.gz > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功"
else
    echo "下载失败"
fi
mkdir ./npc > /dev/null 2>&1
tar -zxvf npc.tar.gz -C ./npc > /dev/null 2>&1
rm -f npc.tar.gz

#切换路径
cd ./npc > /dev/null 2>&1

#创建启动脚本
echo "创建启动脚本"
sleep 1
touch npc.sh
echo ""
echo "文件创建完毕请输入信息"
echo -n "请输入服务器IP地址(address):"
read Address
echo -n "请输入要链接的密钥(vkey):"
read PassWord

#设置服务器
echo "./npc -server=$Address:8024 -vkey=$PassWord -type=tcp" > npc.sh
chmod +x npc.sh


echo ""
echo "下载检测服务中..."
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/debian/npc-service.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功"
else
    echo "下载失败"
fi

echo ""
echo "下载重设服务"
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/debian/npc-reset.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi

echo ""
echo "下载状态服务"
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/debian/npc-status.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi

echo ""
echo "下载开始服务"
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/debian/npc-start.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi

echo ""
echo "下载停止服务"
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/debian/npc-stop.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi

echo ""

#去重
sed -i '/npc-service/d' ~/.profile
echo "/opt/npc/npc-service.sh" >> ~/.profile

sed -i '/npc-/d' ~/.bashrc
echo "alias npc-reset='/opt/npc/npc-reset.sh'" >> ~/.bashrc
echo "alias npc-start='/opt/npc/npc-start.sh'" >> ~/.bashrc
echo "alias npc-stop='/opt/npc/npc-stop.sh'" >> ~/.bashrc
echo "alias npc-status='/opt/npc/npc-status.sh'" >> ~/.bashrc

source ~/.profile
source ~/.bashrc

cd $PATH
rm -f $0
