#如果npc不在运行就运行npc
NPC=\`ps -ef | grep npc | grep -v grep | wc -l\`
if [ \$NPC -eq 0 ];then
    nohup sh ~/npc.sh >> ~/npc.log 2>&1 &
fi