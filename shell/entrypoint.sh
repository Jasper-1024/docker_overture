#!/bin/sh
COMMAND=$OVERTURE_HOME/overture
DEFAULT_ARGS="-c $OVERTURE_HOME/config.yml"

if [ "$1" = "--help" ]; then
    set -- "$COMMAND" -h
else
    cd "$OVERTURE_HOME"
    set -- "$COMMAND" $@
    # crond # 启动定时任务
    # cd "$OVERTURE_HOME" || exit
    # nohup "$COMMAND" "$@" >myout.file 2>&1 &

    # while true; do
    #     server=$OVERTURE
    #     if [ ! "$server" ]; then
    #         #如果不存在就重新启动
    #         nohup "$COMMAND" "$@" >myout.file 2>&1 &
    #         #延迟10s
    #         sleep 10
    #     fi
    #     #每次循环沉睡5s
    #     sleep 5
    # done
fi

exec "$@"
