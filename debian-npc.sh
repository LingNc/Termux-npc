echo "准备安装npc"
PATH=$(pwd)
cd ~
#下载npc
echo ""
echo "下载npc中..."
wget --no-check-certificate -O npc.tar.gz https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_arm64_client.tar.gz > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功"
else
    echo "下载失败"
fi
mkdir ~/npc > /dev/null 2>&1
tar -zxvf npc.tar.gz -C ~/npc > /dev/null 2>&1
cd ~/npc > /dev/null 2>&1
#创建启动脚本
touch npc.sh
echo ""
echo "文件创建完毕请输入信息"
echo -n "请输入服务器IP地址(address):"
read Address
echo -n "请输入要链接的密钥(vkey):"
read PassWord


#设置服务器
echo "~/npc/npc -server=$Address:8024 -vkey=$PassWord -type=tcp" > npc.sh
chmod 777 npc.sh
echo ""
echo "下载检测服务中..."
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/run-check-npc.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功"
else
    echo "下载失败"
fi
#去重
sed -i '/run-check-npc/d' ~/.bashrc
echo "sh run-check-npc.sh &" >> ~/.bashrc

echo ""
echo "下载重设服务"
cd ~/npc
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/reset-npc.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi

echo ""
echo "下载状态服务"
cd ~/npc
wget https://raw.githubusercontent.com/LingNc/Termux-npc/master/status-npc.sh > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo "下载成功！"
else
    echo "下载失败！"
fi
#去重
sed -i '/npc-/d' ~/.bashrc
echo "alias npc-reset='sh ~/npc/reset-npc.sh'" >> ~/.bashrc
echo "alias npc-start='sh ~/npc/run-check-npc.sh &'" >> ~/.bashrc
echo "alias npc-stop='killall run-check-npc npc'" >> ~/.bashrc
echo "alias npc-status='sh ~/npc/status-npc'" >> ~/.bashrc

source ~/.bashrc

rm -f npc.tar.gz
cd $PATH
rm -f $0
