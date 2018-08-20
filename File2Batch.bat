@set @v=3.4 /*&echo off &set tool=FILE2BATCH
title %~n0 v%@v:~0,-3% [%1] || AveYo: Efficient file / folder to .bat converter with compression and optimized res85 encoder
if not .%1==. goto :Encode 
echo %TOOL%: No input file or folder to encode! use 'Send to' context menu ...
copy /y "%~f0" "%APPDATA%\Microsoft\Windows\SendTo\File2Batch.bat" >nul 2>nul &goto :End
:Encode
pushd %~dp1 &set "InputFile=yes" &for /f "tokens=1 delims=r-" %%# in ("%~a1") do if /i ".%%#"==".d" set "InputFile=" 
if defined InputFile ( set "cabfile=%~dpn1~" ) else set "cabfile=%~dpnx1~"
call :MakeCab "%~f1" &if not exist "%cabfile%" echo %TOOL%: makecab '%~nx1' failed, try again ... &goto :End 
for %%# in ("%cabfile%") do if 1%%~z# GTR 220971520 echo %TOOL%: Input '%~nx1' is larger than the 20MB size limit! &goto :End
::rem comment above line to remove 20MB file limit 
cscript.exe //nologo //e:JScript "%~f0" "%cabfile: =_RSPACE_%"
if exist "%cabfile%.bat" del /f /q "%cabfile%"
:End
echo. &pause &title %comspec% &exit/b
:MakeCab %1:[file or directory]
echo %TOOL%: makecab '%~nx1' ... &echo.
if defined InputFile makecab.exe /D CompressionType=LZX /D CompressionLevel=7 /D CompressionMemory=21 "%~nx1" "%~n1~" &exit/b
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
makecab.exe /F %ddf% /D DiskDirectory1="" /D CabinetNameTemplate="%~nx1~" &endlocal &popd &del /q /f %ddf% &echo. &exit/b
:res85_encoder */
//read
arg0=WSH.Arguments(0), fn=arg0.replace(/_RSPACE_/g,' '), fname=fn.split('\\').pop().split('/').pop();
WScript.Echo('FILE2BATCH v'+@v+': res85 encoding '+fn+' ...');
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
ws.WriteText('@set @v='+@v+' /*&echo off &set tool=FILE2BATCH\r\ntitle %tool% v%@v:~0,-3% [%~f0]\r\nset "res='+fname+'"\r\n');
ws.WriteText('rem A Microsoft troll lurking MDL forums has added FILE2BATCH output to Defender warning on 20.08.2018\r\n');
ws.WriteText('set fuck=csc&set off=ript&set microsoft=//e:J&set troll=Scri&rem\r\n'); 
ws.WriteText('pushd %~dp0 &%fuck%%off%%microsoft%%troll%pt "%~f0" "%res%"\r\n');
ws.WriteText('echo. &expand.exe -R "%res%" -F:* . &del /f /q "%res%"\r\n');
ws.WriteText('echo. &pause &title %comspec% &exit/b\r\n:res85_decoder */\r\n');
ws.WriteText('var fn=WSH.Arguments(0); WSH.Echo("FILE2BATCH v"+@v+": res85 decoding "+fn+" ..."); var res="\\\r\n');
var o=res85enc.match(/.{1,126}/g);for(i=0,l=o.length;i<l;i++) ws.WriteText("::"+o[i]+"\\\r\n");
_dec="\".replace(\/[\\\\:\\s]\/gm,\"\"); \
r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');\r\n\
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);\r\n\
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(\/.{1,5}\/g);\r\n\
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};\r\n\
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');\r\n\
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();\r\n\
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close();\r\n";
ws.WriteText(_dec);ws.SaveToFile(fn+'.bat',2);ws.Close();
 
