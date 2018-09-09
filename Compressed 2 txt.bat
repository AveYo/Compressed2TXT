<# : Compressed 2 txt : Efficient file / folder encoder by AveYo - output can be renamed to .bat or .ps1 to decode
@echo off &title %~n0 v4.0 [%1]
if not .%1==. goto :Encode
echo. &echo  No input file or folder to encode! use 'Send to' context menu ...
copy /y "%~f0" "%APPDATA%\Microsoft\Windows\SendTo\Compressed 2 txt.bat" >nul 2>nul &goto :End
:Encode
pushd %~dp1 &set "InputFile=yes" &for /f "tokens=1 delims=r-" %%# in ("%~a1") do if /i ".%%#"==".d" set "InputFile="
if defined InputFile ( set "cabfile=%~dpn1~" ) else set "cabfile=%~dpnx1~"
call :MakeCab "%~f1" &if not exist "%cabfile%" echo  makecab '%~nx1' failed, try again ... &goto :End
for %%# in ("%cabfile%") do if 1%%~z# GTR 220971520 echo  Input '%~nx1' is larger than the 20MB limit! &goto :End
::rem comment above line to remove 20MB file limit
type "%~f0" | powershell.exe -c -
if exist "%cabfile%.bat" del /f /q "%cabfile%"
timeout /t 10
::start "preview" notepad "%cabfile%.bat.txt"
exit/b
:End
echo. &pause &title %comspec% &exit/b
:MakeCab %1:[file or directory]
echo  makecab '%~nx1' ... &echo.
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

:: PowerShell functions below this line #>
function r85encode { param([Byte[]] $bin, [Byte] $split=0)
  $xe = (new-object -COM Microsoft.XMLDOM).createElement("bh")
  $xe.dataType = "bin.hex"
  $xe.nodeTypedValue = [System.BitConverter]::ToString($bin).replace("-", "")
  $r = ([regex]::Matches($xe.text, "(.{1,8})")).value
  $pad = 8 - $r[-1].length
  if($pad){ $r[-1] = $r[-1] + "00000000".Remove(0, 8 - $pad) }
  $r85 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~'
  $d85 = @{}; for($i=85;$i--;){ $d85[$r85[$i]] = $i }
  for($l=$r.length;$l--;){
    $n = [uint64]::Parse($r[$l], "HexNumber")
    $r[$l] = ""
    for($j=5;$j--;){
      $k = 0;
      if($n -gt 0){ $k = [math]::Truncate($n % 85) }
      $r[$l] = $r85[$k] + $r[$l]
      $n /= 85
    }
  }
  if($pad){ $r[-1] = $r[-1].Remove(5 - $pad / 2) }
  if($split){
    $s=([regex]::Matches($r -join '', "(.{1,"+$split+"})")).value
    $s[0] = "::" + $s[0]
    return $s -join "`r`n::"  # signature prefix all lines
  }
  $r[0] = "::" + $r[0] # signature prefix
  return $r -join ""
}
function r85decode { param([string] $str)
  $r = ([regex]::Matches($str, '([^:\s]{1,5})')).value
  $pad = 5 - $r[-1].length
  if($pad){ $r[-1] = $r[-1] + "~~~~~".Remove($pad) }
  $r85 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~'
  $d85 = @{}; for($i=85;$i--;){ $d85[$r85[$i]] = $i }; $p85 = @(1,85,7225,614125,52200625)
  for($l=$r.length;$l--;){
    $n = 0
    for($j=5;$j--;){
      $n += $d85[$r[$l][$j]] * $p85[4 - $j]
    }
    $k = [Convert]::ToString($n, 16)
    $r[$l] = "00000000".Remove(0, $k.length) + $k
  }
  if($pad){ $r[-1] = $r[-1].Remove(8 - $pad * 2) }
  $xe = (new-object -COM Microsoft.XMLDOM).createElement("bh")
  $xe.dataType = "bin.hex"
  $xe.text = $r -join ""
  return $xe.nodeTypedValue
}
echo " "
echo " r85encode input cabfile ..."
$cabfile=([System.IO.FileInfo]$env:cabfile).BaseName
$bin = [System.IO.File]::ReadAllBytes($cabfile);
$content = r85encode $bin 125 # to also limit encode output line length use: r85encode $bin 125
if ($content.length -lt 5){ throw "File2TXTenc failed" }

echo " Generate output file with bundled r85decode ..."
$outfile=$cabfile+'.bat';
$hd = @()
$hd+='<# : Compressed 2 txt : Efficient file / folder encoder by AveYo - can rename to .bat or .ps1 to decode'
$hd+='@powershell -NoProfile -NoLogo -Command "iex (${%~f0} | out-string)" &exit/b'
$hd+='#> $file="'+$cabfile+'"; write-host "`r`n Compressed 2 txt : r85decode $file ..."; $res=@"'
#$content
$ft = @()
$ft+='"@; $r=([regex]::Matches($res,''([^:\s]{1,5})'')).value;$pad=5-$r[-1].length;if($pad){$r[-1]=$r[-1]+"~~~~~".Remove($pad)}'
$ft+='$r85=''0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~'';'
$ft+='$d85=@{}; for($i=85;$i--;){$d85[$r85[$i]]=$i}; $p85=@(1,85,7225,614125,52200625);  for($l=$r.length;$l--;){'
$ft+='$n=0; for($j=5;$j--;){$n += $d85[$r[$l][$j]] * $p85[4 - $j]}; $k=[Convert]::ToString($n,16);'
$ft+='$r[$l]="00000000".Remove(0,$k.length)+$k  };  if($pad){$r[-1]=$r[-1].Remove(8-$pad*2)}'
$ft+=''
$ft+='$xe=(new-object -COM Microsoft.XMLDOM).createElement("bh");  $xe.dataType="bin.hex";  $xe.text=$r -join ""'
$ft+='[IO.File]::WriteAllBytes($file,$xe.nodeTypedValue);  expand -R $file -F:* .;  del $file -force;  timeout /t 10 2>$nul'
[IO.File]::WriteAllLines($outfile,$hd);
[IO.File]::AppendAllLines([string]$outfile,[string[]]$content);
[IO.File]::AppendAllLines([string]$outfile,[string[]]$ft);

echo " Done"
