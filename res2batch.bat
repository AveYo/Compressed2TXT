/* 2>nul & TITLE Res2Batch by AveYo v2.0a
@echo off &setlocal &set "app=%APPDATA%\AveYo"
md "%app%" >nul 2>&1 &if exist "%~1" (set "fchoice=%~1") else call :filechoice
cscript.exe //e:javascript //nologo "%~f0" %fchoicejs%
del /f /q "%fpath%\%fname%%cfext%" &popd &echo. &pause &endlocal &exit /b

goto :eof
:filechoice
set "appjs=%app:\=\\%" &set "openpath=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32"
reg copy "%openpath%" "%openpath%_bak" /s /f >nul 2>&1 &reg delete "%openpath%" /f >nul 2>&1
mshta.exe "about:<input type=file style="display:none" id=FILE><script>resizeTo(0,0);FILE.click();var out=new ActiveXObject('Scripting.FileSystemObject').CreateTextFile('%appjs%\\fchoice.bat',true);out.write('@set fchoice='+FILE.value);out.close();close();</script>"
reg copy "%openpath%_bak" "%openpath%" /s /f >nul 2>&1 &reg delete "%openpath%_bak" /f >nul 2>&1
call "%app%\fchoice.bat" &del /f /q "%app%\fchoice.bat"
rem needs compression?
for %%A in ("%fchoice%") do set "fpath=%%~dpA" &set "fname=%%~nA" &set "fext=%%~xA" &set "fsize=%%~zA"
if %fsize% GTR 10485760 echo ERROR! Chosen file is larger than 10MB, what are you trying to do?! &pause &exit
rem comment above line to remove 10MB file limit
set "cfext=%fext:~0,-1%_"
pushd "%fpath%" &makecab.exe "%fchoice%" "%fname%%cfext%" >nul 2>&1
for %%A in ("%fname%%cfext%") do set "cfsize=%%~zA"
if %cfsize% LSS %fsize% set "fchoice="%fpath%\%fname%%cfext%"
set fchoicejs=%fchoice: =_RSPACE_%
goto :eof

:res85_encoder */
//read
arg0=WScript.Arguments(0), fn=arg0.replace(/_RSPACE_/g,' '), name=fn.split('\\').pop().split('/').pop(), exp=fn.slice(-1);
WScript.Echo(' RES2BATCH: encoding '+fn);
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
ws.WriteText('/* 2>nul & TITLE Res2Batch by AveYo v2.0a\n@echo off &pushd %~dp0 &cscript.exe //nologo //e:JScript "%~f0"\n');
if (exp==='_') ws.WriteText('set "res='+name+'"\nexpand -R "%res%" >nul 2>&1 &del /f /q "%res%"\n');
ws.WriteText('pause &exit /b\n:res85_decoder */\nvar fn="'+name+'", res="\\\n');
var o=res85enc.match(/.{1,126}/g);for(i=0,l=o.length;i<l;i++) ws.WriteText("::"+o[i]+"\\\n");
_dec="\".replace(\/[\\\\:\\s]\/gm,\"\"); \
r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');\n\
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);\n\
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(\/.{1,5}\/g);\n\
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};\n\
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');WSH.Echo(' RES2BATCH: extracting '+fn);\n\
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();\n\
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close();\n";
ws.WriteText(_dec);ws.SaveToFile(fn+'.bat',2);ws.Close();





