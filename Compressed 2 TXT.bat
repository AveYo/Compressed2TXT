<# :: Compressed2TXT v6.0 - Files/Folders "Send to" menu .bat ascii encoder by AveYo
@echo off& color 07& chcp 65001 >nul
set "0=%~f0" & set 1=%*& powershell -nop -c iex ([io.file]::ReadAllText($env:0)) &pause& exit/b
#>$env:1; if (!$env:1) {write-host "`n No input files or folders to encode! use 'Send to' context menu ...`n" -fore Yellow
  $s="$env:APPDATA\Microsoft\Windows\SendTo";if ($(Split-Path $env:0)-ne $s){copy $env:0 "$s\Compressed 2 TXT.bat" -force} exit}
  $Main = {

# Available script choices $c with prefix number as hotkey to toggle; selected by default $d = 1
  $c  = @()                                       ; $d  = @()
  $c += '&1  Input decoding key as password      '; $d += 0
  $c += '&2  Randomize decoding key (use with 1) '; $d += 0
  $c += '&3  BAT91 encoder instead of BAT85 -1.7%'; $d += 0
  $c += '&4  No long lines (adds more overhead)  '; $d += 1
  $c += '&5  No LZX compression (full size)      '; $d += 0
  $c += '&6  No txt encoding (cab archive only)  '; $d += 0

# Show choices dialog with texts $c and defaults $d selected - outputs indexes like '1,2,4'
  $all = $c -join ','; $def = (($d -split "`n")|Select-String 1).LineNumber -join ','; $selected = @($false) * ($c.length + 1)
  $result = Choices $all $def 'Compressed2txt' 14; if ($result) {$result -split ',' |% {$selected[[int]$_] = $true} }
# Quit if no choice made
  if ($result -eq $null) { write-host -fore Yellow "`n Canceled `n"; exit }

# Process command line arguments
  $arg = ([regex]'"[^"]+"|[^ ]+').Matches($env:1)
  $val = gi -force -lit $arg[0].Value.Trim('"')
  $fn1 = $val.Name
# Setup work and output dirs
  $top = Split-Path $val; sl -lit $top; $rng = [Guid]::NewGuid().Guid; mkdir $rng -force -ea 0|out-null # $drv = (gl).Drive.Root;
  if ($([IO.DirectoryInfo]$rng).Exists) {$dir = $top; $work = "$top\$rng"}
  else {$dir = "$env:USERPROFILE\Desktop"; $work = "$env:TEMP\$rng"; mkdir $work -force -ea 0|out-null}
  pushd -lit $work
# Grab target files
  $files = @()
  foreach ($a in $arg) {
    $f = gi -force -lit $a.Value.Trim('"')
    if ($f.PSTypeNames -match 'FileInfo') {$files += $f}
    else {dir -lit $f -rec -force |? {!$_.PSIsContainer} |% {$files += $_}}
  }

# Improved MakeCab ddf generator to handle localized and special characters file names better
  $ddf1 = @"
.new Cabinet`r`n.Set Cabinet=ON`r`n.Set CabinetFileCountThreshold=0`r`n.Set ChecksumWidth=1`r`n.Set ClusterSize=CDROM
.Set LongSourceFileNames=ON`r`n.Set CompressionType=LZX`r`n.Set CompressionLevel=7`r`n.Set CompressionMemory=21
.Set DiskDirectoryTemplate=`r`n.Set FolderFileCountThreshold=0`r`n.Set FolderSizeThreshold=0`r`n.Set GenerateInf=ON
.Set InfFileName=nul`r`n.Set MaxCabinetSize=0`r`n.Set MaxDiskFileCount=0`r`n.Set MaxDiskSize=0`r`n.Set MaxErrors=0
.Set ReservePerCabinetSize=0`r`n.Set ReservePerDataBlockSize=0`r`n.Set ReservePerFolderSize=0`r`n.Set RptFileName=nul
.Set UniqueFiles=ON`r`n.Set SourceDir=.`r`n
"@
  $ddf2 = $ddf1+"1.cab`r`n"; $cabinet = "$work\1.cab"; [int]$renamed = 100; $sub = $dir.Length + 1; if ($sub -eq 4) {$sub--}
  foreach ($f in $files){
    copy -lit $f.FullName -dest $("$work\$renamed") -force -ea 0|out-null
    $ddf1 += $("$renamed `""+$f.FullName.substring($sub)+"`"`r`n"); $renamed++
  }

# Choice 5: No LZX compression (full size)
  if ($selected[5]) {$comp = 'OFF'} else {$comp = 'ON'}
# With default choices MakeCab is done in two passes
  if (!$selected[5] -and !$selected[6]) {$comp = 'OFF'}
# MakeCab first pass just stores the files without compression
  [IO.File]::WriteAllText("$work\1.ddf", $ddf1, [Text.Encoding]::UTF8)
  makecab.exe /F 1.ddf /D Compress=$comp /D CabinetNameTemplate=1.cab
  write-host
# MakeCab second pass LZX compresses the potentially large tree of filenames as well
  if (!$selected[5] -and !$selected[6]) {
    $cabinet = "$work\1.ca_"
    [IO.File]::WriteAllText("$work\2.ddf", $ddf2, [Text.Encoding]::UTF8)
    makecab.exe /F 2.ddf /D Compress=ON /D CabinetNameTemplate=1.ca_
    write-host
  }
# Choice 6: No text encoding (cab archive only)
  if ($selected[6]) {
    copy -lit $cabinet -dest "$dir\$fn1~.cab" -force -ea 0; popd; cmd /c rmdir /s/q "`"$work`""; exit
  }

# Text encoding - compact self-expanding batch file bundling ascii encoded with BAT91 cab archive of target files
  $HEADER  = "@echo off& color 07& chcp 65001 >nul`r`n"
  $HEADER += 'set "0=%~f0"&powershell -nop -c cd -li(Split-Path $env:0);'
  $HEADER += '$f=[IO.File]::ReadAllText($env:0)-split'':bat2file\:.*'';iex($f[1]); X 1'
  $HEADER += "`r`n@pause& exit/b`r`n`r`n:bat2file: Compressed2TXT v6.0`r`n"

# Choice 4: No long lines (adds more overhead) - each line has 4 extra chars (cr lf ::) and short lines are ~8 times as many
  if ($selected[4]) {$line = 124} else {$line = 1014}

# Choice 3: BAT91 encoder instead of BAT85 for ~1.7% less size, but will use some web-problematic chars <*`%\>
  $key = '.,;{-}[+](/)_|^=?O123456A789BCDEFGHYIeJKLMoN0PQRSTyUWXVZabcdfghijklmnpqrvstuwxz!@#$&~'; $chars = 85
  if ($selected[3]) {
    $key = '.,;{-}[+](/)_|^=?O123456789ABCDeFGHyIdJKLMoN0PQRSTYUWXVZabcfghijklmnpqrstuvwxz!@#$&~E<*`%\>'; $chars = 91
  }

# Choice 2: Randomize decoding key - characters matter, order does not, so it can be randomized and used as decoding password
  if ($selected[2]) {
    $base = [System.Text.Encoding]::ASCII.GetBytes($key); $rnd = new-object Random; $i = 0; $j = 0; $t = 0
    while ($i -lt $chars) {$t = $base[$i]; $j = $rnd.Next($i, $chars); $base[$i] = $base[$j]; $base[$j] = $t; $i++}
    $key = [System.Text.Encoding]::ASCII.GetString($base)
  }

# Choice 1: Input decoding key as password - or bundle it with the file for automatic extraction
  if ($selected[1]) {
    $HEADER += '$b=''Microsoft.VisualBasic'';Add-Type -As $b;$k=iex "[$b.Interaction]::InputBox(''Key'','+$chars+')";'
    $HEADER += 'if($k.Length-ne'+$chars+'){exit} Add-Type -Ty @' + "'`r`n"
  } else {
    $HEADER += '$k='''+$key+"'; Add-Type -Ty @'`r`n"
  }

# Generate text decoding C# snippet depending on Choice 3: BAT91 encoder instead of BAT85
  if ($selected[3]) {
    $HEADER += @'
using System.IO; public class BAT91 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b91=new byte[256]; int n=0,c=255,v=91,q=0,z=f[x].Length; while (c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++;
using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0; i != z; i++) { c=b91[ f[x][i] ]; if (c == 91) continue;
if (v == 91) {v = c;} else {v += c * 91; q |= v << n; if ((v & 8191) > 88) {n += 13;} else {n += 14;} v = 91;
do {o.WriteByte((byte)q); q >>= 8; n -= 8;} while (n>7);} } if (v != 91) o.WriteByte((byte)(q | v << n)); } }}}
'@ + "`r`n'@; " + 'function X([int]$x=1) {[BAT91]::Dec([ref]$f,$x+1,'
  } else {
    $HEADER += @'
using System.IO; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q > p-1) {q--;o.WriteByte((byte)(n>>8*q));} } } }}}
'@ + "`r`n'@; " + 'function X([int]$x=1) {[BAT85]::Dec([ref]$f,$x+1,'
  }

