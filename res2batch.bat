@if (@X)==(@Y) @end /* Res2Batch Encoder by AveYo ver 1.0
@echo off &setlocal &set "app=%APPDATA%\AveYo"
md "%app%" >nul 2>&1 &if exist "%~1" (set "fchoice=%~1") else call :filechoice 
cscript.exe //e:javascript //nologo "%~f0" %fchoicejs%
del /f /q "%fpath%\%fname%%cfext%" &popd &pause &endlocal &exit /b

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
rem commend above line to remove 10MB file limit
set "cfext=%fext:~0,-1%_"
pushd "%fpath%" &makecab.exe "%fchoice%" "%fname%%cfext%" >nul 2>&1
for %%A in ("%fname%%cfext%") do set "cfsize=%%~zA"
if %cfsize% LSS %fsize% set "fchoice="%fpath%\%fname%%cfext%" 
set fchoicejs=%fchoice: =_RSPACE_%
goto :eof
:xbase85_batjs_encoder */
//read
var arg0=WScript.Arguments(0);var fn=arg0.replace(/_RSPACE_/g,' '),name=fn.split('\\').pop().split('/').pop(),exp=fn.slice(-1);
var W=WScript,O='CreateObject',AS='ADODB.Stream',rs=ws=W[O](AS),xe=W[O]('Microsoft.XMLDOM').createElement('bh');
rs.Mode=3;rs.Type=1;rs.Open();rs.LoadFromFile(fn);len=rs.Size;xe.dataType='bin.hex';xe.nodeTypedValue = rs.Read();rs.Close();
//encode
WScript.Echo('Res2Batch Encoder by AveYo: encoding '+fn);
var x85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$()*+,-./:;=?@[]_`{}~'.split('');
var d85={};for(var i=85;i--;)d85[x85[i]]=i;var p85=[];for(var i=5;i--;)p85[i]=Math.pow(85,i);
var shex=xe.text;var pad=(shex.length%8)||8;shex+='00000000'.slice(pad);pad=4-pad/2;var a=shex.match(/.{1,8}/g);
for(var l=a.length;l--;){var n=parseInt(a[l],16);a[l]='';for(j=5;j--;){a[l]=x85[parseInt(n%85,10)]+a[l];n/=85}}
var xbase85enc = pad>0? a.join('').slice(0,-pad):a.join('');
//sfx generator
ws.Mode=3;ws.Type=2;ws.Charset='Windows-1252';ws.Open();
ws.WriteText('@if (@X)==(@Y) @end /* made with Res2Batch Encoder by AveYo ver 1.0\n@echo off &setlocal &pushd %~dp0\n');
ws.WriteText('cscript.exe //e:javascript //nologo "%~f0"\n');
if (exp==='_') ws.WriteText('set "res='+name+'"\nexpand -R "%res%" >nul 2>&1 &del /f /q "%res%"\n'); 
ws.WriteText('pause &endlocal &exit /b\n:xbase85_batjs_decoder */\nvar fn="'+name+'", res=[\n');
var o=xbase85enc.match(/.{1,126}/g);for(i=0,l=o.length-1;i<l;i++) ws.WriteText("'"+o[i]+"',\n");ws.WriteText("'"+o[o.length-1]+"'];\n");
ws.WriteText("var x85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$()*+,-./:;=?@[]_`{}~'.split('');\n");
ws.WriteText("var d85={};for(var i=85;i--;)d85[x85[i]]=i;var p85=[];for(var i=5;i--;)p85[i]=Math.pow(85,i);dec=res.join('');\n");
ws.WriteText("var pad=(dec.length%5)||5;dec+='~~~~~'.slice(pad);pad=10-2*pad;var a=dec.match(/.{1,5}/g);for(var l=a.length;l--;){var n=0;\n");
ws.WriteText("for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]='00000000'.slice(n.toString(16).length)+n.toString(16)};\n");
ws.WriteText("var xbase85dec= pad>0? a.join('').slice(0,-pad):a.join('');WScript.Echo('Res2Batch Encoder by AveYo: extracting '+fn);\n");
ws.WriteText("var W=WScript,O='CreateObject',AS='ADODB.Stream',ws=W[O](AS),xe=W[O]('Microsoft.XMLDOM').createElement('bh');\n");
ws.WriteText("ws.Mode=3;ws.Type=1;ws.Open();xe.dataType='bin.hex';xe.text=xbase85dec;ws.Write(xe.nodeTypedValue);ws.SaveToFile(fn,2);ws.Close();\n");
ws.SaveToFile(fn+'.bat',2);ws.Close();
