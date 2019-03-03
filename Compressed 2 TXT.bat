@echo off & set "nr=" & set "id=" & title Compressed2TXT v5.0 &rem File(s)/Folder(s) "Send to" .bat ascii encoder by AveYo
set/a USE_LINES=1
set/a USE_PREFIX=0
if not %1.==. goto :CompressAll
color 0e & echo. & echo  No input file^(s^) or folder^(s^) to encode! use 'Send to' context menu ...
copy /y "%~f0" "%APPDATA%\Microsoft\Windows\SendTo\Compressed 2 TXT.bat" >nul 2>nul & goto :End
:CompressAll
set "USE_LINES=%USE_LINES:1=$true%" & set "USE_LINES=%USE_LINES:0=$false%"
set "USE_PREFIX=%USE_PREFIX:1=$true%" & set "USE_PREFIX=%USE_PREFIX:0=$false%"
set/a nr=0 & set/a count=0 & for %%# in (%*) do set/a count+=1
for %%# in (%*) do set/a nr+=1 & call :CompressOne "%%~#"
goto :End
:CompressOne
pushd %~dp1 & set "IsFile=yes" & for /f "tokens=1 delims=r-" %%# in ("%~a1") do if /i ".%%#"==".d" set "IsFile="
if defined IsFile ( set "cabfile=%~n1~" ) else set "cabfile=%~nx1~"
call :MakeCab "%~f1" & if not exist "%cabfile%" echo MAKECAB '%~nx1' failed, try again ... &goto :End
if not defined id call set "id=%~n1~"
if not defined count set/a nr=1 & set/a count=1
set "PSARGS=$nr=%nr%;$count=%count%;$id='%id%';$fn='%cabfile%'; $uselines=%USE_LINES%; $useprefix=%USE_PREFIX%;"
powershell -noprofile -c "$f=[io.file]::ReadAllText('%~f0') -split ':CompressPS\:.*'; %PSARGS%; iex ($f[1]);"
del /f /q "%cabfile%" & exit/b
:End
echo. & pause & color 07 & title %comspec% & exit/b
:MakeCab [file or directory]
echo MAKECAB '%~nx1' ... &echo.
if defined IsFile makecab.exe /D CompressionType=LZX /D CompressionLevel=7 /D CompressionMemory=21 "%~nx1" "%~n1~" &exit/b
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

:CompressPS: powershell / C# 2.0 functions
Add-Type -Language CSharp -TypeDefinition @"
using System.IO; using System.Text;
public class BAT85 {
  private static string a85="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~";
  private static byte[] b85=new byte[85]; private static long n=0; private static int[] p85={52200625,614125,7225,85,1};
  private static byte[] n4b(){ return new byte[4]{(byte)(n>>24),(byte)(n>>16),(byte)(n>>8),(byte)n}; }
  private static byte[] n5b(){ byte[] k;k=new byte[5]; for(int j=0;j<5;j++){ k[4-j]=b85[(byte)(n % 85)]; n /= 85; } return k;}
  public static void Encode(string filename, string batname, bool bLines, bool bPrefix) {
    int l=0; int p=0; MemoryStream ms=new MemoryStream(); n = 0; for(byte i=0;i<85;i++){b85[i]=(byte)a85[i];}
    byte[] SOL=new byte[2]{0x3A,0x3A}; byte[] EOL=new byte[1]{0xA};
		foreach (byte b in File.ReadAllBytes(filename)){
      if (bLines) { if (bPrefix && l == 1) {ms.Write(SOL, 0, 2);} if (l == 101) {ms.Write(EOL, 0, 1); l = 0; } l++; }
			if (p == 3) { n |= b; ms.Write(n5b(), 0, 5); n = 0; p = 0; } else { n |= (uint)(b << (24 - (p * 8))); p++; }
      if (bLines && n == 0 && l > 99) {ms.Write(EOL, 0, 1); l = 0;}
		} // done byte array loop, pad bytes and save:
    if(p>0){ for(int i=p;i<3-p;i++){ n |= (uint)(0 << (24 - (p * 8))); } n |= 0; ms.Write(n5b(), 0, p + 1); }
    byte[] marker = Encoding.UTF8.GetBytes("\r\n:" + "bat2file" + ": " + filename + "\r\n");
    using (FileStream fs = new FileStream(batname, FileMode.Append)){
     fs.Write(marker, 0, marker.Length); fs.Write(ms.ToArray(), 0, (int)ms.Length); ms.SetLength(0);
    }
  }
  public static void Decode(string fname, string s) {
    MemoryStream ms=new MemoryStream(); n=0; for(byte i=0;i<85;i++){ b85[(byte)a85[i]]=i; }
    bool k=false; int p=0;
    foreach(char c in s){
      switch(c){case'\0':case'\n':case'\r':case'\b':case'\t':case'\xA0':case' ':case':': k=false;break; default: k=true;break;}
      if(k){ n+= b85[ (byte)c ] * p85[ p++ ]; if(p == 5){ms.Write(n4b(), 0, 4); n=0; p=0; } }
    } // done char loop, pad bytes and save:
    if(p>0){ for(int i=0;i<5-p;i++){ n += 84 * p85[ p+i ]; } ms.Write(n4b(), 0, p-1); }
    File.WriteAllBytes(fname, ms.ToArray()); ms.SetLength(0);
  }
}
"@;

$EXPANDER = @'
@echo off & pushd %~dp0
powershell -noprofile -c "$f=[io.file]::ReadAllText('%~f0') -split ':bat2file\:.*';iex ($f[1]);
'@;
if ($count -gt 0){ for ($i=1;$i -le $count;$i++) { $EXPANDER+="X $i;" } }
$EXPANDER += "`"`r`nexit/b`r`n`r`n"
$EXPANDER += @'
:bat2file: Compressed2TXT v5
Add-Type -Language CSharp -TypeDefinition @"
 using System.IO; public class BAT85{ public static void Decode(string tmp, string s) { MemoryStream ms=new MemoryStream(); n=0;
 byte[] b85=new byte[255]; string a85="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~";
 int[] p85={52200625,614125,7225,85,1}; for(byte i=0;i<85;i++){b85[(byte)a85[i]]=i;} bool k=false;int p=0; foreach(char c in s){
 switch(c){ case'\0':case'\n':case'\r':case'\b':case'\t':case'\xA0':case' ':case':': k=false;break; default: k=true;break; }
 if(k){ n+= b85[(byte)c] * p85[p++]; if(p == 5){ ms.Write(n4b(), 0, 4); n=0; p=0; } } }         if(p>0){ for(int i=0;i<5-p;i++){
 n += 84 * p85[p+i]; } ms.Write(n4b(), 0, p-1); } File.WriteAllBytes(tmp, ms.ToArray()); ms.SetLength(0); }
 private static byte[] n4b(){ return new byte[4]{(byte)(n>>24),(byte)(n>>16),(byte)(n>>8),(byte)n}; } private static long n=0; }
"@; function X([int]$r=1){ $tmp="$r._"; echo "`n$r.."; [BAT85]::Decode($tmp, $f[$r+1]); expand -R $tmp -F:* .; del $tmp -force }
'@;

if ($nr -eq 1){[System.IO.File]::WriteAllLines($id+'.bat', $EXPANDER)}
echo " "
echo "BAT85 encoding $fn ..."
[BAT85]::Encode($fn, $id+'.bat', $uselines, $useprefix);
echo "DONE!"
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
:CompressPS: end
