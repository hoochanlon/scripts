@echo off
setlocal enabledelayedexpansion

rem 设置目标时间
set targetTime=2025-12-26 15:51:00

rem 直接设定当前时间（手动调整）
@REM set currYear=2025
@REM set currMonth=01
@REM set currDay=23
@REM set currHour=23
@REM set currMin=19

rem 获取当前时间（格式：yyyy-MM-dd HH:mm:ss）
for /f "tokens=1-4 delims=/-: " %%a in ("%date%") do (
    set currYear=%%a
    set currMonth=%%b
    set currDay=%%c
)
for /f "tokens=1-2 delims=: " %%a in ("%time%") do (
    set currHour=%%a
    set currMin=%%b
)

rem 获取目标时间的年、月、日、时、分
for /f "tokens=1-5 delims=/-: " %%a in ("%targetTime%") do (
    set targetYear=%%a
    set targetMonth=%%b
    set targetDay=%%c
    set targetHour=%%d
    set targetMin=%%e
)

rem 调试输出当前时间和目标时间
echo Current Time: %currYear%-%currMonth%-%currDay% %currHour%:%currMin%
echo Target Time: %targetYear%-%targetMonth%-%targetDay% %targetHour%:%targetMin%

rem 创建每个月的天数
set month1=31
set month2=28
set month3=31
set month4=30
set month5=31
set month6=30
set month7=31
set month8=31
set month9=30
set month10=31
set month11=30
set month12=31

rem 判断是否是闰年，如果是则2月为29天
set /a leapYearFlag=%targetYear% %% 4
if %leapYearFlag%==0 (
    set /a leapYearFlag=%targetYear% %% 100
    if %leapYearFlag%==0 (
        set /a leapYearFlag=%targetYear% %% 400
        if %leapYearFlag%==0 (
            set month2=29
        )
    ) else (
        set month2=29
    )
)

rem 输出每个月的天数（调试）
echo 输出每个月的天数:
echo 1月: !month1!
echo 2月: !month2!
echo 3月: !month3!
echo 4月: !month4!
echo 5月: !month5!
echo 6月: !month6!
echo 7月: !month7!
echo 8月: !month8!
echo 9月: !month9!
echo 10月: !month10!
echo 11月: !month11!
echo 12月: !month12!

rem 计算当前时间的总秒数
set /a currTotalSecs=(%currYear% - 1) * 365 * 24 * 3600
for /L %%i in (1,1,%currMonth%) do (
    set /a currTotalSecs+=!month%%i! * 24 * 3600
)
set /a currTotalSecs+=(%currDay% - 1) * 24 * 3600
set /a currTotalSecs+=%currHour% * 3600
set /a currTotalSecs+=%currMin% * 60

rem 计算目标时间的总秒数
set /a targetTotalSecs=(%targetYear% - 1) * 365 * 24 * 3600
for /L %%i in (1,1,%targetMonth%) do (
    set /a targetTotalSecs+=!month%%i! * 24 * 3600
)
set /a targetTotalSecs+=(%targetDay% - 1) * 24 * 3600
set /a targetTotalSecs+=%targetHour% * 3600
set /a targetTotalSecs+=%targetMin% * 60

rem 输出当前时间和目标时间的总秒数（调试）
echo Current total seconds: %currTotalSecs%
echo Target total seconds: %targetTotalSecs%

rem 计算时间差（秒）
set /a diffSecs=%targetTotalSecs% - %currTotalSecs%

rem 输出时间差（秒）
echo Time difference in seconds: %diffSecs%

rem 调用shutdown命令延迟指定的秒数
shutdown.exe -s -f -t %diffSecs%
pause