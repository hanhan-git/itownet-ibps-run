#!/bin/bash

show_usage="args: [-h, --m, -c]\
                                  [--home, --memory=, --command]"

p_home=$(cd `dirname $0`; pwd)
p_memory="1024M"
p_command="start"
agent_home=${p_home}/..

GETOPT_ARGS=`getopt -o h:m:c: -al home:,memory:,command: -- "$@"`
eval set -- "$GETOPT_ARGS"

while [ -n "$1" ]
do
        case "$1" in
		-h|--home) p_home=$2; shift 2;;
                -m|--memory) p_memory=$2; shift 2;;
                -c|--command) p_command=$2; shift 2;;
                --) break ;;
                *) echo $1,$2,$show_usage; break ;;
        esac
done

p_jar=`ls $p_home | grep '.jar$'`
md=`echo ${p_jar} | sed 's/\.jar//g'`

start() {
	echo "info: ---------------------------------------------"
	echo "info: --------------$md starting----------------"
	echo "info: ---------------------------------------------"

	if [ ! -f "$SPRING_PROFILES_ACTIVE" ];then
		active=`cat ${p_home}/config/application.yml | grep active | sed 's/active://g' | awk '{gsub(/^\s+|\s+$/, "");print}' | sed 's/SPRING_PROFILES_ACTIVE://g' | sed 's/${//g' | sed 's/}//g'`
	else
		active=$SPRING_PROFILES_ACTIVE
	fi
	cmdline=${p_home}/config/cmdline-${active}.txt
	echo "info: -- cmdline -- ${cmdline}"

	javaagent=''
	if [ ! -d "${agent_home}/agent" ];then
		echo "info: Skywalking agent is not exsits."
	elif [ `ls -A ${agent_home}/agent | wc -l` = "0" ];then
		echo "info: Skywalking agent is empty."
	elif [ ! -f "$cmdline" ];then
		echo "info: cmdline is not exsits."
	else
		options=`cat ${cmdline}`
		javaagent="-javaagent:${agent_home}/agent/skywalking-agent.jar${options}"
	fi
	echo "info: -- skywalking agent optionals -- ${javaagent}"

	java -Djava.awt.headless=true \
		-Dfile.encoding=UTF-8 \
		-Duser.timezone=GMT+8 \
		-Xms${p_memory} \
		-Xmx${p_memory} \
		${javaagent} \
		-jar ${p_home}/${p_jar} >/dev/null 2>&1 &
	
	echo "info: -- $md started!"
}

stop() {
	echo "---------------------------------------------"
	echo "--------------$md stoping----------------"
	echo "---------------------------------------------"

	if [ ! -f "$p_home/pid" ];then
		echo "info: -- $md is not started."
	else
		pid=$(cat $p_home/pid)
		kill -15 ${pid}
	fi
}

# See how we were called.
case "$p_command" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart|reload)
        stop
        start
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload}"
        exit 1
esac

exit
