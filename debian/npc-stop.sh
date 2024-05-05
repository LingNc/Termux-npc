NPC=`ps -a | grep npc | grep -v grep | awk '{print $2}'`
if [ "$NPC" != "" ];then
    pkill npc.sh
    if [ $? -eq 0 ];then
        echo "已停止npc"
    else
        echo "停止失败"
    fi
fi