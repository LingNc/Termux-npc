echo "安装npc"
#下载npc
wget --no-check-certificate -O npc.tar.gz https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_arm64_client.tar.gz > /dev/null 2>&1
mkdir ~/npc && tar -zxvf npc.tar.gz -C ~/npc && cd ~/npc > /dev/null 2>&1
#创建启动脚本
touch npc.sh

echo -n "请输入服务器IP地址(address):"
read Address
echo -n "请输入要链接的密钥(vkey):"
read PassWord


#设置服务器
echo "~/npc/npc -server=$Address:8024 -vkey=$PassWord -type=tcp" > npc.sh
chmod 777 npc.sh

echo "NPC=\`ps -ef | grep npc | grep -v grep | wc -l\`" >> ~/.bashrc
echo "if [ \$NPC -eq 0 ];then" >> ~/.bashrc
echo "    nohup sh ~/npc.sh >> ~/npc.log 2>&1 &" >> ~/.bashrc
echo "fi" >> ~/.bashrc
source ~/.bashrc
rm $0
