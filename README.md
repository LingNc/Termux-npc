## Termux安装 npc客户端 实现ssh远程访问
### 一键安装脚本
##### 先更新软件源然后安装wget
```shell
pkg update
pkg install wget
```
##### 按照脚本提示进行即可
Termux
```shell
wget https://raw.githubusercontent.com/LingNc/Termux_npc/main/termux-npc.sh && sh termux-npc.sh
```
Aidlux
```shell
wget https://raw.githubusercontent.com/LingNc/Termux_npc/main/aidlux-npc.sh && sh aidlux-npc.sh
```