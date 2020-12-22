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
                *) echo $1,$2,${show_usage}; break ;;
        esac
done

p_jar=`ls ${p_home} | grep '.jar$'`
md=`echo ${p_jar} | sed 's/\.jar//g'`

start() {
	echo "---------------------------------------------"
	echo "--------------$md starting----------------"
	echo "---------------------------------------------"

	javaagent=''
	if [ ! -d "${agent_home}/agent" ];then
		echo "info: Skywalking agent is not exsits."
	elif [ `ls -A ${agent_home}/agent | wc -l` = "0" ];then
		echo "info: Skywalking agent is empty."
	else
		javaagent="-javaagent:${agent_home}/agent/skywalking-agent.jar"
	fi
	
	IBPS_JVM_OPTS='-Xms${p_memory} -Xmx${p_memory}';
	if [ -n '${ENV_IBPS_JVM_OPTS}' ] ; then
	    IBPS_JVM_OPTS=${ENV_IBPS_JVM_OPTS}
	fi

	java -Djava.awt.headless=true \
		-Dfile.encoding=UTF-8 \
		-Duser.timezone=GMT+8 \
		${IBPS_JVM_OPTS} \
		${javaagent} \
		-jar ${p_home}/${p_jar}
}

stop() {
	echo "info: ---------------------------------------------"
	echo "info: --------------$md stoping----------------"
	echo "info: ---------------------------------------------"

	if [ ! -f "$p_home/pid" ];then
		echo "info: -- $md is not started."
	else
		pid=$(cat $p_home/pid)
		kill -9 ${pid}
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
