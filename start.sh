#!/bin/sh

sh /getfilter.sh && pkill overture
#echo "restart" > /tmp/overture # 重启信号

# pkill overture # 杀进程
# 
# cd $OVERTURE_HOME
# $OVERTURE_HOME/overture &
