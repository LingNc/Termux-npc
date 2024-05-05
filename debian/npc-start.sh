#检查npc是否在运行，不在就运行
NPC=`ps -ef | grep npc.sh | grep -v grep | awk '{print $2}'`
if [ "$NPC" == "" ];then
    cd /opt/npc
    nohup ./npc.sh >> ./npc.log 2>&1 &
fi