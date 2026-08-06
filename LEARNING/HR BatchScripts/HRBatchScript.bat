
cls

cd..
cd..

set /A day=%date:~7,2%
set /A month=%date:~4,2%
set /A year=%date:~10,4%


set /A month=1
set /A year=%date:~10,4%


if  %month%==1 (
set /A month=12
set /A year=%year% -1

) else (

set /A month=%month% -1 
echo %^/n%
set /A year=%year%
)



if %month%==1 set monthname=Jan
if %month%==2 set monthname=Feb
if %month%==3 set monthname=Mar
if %month%==4 set monthname=Apr
if %month%==5 set monthname=May
if %month%==6 set monthname=Jun
if %month%==7 set monthname=Jul
if %month%==8 set monthname=Aug
if %month%==9 set monthname=Sep
if %month%==10 set monthname=Oct
if %month%==11 set monthname=Nov
if %month%==12 set monthname=Dec



if "%day%"=="1" (
set v1= ELGI_MIS_%monthname%_%%.TXT   
REN "G:\LN\Source_FILES\HR\HR.TXT" %v1%  
)

DEL /F "G:\LN\Source_FILES\HR\HR.TXT"

copy  \\hcm-prod\intranet_elgi\ELGI_MIS.* G:\LN\Source_FILES\HR\HR.TXT