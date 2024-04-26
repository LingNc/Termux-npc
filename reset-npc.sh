echo "重新设置服务器"
echo -n "请输入服务器IP地址(address):"
read Address
echo -n "请输入要链接的密钥(vkey):"
read PassWord

echo ""

echo "设置服务器"
sv down npc

echo "~/npc/npc -server=$Address:8024 -vkey=$PassWord -type=tcp" > ~/npc/npc.sh

sv up npc
if [ $? -eq 0 ];then
    echo "设置成功！"
else
    echo "设置失败！"
fi
chmod 777 ~/npc/npc.sh