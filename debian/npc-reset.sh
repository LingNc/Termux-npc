echo "重新设置服务器"
echo -n "请输入服务器IP地址(address):"
read Address
echo -n "请输入要链接的密钥(vkey):"
read PassWord

echo ""

echo "设置服务器"
stop-npc

cd /opt/npc
echo "./npc -server=$Address:8024 -vkey=$PassWord -type=tcp" > ./npc.sh

npc-start

if [ $? -eq 0 ];then
    echo "设置成功！"
else
    echo "设置失败！"
fi
chmod +x ./npc.sh