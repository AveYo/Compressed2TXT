# Compressed 2 TXT (formerly File2Batch / res2batch)  
Windows 7 support ( PowerShell 2.0 / C# 2.0 )
Very fast encoding and decoding BAT85 class
Multiple file(s) and folder(s) "Send to" selection
Optional line split and prefix

## Typical usage  
Used mostly for sharing configs / scripts / dumps / captures as plain-text on message boards that lack proper file attachments, or to safekeep, run multiple tests and sharing binaries in malware analysis tasks  

## Uninstall  
`Compressed 2 TXT.bat` adds itself to the Send To right-click menu for convenience in usage. To remove, just run:  
```bat
cmd.exe /c del /f/q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\Compressed 2 TXT.bat"  
```
## bat85 encoder/decoder details  
Tweaked version of [Ascii85](https://en.wikipedia.org/wiki/Ascii85) that works well with batch syntax highlighter used by pastebin and others  

```
Dictionary:
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~
```
```bat
Encoded example (with batch parameters `set/a USE_LINES=1` and `set/a USE_PREFIX=1`):
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
PowerShell C# snippet BAT85 Encode and Decode class (bundled by generating script slightly uglified):
```c#
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
```