# Generate expand function (must run twice if compressed in two passes)
#  $HEADER += 'function X([int]$x=1) {[BAT91]::Dec([ref]$f,$x+1,'
  if (!$selected[5] -and !$selected[6]) {
    $HEADER += '"1.ca_",$k); @("1.ca_","1.cab") |% {expand -R $_ -F:* .; del $_ -force}}'
  } else {
    $HEADER += '"1.cab",$k); expand -R "1.cab" -F:* .; del "1.cab" -force}'
  }
  $HEADER += "`r`n`r`n:bat2file:[ $fn1`r`n"

# BAT91 or BAT85 ascii encoding of cab file containing target files
  $output = "$dir\$fn1~.bat"
  [IO.File]::WriteAllText($output, $HEADER)
  write-host -fore Green "`r`nBAT91 encoding $fn1~.bat ..."; $timer=new-object Diagnostics.StopWatch; $timer.Start()
  if ($selected[3]) {
    [BAT91]::Enc($cabinet, $output, $key, $line)
  } else {
    [BAT85]::Enc($cabinet, $output, $key, $line)
  }
  $timer.Stop()
  write-host "$($timer.Elapsed.TotalSeconds) seconds`r`n"
  [IO.File]::AppendAllText($output, "`r`n:bat2file:]`r`n")

