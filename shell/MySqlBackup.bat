@echo off

:: Just update the 2 first
::the adress of the lerver
set server="complexe-larona.togettech.co/remote_server.php"

:: The name of the database we want to dump
set db=syjmmznh_larona



:: the database token for access
set dbUser=root
set dbPassword=""

:: the dir where we will sotre the backup files
set backupDir="C:\Localhost_MySQL_Backup"

:: 
set mysqldump="C:\laragon\bin\mysql\mysql-5.7.33-winx64\bin\mysqldump.exe"
set mysqlDataDir="C:\laragon\data\mysql"
set zip="C:\laragon\bin\7-Zip\7z.exe"


:: The loaction to the curl application stored on windows
set curl="C:\Windows\System32\curl.exe"



:: get date
for /F "tokens=2-4 delims=/ " %%i in ('date /t') do (
	set mm=%%i
	set dd=%%j
	set yy=%%k
)

if %mm%==01 set Month="Jan"
if %mm%==02 set Month="Feb"
if %mm%==03 set Month="Mar"
if %mm%==04 set Month="Apr"
if %mm%==05 set Month="May"
if %mm%==06 set Month="Jun"
if %mm%==07 set Month="Jul"
if %mm%==08 set Month="Aug"
if %mm%==09 set Month="Sep"
if %mm%==10 set Month="Oct"
if %mm%==11 set Month="Nov"
if %mm%==12 set Month="Dec"

set dirName=%dd%_%Month%_%yy%
set fileSuffix=%dd%-%Month%-%yy%

:: remove echo here if you like
echo "dirName"="%dirName%"

:: switch to the "data" folder
pushd "%mysqlDataDir%"

:: create backup folder if it doesn't exist
if not exist %backupDir%\%dirName%\   mkdir %backupDir%\%dirName%

:: iterate over the folder structure in the "data" folder to get the databases


echo Dumping database %db%

%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases %db% > %backupDir%\%dirName%\%db%.sql
%zip% a -tgzip %backupDir%\%dirName%\%fileSuffix%_%db%.sql.gz %backupDir%\%dirName%\%db%.sql

echo Sending the sql dumped database file to the server at %server%


set dbFileName=%backupDir%\%dirName%\%db%.sql


echo %backupDir%\%dirName%\%db%.sql

%curl% %server% -F db_file=@%dbFileName% -F db_name=%db%

popd
