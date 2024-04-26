sv-enable npc
sv-enable sshd

sed -i '/autorun/d' ~/.bashrc
sed -i '/npc-/d' ~/.bashrc

rm -f npc.tar.gz
rm -f ~/termux-npc.sh
rm -f $0 