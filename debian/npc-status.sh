NPC=`ps -a | grep npc | grep -v grep | awk '{print $2}'`
if [ "$NPC" != "" ];then
    echo "npc正在运行"
else
    echo "npc未启动"
fi
    