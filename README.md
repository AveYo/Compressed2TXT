# Compressed 2 TXT (formerly File2Batch / res2batch)  
Efficient file or folder to `.bat` or `.ps1` converter via makecab compression and optimized r85 ascii encoder  

## Typical usage  
Used mostly for sharing configs / scripts / dumps / captures as plain-text on message boards that lack proper file attachments, or to safekeep, run multiple tests and sharing binaries in malware analysis tasks  

## Uninstall  
`Compressed 2 TXT.bat` adds itself to the Send To right-click menu for convenience in usage. To remove, just run:  
```bat
cmd.exe /c del /f/q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\Compressed 2 TXT.bat"  
```
## r85 encoder details  
Tweaked version of [Ascii85](https://en.wikipedia.org/wiki/Ascii85) that works well with batch syntax highlighter used by pastebin and others  

```
Dictionary:
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~
```
```bat
Encoded example:
::O/bZg00000UnT|s00000EC2ui000000|5a51][s6G/aU]tpNZ4B?+2zc?n-a00000001aWshJ=ETy&[5Y/#/wbY+?}TuezrMNUISE^HHj03aCx0C[la0000eO^7+)
::09;r&Z+|g1Q,?ovZCqq/bYUPeAYx]7VO*cnZDm|yX?MG1X?K-)TykY|Z,^8GWn,t_aA|C1axP^fWdHz*1pt{D0ssI2,G#tyAOKu-Z,OdKTvK#qVQpMfZ,^8GWkzXi
::ZEay|WpZ3-VQpnxVrgz(W[)6@b9r.gWo=*_bYy97E[W*M008O*0GXi)0002jOt(Xl09;r&Z+|g1Q,?ovZCq1tb#h~6MrmwqZDDI=a&IL)ZDm|yX?MF}X=QRSE[W*M
::005K)0GW#m0002jOt(Xl09;r&Z+|g1Q,?ovZCq1tb#h~6MrmwqZDDI=a&IL)ZDm|yX?MG0aBD7Qcx3;pOalO!9}fTk0M|]n3m]bobZ?8Lb6it)WnpbxQ,U,0V_WBZ
::Y/A2}Yh_j=XJKt-Tw.Z(Ty}GGWNc|.E[W*M04(z[/Q)GafLnlojS~={PyhfTQvf6Y0AB#B_=_D?xfNOE8zl(N2qg/T4twaJmne+VAVDTz6K+7h;w-;N*(W&cJA3fG
Total characters per line: 127
Data  characters per line: 125
Prefix: ::
Decoded result is binary and needs to be further expanded since it's cab LZX-compressed ( expand -R $file -F:* . )
```
PowerShell encode function (optional second parameter to split lines after x characters):
```ps1
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
```

PowerShell decode function (bundled by generating script slightly uglified):
```ps1
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
```
