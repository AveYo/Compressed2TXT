@(echo off% <#%) &color 07 &title Compressed2TXT v6.1 - Files/Folders "Send to" menu .bat ascii encoder by AveYo
chcp 65001 >nul &set "0=%~f0" &set 1=%*& powershell -nop -c iex ([io.file]::ReadAllText($env:0)) &pause &exit/b ||#>)[1]

$env:1; if (!$env:1) {write-host "`n No input files or folders to encode! use 'Send to' context menu ...`n" -fore Yellow}
$SendTo = Join-Path $([Environment]::GetFolderPath("ApplicationData")) -Child 'Microsoft\Windows\SendTo'
if (!$env:1) {if ($(Split-Path $env:0) -ne $SendTo){copy $env:0 "$SendTo\Compressed 2 TXT.bat" -force} exit}

$Main = {
# Choice text - &x is optional hotkey toggle      # Choice value       # Default:1
  $c  = @()                                       ; $v  = @()          ; $d  = @()
  $c += '&1  Input decoding key as password      '; $v += 'password'   ; $d += 0
  $c += '&2  Randomize decoding key (use with 1) '; $v += 'random'     ; $d += 0
  $c += '&3  BAT91 encoder instead of BAT85 -1.7%'; $v += 'bat91'      ; $d += 0
  $c += '&4  No long lines (adds more overhead)  '; $v += 'nolonglines'; $d += 0
  $c += '&5  No LZX compression (for dense files)'; $v += 'nocompress' ; $d += 0
  $c += '&6  No txt encoding (cab archive only)  '; $v += 'cabonly'    ; $d += 0

# Show Choices dialog snippet - outputs $result with indexes like '1,2,4'
  $all=$c -join ',';$def=(($d -split "`n")|Select-String 1).LineNumber -join ',';$choices=@();$selected=@($false)*($c.length+1)
  $result = Choices $all $def 'Compressed2TXT' 14
# Test individual choices presence via ($choices -eq 'value') or ($selected[number])
  if ($result) {$result -split ',' |% {$selected[$_-0] = $true; $choices += $v[$_-1]}}
# Quit if canceled
  if ($result -eq $null) {write-host "`n Canceled `n" -fore Yellow; exit} else {write-host "$($choices -join ',')`n"}

# Choice 3: BAT91 encoder instead of BAT85 for ~1.7% less size, but will use some web-problematic chars <*`%\>
  $key = '.,;{-}[+](/)_|^=?O123456A789BCDEFGHYIeJKLMoN0PQRSTyUWXVZabcdfghijklmnpqrvstuwxz!@#$&~'; $chars = 85
  if ($choices -eq 'bat91') {
    $key = '.,;{-}[+](/)_|^=?O123456789ABCDeFGHyIdJKLMoN0PQRSTYUWXVZabcfghijklmnpqrstuvwxz!@#$&~E<*`%\>'; $chars = 91
  }
  $dict = ($key.ToCharArray()|sort -unique) -join ''; $randomized = 'default'

# Choice 2: Randomize decoding key - characters matter, order does not, so it can be randomized and used as decoding password
  if ($choices -eq 'random' -and $choices -notcontains 'cabonly') {
    $base = $key.ToCharArray(); $rnd = new-object Random; $i = 0; $j = 0; $t = 0
    while ($i -lt $chars) {$t = $base[$i]; $j = $rnd.Next($i, $chars); $base[$i] = $base[$j]; $base[$j] = $t; $i++}
    $key = $base -join ''; $randomized = 'randomized'
  }

# Choice 1: Show InputBox to accept or change the decoding key, and verify it matches the BAT91 or BAT85 $dict
  if ($choices -eq 'password' -and $choices -notcontains 'cabonly') {
    Add-Type -As 'Microsoft.VisualBasic'
    $key = [Microsoft.VisualBasic.Interaction]::InputBox("Press enter to accept $randomized key:", 'BAT'+$chars, $key)
    if (!$key -or $key.Trim().Length -ne $chars -or (($key.Trim().ToCharArray()|sort -unique) -join '') -ne $dict) {
      write-host "`nERROR! Key must be $chars chars long with only non-repeating, shuffled:" -fore Yellow; echo "$dict`n"
      exit
    }
  }

# Start measuring total processing time
  $timer=new-object Diagnostics.StopWatch; $timer.Start()
# Process command line arguments - supports multiple files and folders
  $arg = ([regex]'"[^"]+"|[^ ]+').Matches($env:1)
  $val = Get-Item -force -lit $arg[0].Value.Trim('"')
  $fn1 = $val.Name.replace('.','_')
# Setup work and output dirs - if source not writable fallback to user Desktop
  $top = Split-Path $val; $dir = $top; $rng = [Guid]::NewGuid().Guid; $work = Join-Path $dir -Child $rng; $write = $work+'~'
  mkdir $work -force -ea 0|out-null; New-Item $write -item File -force -ea 0|out-null
  if (!(Test-Path -lit $work) -or !(Test-Path -lit $write)) {
    rmdir -lit $work -force -ea 0|out-null
    $dir = [Environment]::GetFolderPath("Desktop")
    $work = Join-Path $dir -Child $rng; mkdir $work -force -ea 0|out-null
  }
  del -lit $write -force -ea 0|out-null
# Grab target files names
  $files = @()
  foreach ($a in $arg) {
    $f = gi -force -lit $a.Value.Trim('"')
    if ($f.PSTypeNames -match 'FileInfo') {$files += $f} else {dir -lit $f -rec -force |? {!$_.PSIsContainer} |% {$files += $_}}
  }
# Jump to work dir
  sl -lit $work

# Improved MakeCab ddf generator to handle localized and special characters file names better
  $ddf1 = @"
.new Cabinet`r`n.Set Cabinet=ON`r`n.Set CabinetFileCountThreshold=0`r`n.Set ChecksumWidth=1`r`n.Set ClusterSize=CDROM
.Set LongSourceFileNames=ON`r`n.Set CompressionType=LZX`r`n.Set CompressionLevel=7`r`n.Set CompressionMemory=21
.Set DiskDirectoryTemplate=`r`n.Set FolderFileCountThreshold=0`r`n.Set FolderSizeThreshold=0`r`n.Set GenerateInf=ON
.Set InfFileName=nul`r`n.Set MaxCabinetSize=0`r`n.Set MaxDiskFileCount=0`r`n.Set MaxDiskSize=0`r`n.Set MaxErrors=0
.Set ReservePerCabinetSize=0`r`n.Set ReservePerDataBlockSize=0`r`n.Set ReservePerFolderSize=0`r`n.Set RptFileName=nul
.Set UniqueFiles=ON`r`n.Set SourceDir=.`r`n
"@
# MakeCab tool has issues with source filenames so just rename them while keeping destination full; skip inaccesible files
  [int]$renamed = 100; $rel = $top.Length + 1; if ($rel -eq 4) {$rel--}
  foreach ($f in $files){
    try{ copy -lit $f.FullName -dest "$work\$renamed" -force -ea 0|out-null }catch{}
    if (Test-Path -lit "$work\$renamed") {$ddf1 += $("$renamed `""+$f.FullName.substring($rel)+"`"`r`n")}
    $renamed++
  }
  [IO.File]::WriteAllText("$work\1.ddf", $ddf1, [Text.Encoding]::UTF8)
# Choice 5: No LZX compression (full size)
  if ($choices -eq 'nocompress') {$comp = 'OFF'} else {$comp = 'ON'}
# Run MakeCab to either just store the files without compression or use LZX
  makecab.exe /F 1.ddf /D Compress=$comp /D CabinetNameTemplate=1.cab

# Choice 6: No text encoding (cab archive only) - if selected, script ends right after this
  if ($choices -eq 'cabonly') {
    $output = Join-Path $dir -Child "$fn1~.cab"
    write-host "`nCAB archive only $output ..."
    move -lit "$work\1.cab" -dest $output -force -ea 0
    sl -lit $top; rmdir -lit $work -rec -force -ea 0|out-null; if (Test-Path -lit $work) {$null=cmd /c rmdir /s/q "`"$work`""}
    $timer.Stop()
    write-host "`nDone in $([math]::Round($timer.Elapsed.TotalSeconds,4)) sec" -fore Cyan
    exit
  }

# Generate text decoding header - compact self-expanding batch file for bundled ascii encoded cab archive of target files
  $HEADER  = "@echo off & color 07 & chcp 65001 >nul`r`n"
  $HEADER += 'set "0=%~f0" & powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split'':bat2file\:.*'';iex($f[1]); X 1'
  $HEADER += "`r`n@pause & exit/b`r`n`r`n:bat2file: Compressed2TXT v6.1`r`n"
# Choice 4: No long lines (adds more overhead) - each line has 4 extra chars (cr lf ::) and short lines are ~8 times as many
  if ($choices -eq 'nolonglines') {$line = 124} else {$line = 1014}
# Choice 1: Input decoding key as password - or bundle it with the file for automatic extraction
  if ($choices -eq 'password') {
    $HEADER += '$b=''Microsoft.VisualBasic'';Add-Type -As $b;$k=iex "[$b.Interaction]::InputBox(''Key'','+$chars+')";'
    $HEADER += 'if($k.Length-ne'+$chars+'){exit}Add-Type -Ty @' + "'`r`n"
  } else {
    $HEADER += '$k='''+$key+"'; Add-Type -Ty @'`r`n"
  }
# Generate text decoding C# snippet depending on Choice 3: BAT91 encoder instead of BAT85
  if ($choices -eq 'bat91') {
    $HEADER += @'
using System.IO; public class BAT91 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b91=new byte[256]; int n=0,c=255,v=91,q=0,z=f[x].Length; while (c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++;
using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0; i != z; i++) { c=b91[ f[x][i] ]; if (c == 91) continue;
if (v == 91) {v = c;} else {v += c * 91; q |= v << n; if ((v & 8191) > 88) {n += 13;} else {n += 14;} v = 91;
do {o.WriteByte((byte)q); q >>= 8; n -= 8;} while (n>7);} } if (v != 91) o.WriteByte((byte)(q | v << n)); } }}}
'@ + "`r`n'@; "
  } else {
    $HEADER += @'
using System.IO; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q > p-1) {q--;o.WriteByte((byte)(n>>8*q));} } } }}}
'@ + "`r`n'@; "
  }