# Choice 1: Input decoding key as password - saving decoding key externally
  if ($selected[1]) {
    [IO.File]::WriteAllText("$dir\$fn1~key.ini", $key)
    write-host -fore Yellow "decoding key saved separately to $fn1~key.ini"
  } else { del "$dir\$fn1~key.ini" -force -ea 0 }

# Done - cleanup work dir
  popd; cmd /c rmdir /s/q "`"$work`""
}
############
# Snippets #
############

# Text encoding snippet via C# (native powershell is unbearable slow for large files)
  Add-Type -Ty @'
using System.IO;
public class BAT85 {
  public static void Enc(string fi, string fo, string key, int line) {
    byte[] a = File.ReadAllBytes(fi), b85=new byte[85], q = new byte[5]; long n = 0; int p = 0,c = 0,v = 0,l = 0,z = a.Length;
    unchecked {
      while (c<85) {b85[c] = (byte)key[c++];}
      using (FileStream o = new FileStream(fo, FileMode.Append)) {
        o.WriteByte(58); o.WriteByte(58);
        for (int i = 0; i != z; i++) {
          c = a[i];
          if (p == 3) {
            n |= (byte)c; v = 5; while (v > 0) {v--; q[v] = b85[(byte)(n % 85)]; n /= 85;}
            o.Write(q, 0, 5); n = 0; p = 0; l += 5;
            if (l > line) {l = 0; o.WriteByte(13); o.WriteByte(10); o.WriteByte(58); o.WriteByte(58);}
          } else {
            n |= (uint)(c << (24 - (p * 8))); p++;
          }
        }
        if (p > 0) {
          for (int i=p;i<3-p;i++) {n |= (uint)(0 << (24 - (p * 8)));}
          n |= 0; v = 5; while (v > 0) {v--; q[v] = b85[(byte)(n % 85)]; n /= 85;} o.Write(q, 0, p + 1);
        }
      }
    }
  }
}
public class BAT91 {
  public static void Enc(string fi, string fo, string key, int line) {
    byte[] a = File.ReadAllBytes(fi), b91 = new byte[91]; int n = 0, c = 0, v = 0, q = 0, l = 0, z = a.Length;
    while (c<91) {b91[c] = (byte)key[c++];}
    using (FileStream o = new FileStream(fo, FileMode.Append)) {
      o.WriteByte(58); o.WriteByte(58);
      for (int i = 0; i != z; i++) {
        q |= (a[i] & 255) << n; n += 8;
        if (n > 13) {
          v = q & 8191; if (v > 88) {q >>= 13; n -= 13;} else {v = q & 16383; q >>= 14; n -= 14;}
          o.WriteByte(b91[v % 91]); o.WriteByte(b91[v / 91]);
          l += 2; if (l > line) {l = 0; o.WriteByte(13); o.WriteByte(10); o.WriteByte(58); o.WriteByte(58);}
        }
      }
      if (n > 0) {o.WriteByte(b91[q % 91]); if (n > 7 || q > 90) {o.WriteByte(b91[q / 91]);}}
    }
  }
}
'@

# Choices dialog snippet - parameters: 1=allchoices, 2=default; [optional] 3=title, 4=textsize, 5=backcolor, 6=textcolor
  function Choices($all, $def, $n='Choices', [byte]$sz=12, $bc='MidnightBlue', $fc='Snow', $saved='HKCU:\Environment'){
[void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $f=new-object Windows.Forms.Form
$a=$all.split(','); $s=$def.split(','); $reg=gp $saved -ea 0; if($reg){ $s=$reg.$n.split(',') };
function rst(){ $cb | %{ $_.Checked=0; if($s -contains $_.Name){ $_.Checked=1 } } }; $f.Add_Shown({rst; $f.Activate()})
$cb=@(); $i=1; $a | %{ $c=new-object Windows.Forms.CheckBox; $cb+=$c; $c.Text=$_; $c.AutoSize=1;
$c.Margin='8,4,8,4'; $c.Location='64,'+($sz*3*$i-$sz); $c.Font='Tahoma,'+$sz; $c.Name=$i; $f.Controls.Add($c); $i++}
$bt=@(); $j=1; @('OK','Reset','Cancel') | %{ $b=new-object Windows.Forms.Button; $bt+=$b; $b.Text=$_; $b.AutoSize=1;
$b.Margin='0,0,72,20'; $b.Location=''+(64*$j)+','+(($sz+1)*3*$i-$sz); $b.Font='Tahoma,'+$sz; $f.Controls.Add($b); $j+=2 }
$v=@(); $f.AcceptButton=$bt[0]; $f.CancelButton=$bt[2]; $bt[0].DialogResult=1; $bt[1].add_Click({$s=$def.split(',');rst});
$f.Text=$n; $f.BackColor=$bc; $f.ForeColor=$fc; $f.StartPosition=4; $f.AutoSize=1; $f.AutoSizeMode=0; $f.FormBorderStyle=3;
$f.MaximizeBox=0; $r=$f.ShowDialog(); if($r -eq 1){$cb | %{if($_.Checked){$v+=$_.Name}}; $val=$v -join ','
if($r -eq 0){return $null} $null=New-ItemProperty -Path $saved -Name $n -Value $val -Force; return $val } }
# Let's Make Console Scripts Friendlier Initiative by AveYo - MIT License -          Choices '&one, two, th&ree' '2,3' 'Usage'

& $Main
#-.-#
