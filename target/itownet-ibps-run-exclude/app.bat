@echo off

for %%j in (*.jar) do (
set jar_file=%%j
)

@title %jar_file%

set mem=512M

echo [%date:~0,10% %time:~0,8%]
echo [%date:~0,10% %time:~0,8%] ---------------------------------------------
echo [%date:~0,10% %time:~0,8%] --------------%jar_file% starting----------------
echo [%date:~0,10% %time:~0,8%] ---------------------------------------------
echo [%date:~0,10% %time:~0,8%]

rem  -javaagent:%cd%\\..\\agent\\skywalking-agent.jar
java -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Duser.timezone=GMT+8 -Xms%mem% -Xmx%mem% -jar %jar_file%