# Generate expand function
  $HEADER += 'cd -lit (Split-Path $env:0); '
  $HEADER += 'function X([int]$x=1) {[BAT' + $chars + ']::Dec([ref]$f,$x+1,$x,$k); expand -R $x -F:* .; del $x -force}'
  $HEADER += "`r`n`r`n:bat2file:[ $fn1`r`n"

# BAT91 or BAT85 ascii encoding the cab archive of target files
  $output = Join-Path $dir -Child "$fn1~.bat"; $outputkey = Join-Path $dir -Child "$fn1~key.ini"
  [IO.File]::WriteAllText($output, $HEADER)
  write-host "`nBAT$chars encoding $output ... " -nonew
  $enctimer=new-object Diagnostics.StopWatch; $enctimer.Start()
  if ($choices -eq 'bat91') {
    [BAT91]::Enc("$work\1.cab", $output, $key, $line)
  } else {
    [BAT85]::Enc("$work\1.cab", $output, $key, $line)
  }
  $enctimer.Stop()
  write-host "$([math]::Round($enctimer.Elapsed.TotalSeconds,4)) sec"
  [IO.File]::AppendAllText($output, "`r`n:bat2file:]`r`n")
# Choice 1: Input decoding key as password - saving decoding key externally
  if ($choices -eq 'password') {
    [IO.File]::WriteAllText($outputkey, $key)
    write-host "`ndecoding key saved separately to $fn1~key.ini" -fore Yellow; write-host "$key`n"
  } else {del $outputkey -force -ea 0|out-null}

# Done - cleanup $work dir and write timer
  sl -lit $top; rmdir -lit $work -rec -force -ea 0|out-null; if (Test-Path -lit $work) {$null=cmd /c rmdir /s/q "`"$work`""}
  $timer.Stop()
  write-host "`nDone in $([math]::Round($timer.Elapsed.TotalSeconds,4)) sec" -fore Cyan
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
        q |= (byte)a[i] << n; n += 8;
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
function Choices($all, $def, $n='Choices', [byte]$sz=12, $bc='MidnightBlue', $fc='Snow', $saved='HKCU:\Environment') {
 [void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $f=new-object Windows.Forms.Form
 $a=$all.split(','); $s=$def.split(','); $reg=(gp $saved -ea 0).$n; if($reg.length) {$s=$reg.Trim().split(',')}
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
