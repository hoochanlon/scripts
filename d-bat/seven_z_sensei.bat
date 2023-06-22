
@echo off
@REM 启用延迟变量
setlocal EnableDelayedExpansion
@REM 利用python获取时间，屏蔽报错信息
echo\
python -c "import datetime;now=datetime.datetime.now();print('起始时间是：', now)" 2>nul > rar_time_log.txt

@REM 判断是否存在密码本，没有则下载
IF NOT EXIST "C:\Users\%USERNAME%\Downloads\rarpasswd.txt" > nul (curl -o C:\Users\%USERNAME%\Downloads\rarpasswd.txt https://ghproxy.com/https://raw.githubusercontent.com/hoochanlon/scripts/main/d-txt/rarpasswd.txt)

echo/
@REM 设置7z为常用变量
set used7z="%ProgramFiles%"\7-Zip\7z.exe
set "passwd_list=C:\Users\%USERNAME%\Downloads\rarpasswd.txt"
@REM set "has_passwd_rar=C:\Users\nice\Desktop\wifi密码本.rar"
set /p input=请将文件路径复制到终端： 

echo/
echo ---------开始爆破-------------
echo/

rem 遍历密码列表验证
for /f "delims=" %%a in (%passwd_list%) do (
  echo 正在爆破中，密码正在快速校验："%%a"
  "C:\Program Files\7-Zip\7z.exe" t -p"%%a" "%input%" >nul 2>&1
  if !errorlevel! equ 0 (
    echo/
    echo ---------最终结果-------------
    echo/
    type rar_time_log.txt
    python -c "import datetime;other_time=datetime.datetime.now();print('现在时间为：', other_time)" 2>nul
    echo/
    @REM 找到即退出
    echo 正确密码是: "%%a"
    echo/
    exit /b
  )
)

echo\
echo ---------------------------------------------
echo\
type rar_time_log.txt
python -c "import datetime;other_time=datetime.datetime.now();print('现在时间为：', other_time)" 2>nul
echo\
echo 没找到。
echo\























@REM ----------------------- 草稿 -----------------------------------------

@REM  解压，带密码与不带密码，此外解压密码不正确是无法输出正常内容的。
@REM "%ProgramFiles%"\7-Zip\7z x C:\Users\nice\Desktop\问题管理.rar  -o"C:\Users\nice\Desktop\"
@REM "%ProgramFiles%"\7-Zip\7z x C:\Users\nice\Desktop\问题管理.rar  -o"C:\Users\nice\Desktop\" -p1234

@REM 7z只能实现7z、zip之类的打包加密
@REM "%ProgramFiles%"\7-Zip\7z a "C:\Users\nice\Desktop\问题管理.rar" C:\Users\nice\Desktop\问题管理.pdf -p1234
 
@REM 验证压缩包密码
@REM "%ProgramFiles%"\7-Zip\7z t -p1234 C:\Users\nice\Desktop\wifi密码本.rar
 
 
@REM 启用延迟变量
@REM setlocal EnableDelayedExpansion
 
@REM 设置7z为常用变量
@REM set used7z="%ProgramFiles%"\7-Zip\7z.exe
 
@REM 看返回值验证密码对错
@REM "%ProgramFiles%"\7-Zip\7z t -p12345 C:\Users\nice\Desktop\wifi密码本.rar
@REM if %errorlevel% EQU 0 (
@REM     echo 对。
@REM ) else (
@REM     echo 错。
@REM )

@REM 加载密码本
@REM https://github.com/hoochanlon/scripts/raw/main/d-txt/rarpasswd.txt
@REM https://statically.io/convert/
@REM http 会成301状态码，注意是https

