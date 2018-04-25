@set @v=3 /* AveYo: Efficient file or folder to .bat converter via makecab compression and optimized res85 ascii encoder 
@echo off &title File2Bach [%1] &if not ".%1"=="." setlocal &goto :Encode
echo.&echo FILE2BACH: No input file or folder to encode! use 'Send to' context menu ...
copy /y "%~f0" "%APPDATA%\Microsoft\Windows\SendTo\File2Bach.bat" >nul 2>nul &goto :End
:Encode
call :MakeCab "%~f1" &if not exist "%~dpn1.cab" echo.&echo FILE2BACH: makecab %~nx1 failed, try again ... &goto :End 
for %%# in ("%~dpn1.cab") do set "fsize=%%~z#" &set "finput=%%~dpn#"
if 1%fsize% GTR 110485760 echo.&echo FILE2BACH: Input %fname% is larger than 10MB, what are you trying to do?! &goto :End
::rem comment above line to remove 10MB file limit 
cscript.exe //nologo //e:JScript "%~f0" "%finput: =_RSPACE_%.cab"
if exist "%finput%.cab.bat" del /f /q "%finput%.cab" >nul 2>nul &echo.&echo DONE!
:End
ping -n 6 localhost >nul &title %comspec% &endlocal &exit/b
:MakeCab %1:[file or directory]
pushd %~dp1 &set "InputFile=yes" &for /f "tokens=1 delims=r-" %%# in ("%~a1") do if /i ".%%#"==".d" set "InputFile=" 
if defined InputFile makecab.exe /D CompressionType=LZX /D CompressionLevel=7 /D CompressionMemory=21 "%~nx1" "%~n1.cab" &exit/b
::dir /a:-D/b/s "%~1"
set ddf="%temp%\ddf"
 >%ddf% echo/.New Cabinet
>>%ddf% echo/.set Cabinet=ON
>>%ddf% echo/.set CabinetFileCountThreshold=0
>>%ddf% echo/.set Compress=ON
>>%ddf% echo/.set CompressionType=LZX
>>%ddf% echo/.set CompressionLevel=7
>>%ddf% echo/.set CompressionMemory=21
>>%ddf% echo/.set FolderFileCountThreshold=0
>>%ddf% echo/.set FolderSizeThreshold=0
>>%ddf% echo/.set GenerateInf=OFF
>>%ddf% echo/.set InfFileName=nul
>>%ddf% echo/.set MaxCabinetSize=0
>>%ddf% echo/.set MaxDiskFileCount=0
>>%ddf% echo/.set MaxDiskSize=0
>>%ddf% echo/.set MaxErrors=1
>>%ddf% echo/.set RptFileName=nul
>>%ddf% echo/.set UniqueFiles=ON
setlocal enabledelayedexpansion
pushd "%~dp1"
for /f "tokens=* delims=" %%# in ('dir /a:-D/b/s "%~1"') do (
 set "DDir=%%~dp#" &set "DDir=!DDir:%~1=!" &set "DDir=\%~nx1!DDir:~0,-1!"
 set "ChangeDDir=1" &if !DDir!==!LastDir! set "ChangeDDir=" 
 if defined ChangeDDir echo/.Set DestinationDir=!DDir!;>>%ddf%
 echo/"%%~f#"  /inf=no;>>%ddf%
 set "LastDir=!DDir!"
)
makecab.exe /F %ddf% /D DiskDirectory1="" /D CabinetNameTemplate=%~nx1.cab &endlocal &popd &del /q /f %ddf% &echo. &exit/b
:res85_encoder */
//read
arg0=WScript.Arguments(0), fn=arg0.replace(/_RSPACE_/g,' '), name=fn.split('\\').pop().split('/').pop(), exp=fn.slice(-1);
WScript.Echo('FILE2BACH: encoding '+fn+' ...');
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');rs=ws=WSH.CreateObject('ADODB.Stream');
rs.Mode=3;rs.Type=1;rs.Open();rs.LoadFromFile(fn);len=rs.Size;xe.dataType='bin.hex';xe.nodeTypedValue = rs.Read();rs.Close();
//encode
var r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');
var d85={};for(var i=85;i--;)d85[r85[i]]=i;var p85=[];for(var i=5;i--;)p85[i]=Math.pow(85,i);
var shex=xe.text;var pad=(shex.length%8)||8;shex+='00000000'.slice(pad);pad=4-pad/2;var a=shex.match(/.{1,8}/g);
for(var l=a.length;l--;){var n=parseInt(a[l],16);a[l]='';for(j=5;j--;){a[l]=r85[(n<1)?0:parseInt(n%85,10)]+a[l];n/=85}};
var res85enc = pad>0? a.join('').slice(0,-pad):a.join('');
//generate res85_decoder
ws.Mode=3;ws.Type=2;ws.Charset='Windows-1252';ws.Open();
ws.WriteText('@set @v=3 /* Attach2Text\n@echo off &set "res='+name+'"\n');
ws.WriteText('pushd %~dp0 &cscript.exe //nologo //e:JScript "%~f0" "%res%"\n');
ws.WriteText('expand.exe -R "%res%" -F:* . >nul 2>nul &del /f /q "%res%" &exit/b\n');
ws.WriteText(':res85_decoder */\nvar fn=WSH.Arguments(0); WSH.Echo("FILE2BACH: decoding "+fn+" ..."); var res="\\\n');
var o=res85enc.match(/.{1,126}/g);for(i=0,l=o.length;i<l;i++) ws.WriteText("::"+o[i]+"\\\n");
_dec="\".replace(\/[\\\\:\\s]\/gm,\"\"); \
r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');\n\
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);\n\
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(\/.{1,5}\/g);\n\
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};\n\
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');\n\
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();\n\
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close();\n";
ws.WriteText(_dec);ws.SaveToFile(fn+'.bat',2);ws.Close();
 
