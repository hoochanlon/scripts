echo "下载java，并自动安装"
@echo off
:: IF NOT EXIST C:\Users\%USERNAME%\Downloads\java.msi (curl -o C:\Users\%USERNAME%\Downloads\java.msi https://download.oracle.com/java/20/latest/jdk-20_windows-x64_bin.msi)
curl -o C:\Users\%USERNAME%\Downloads\java.msi https://download.oracle.com/java/20/latest/jdk-20_windows-x64_bin.msi

@REM 缓一秒，静默安装java.msi；/S /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /FORCE
TIMEOUT /T 1&&start /wait C:\Users\%USERNAME%\Downloads\java.msi /quiet /passive

@REM ::----- 配置java环境 -------------------

@REM 设置环境变量

@REM JAVAHOME jdk-20 取值
:: https://download.oracle.com/java/20/latest/jdk-20_windows-x64_bin.msi
setx  JAVA_HOME "C:\Program Files\Java\jdk-20;"

@REM PATH 
setx  PATH "%%JAVA_HOME%%\bin;"

echo "java环境变量配置成功"

@REM :------ 保留项，注释 ---------------------------

@REM %%asd%% 防止转义

@REM CLASSPATH 参考
:: https://blog.csdn.net/weixin_44144786/article/details/119350075
:: setx CLASSPATH ".;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;" 

@REM java 手工配置参考
:: https://github.com/dunwu/linux-tutorial/blob/master/docs/linux/soft/jdk-install.md

@REM  需额外工具 iconv
:: curl http://example.com/script.bat | iconv -f utf-8 -t gbk | cmd.exe /c -
