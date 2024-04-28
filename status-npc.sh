NPC=\`ps -ef | grep npc | grep -v grep | wc -l\`
if [ \$NPC -eq 0 ];then
    echo "npc未运行"
else
    echo "npc正在运行"
fi