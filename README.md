# Compressed 2 TXT (formerly File2Batch / res2batch)  
Windows 7 support ( PowerShell 2.0 / C# 2.0 )  
Very fast encoding and decoding BAT85 and BAT91 classes  
Multiple file(s) and folder(s) "Send to" menu selection  

![preview](preview.png)

## What's new in v6.1 final:  
GUI option 1: Input decoding key as password - saved in external file `output~key.ini`  
GUI option 2: Randomize decoding key (use with 1)  
GUI option 3: BAT91 encoder instead of BAT85 -1.7% size but uses web-problematic chars ``<*`%\>``  
GUI option 4: No long lines (adds more overhead)  
GUI option 5: No LZX compression (for dense files)  
GUI option 6: No txt encoding (cab archive only)  

__::__ prefix to disable syntax highlight in advanced text viewers is always used  
encoded text is either split at __128__ chars or at __<1024__ chars to keep lame new windows notepad happy  
improved MakeCab ddf generator to handle localized and special characters filenames better  
~~two pass MakeCab to reduce size of filenames tree as well~~  
improved BAT85 encoder / decoder and added BAT91 alternative   
improved handling of multiple selected files and folders as source  
prompt to accept or change the randomized decoding key  
original cmd / powershell hybrid; script-friendlier $choices variable  
skip inaccessible files  
better test of non-writable dir with Desktop fallback  
support for changed locations of default user folders  
makecab single pass (2nd one did not reduce size much)  
simplified expand function  
fix no choices selected, now default  
print total processing time  

### More about option 1: Input decoding key as password  
Yes you can definitely put your own / reuse a randomized key, that's what the option is for and it works great!  
but it must be strictly 85 chars long if using default BAT85 or 91 chars long if using new BAT91,  
and it must use only non-repeating characters from the base dictionary.  
__In other words, you can only shuffle the characters around, not add new or repeat them__ (without editing the script)  
That's still quite hard to crack: 85 or 91 minus 6 _(MSCAB. :D)_ \*factorial combinations!  
Reusing the key is a must when adding multiple bundled files in the same script - all have to use the same key!  
Script will verify if input key matches the length and base dictionary and if not provide the information  

### Finding the right options for your target files  
Script has plenty of GUI choices to help you determine the best course of action for the specific file(s).  
By default script will LZX compress files. This works best with deep directory structure and lots of small files.  
For monolithic huge files that are rather incompressible, you should select option __5: No LZX compression (for dense files)__  
A ridiculous 259.45MB source file "achieving" 98.94% compression is not worth the extra 4min for saving 1.06%  
<details>
  <summary>Practical example (click here to show)</summary>
  
Let's say we want something pointless as encoding a huge boot.wim from a mounted iso:   
Already know it's incompressible so we can save time, directly selecting option __5: No LZX compression (for dense files)__  

but just to confirm it, run with just the option __6: No text encoder (cab archive only)__  
```
F:\sources\boot.wim
cabonly

Cabinet Maker - Lossless Data Compression Tool

272,062,257 bytes in 1 files
Total files:              1
Bytes before:   272,062,257
Bytes after:    269,188,732
After/Before:            98.94% compression
Time:                   278.01 seconds ( 0 hr  4 min 38.01 sec)
Throughput:             955.66 Kb/second
```
_not very compressible 256.78MB, and took almost 5 mins_  

let's see how long it takes after also adding option __5: No LZX compression (for dense files)__  
```
F:\sources\boot.wim
nocompress,cabonly

Cabinet Maker - Lossless Data Compression Tool

272,062,257 bytes in 1 files
Total files:              1
Bytes before:   272,062,257
Bytes after:    272,062,257
After/Before:           100.00% compression
Time:                    36.97 seconds ( 0 hr  0 min 36.97 sec)
Throughput:            7187.11 Kb/second
```
_259.52MB, and took just 37 seconds, so it makes much more sense to encode with option 5_  

let's do the actual text encoding with option __5: No LZX compression__   
```
F:\sources\boot.wim
nolonglines,nocompress

Cabinet Maker - Lossless Data Compression Tool

272,062,257 bytes in 1 files
Total files:              1
Bytes before:   272,062,257
Bytes after:    272,062,257
After/Before:           100.00% compression
Time:                    40.91 seconds ( 0 hr  0 min 40.91 sec)
Throughput:            6494.56 Kb/second

BAT85 encoding C:\Users\z\Desktop\boot.wim~.bat ...
7.8508956 seconds
```
_334.78MB in ~50s. As expected. For such large files is not worth saving 1-2MB for the cost of extra 4mins_  

Large files also benefit greatly from __*not using*__ choice __4: No long lines (more overhead)__  
```
F:\sources\boot.wim
nocompress

Cabinet Maker - Lossless Data Compression Tool

272,062,257 bytes in 1 files
Total files:              1
Bytes before:   272,062,257
Bytes after:    272,062,257
After/Before:           100.00% compression
Time:                    40.75 seconds ( 0 hr  0 min 40.75 sec)
Throughput:            6519.90 Kb/second

BAT85 encoding C:\Users\z\Desktop\boot.wim~.bat ...
7.8476116 seconds
```
_325.68MB. When I say more overhead with No long lines - I mean it._  
_Just unselecting choice 4 you save more than LZX compress, without the extra 4min time (for this file)!_  

How about using choice __3: BAT91 encoder instead of BAT85__  
```
F:\sources\boot.wim
bat91,nocompress

Cabinet Maker - Lossless Data Compression Tool

272,062,257 bytes in 1 files
Total files:              1
Bytes before:   272,062,257
Bytes after:    272,062,257
After/Before:           100.00% compression
Time:                    36.39 seconds ( 0 hr  0 min 36.39 sec)
Throughput:            7300.26 Kb/second

BAT91 encoding C:\Users\z\Desktop\boot.wim~.bat ...
7.6984016 seconds
```
_320.33MB. BAM! The most efficient text encoder using just built-in tools in Windows 7+_
</details>

## Typical usage  
Used mostly for sharing configs / scripts / dumps / captures as plain-text on message boards that lack proper file attachments, or to safekeep, run multiple tests and sharing binaries in malware analysis tasks  

To prevent copy/paste line-endings issues with the script, use github's [clone or download - download ZIP](https://github.com/AveYo/Compressed2TXT/archive/master.zip) button  

## Uninstall  
`Compressed 2 TXT.bat` adds itself to the Send To right-click menu for convenience in usage. To remove, just run:  
```bat
cmd.exe /c del /f/q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\Compressed 2 TXT.bat"  
```
## BAT85 encoder/decoder details  
Tweaked version of [Ascii85](https://en.wikipedia.org/wiki/Ascii85) that works well with batch syntax highlighter used by pastebin and others  

Dictionary (can be randomized):  
```
.,;{-}[+](/)_|^=?O123456A789BCDEFGHYIeJKLMoN0PQRSTyUWXVZabcdfghijklmnpqrvstuwxz!@#$&~
```
<details>
  <summary>BAT85 encoded example of 6.1 release with randomized key bundled for auto-extract:</summary>

```bat
@echo off & color 07 & chcp 65001 >nul
set "0=%~f0" & powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 1
@pause & exit/b

:bat2file: Compressed2TXT v6.1
$k='efNVd3#S0[R6^T_HlpmA8Xz&D=n|7E5OiI@4PW{}1bQjGC?;rw~.F-q)!+Mvct,YkBxy2Kh9oga$s/LuZJ]U('; Add-Type -Ty @'
using System.IO; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q > p-1) {q--;o.WriteByte((byte)(n>>8*q));} } } }}}
'@; cd -lit (Split-Path $env:0); function X([int]$x=1) {[BAT85]::Dec([ref]$f,$x+1,$x,$k); expand -R $x -F:* .; del $x -force}

:bat2file:[ Compressed 2 TXT_bat
::DoW4QeeeeeYE3Oreeeee_^N!Geeeeee]3P3e||[f$osWonNhwJe||m=?N1d7eeeeeeedz5rRiS|X+XhvPBH|8iw$L7RIp}I_/_zpe&UC[=Gtx6py=K,C|Dkk{rz,liAi|~eR3+w_BY&Mp5?wTqFYb,X@S71&bBUI~9/jmd[-p$|5B_))uiV(&=F!=yK7/D0wSS+e8lWk6c[C[L7z!Yzx!9Qbd$+}eM-gtONCfC9V-kRPb=_Q2W$;de^CVs{5sCCqm^NDTiM68EErm|65vz_;(oqAE?v9Hir[FpQRcO~3Fa4T]z$38IP_N7efIGj8!gYp&C6|y4/p70)SsieR{G,#.quS[.!jkwK4a$HZ[?NpFcg,c&-S}Zw(rGtf3BzwWkS-up3wJBO;@08qrfTwRC1I[=Aw@p5_r~#[XxbiqQC!U}^efIeP5|[-R_WUeAzQFe?RUbN-v2!tsTC@&y}}S^HEFzTyWB,@;dl6Dd0Jw;=#T9@_n5Nr]lL07}4vqKrhP[C0t[]q.e[0nvMzLqtuc.e|@);6w$8wlqoCh&Jm/M_mfJqkEfV#q()9el]/.|_bvxiAyD[PO[8z8B#5X!VkftJBEjG|;{kJS$8N)K-Sf7O,-BU,!ni26&hE)+)gX8w8!-xxY1^1}i5FC.RFHs{8+K1CoNyb1ovZDdY5y)2c)9QUTWo7u}a&!JR3{/k~|7)f{Y12@x)yuui,RTMA[i?k]dL96QrlRr2e+i,SuG=33xVF6k95+}^Wpf+Dq[2[TL{VjGOoBx-4&A72B+6sP6i?+Si(VWWFIqndcbjL~1MgavkI/kdQRZef.I1ZgjeL}?jW0c,~Aa5QgiM2M}l[78!JX]3hAM1Ps$/n3Q)ETB2r2VB&^Yljf.3OK=sk6Mm.k@M7diOaB{=,-kIFx)|B2/e]z!u4/povuH{=+@OMc@PS@uNIDw!k8O|DF{&&u7mM^|cR{I02@XJV01BruU4t8fb8W/Pc!NzBXDo+G/8vs-RCxHOkq{@t5F;xu7uQ$&s
::~hP)egsB?k$w{Mci{j)/}RPn.m51$?3V4mcEHQ]=VWW]!?{[-#$@Dx}-Mp}mqV$d21J9~Bn5&M-)dG5~qZfa5.6hQML/]s/BP;KaoCxO$u93}Iu2.zipnrx?7g&bM^d0yg;FeE/QbAVE6#cDJi;UfA.#f_2qX;[-)@4Hs4)u,KMOTHPG[H$PQKI~^!=Fjk7{O@{@|y#aJ_&3jeoGPYjxB3Pd$cGcR=P$(84t-fCvqz47o6N3Cews63DRGyGUm5om}bHpOC]#v,v}UMvm.Q/L?Li{r|s3m0;5)#Vt]DN-4^aGqil61lWIO^+MoBC+R=?W!UGKhxwg,6#[hed6!S@=57tm9_G!?dG,mPfk;Q]fzp&uREH9b+g)EYeJCUQ7f)Q,gi^4CGTK]P^~sAhDrKl}7.AOs7?GQ-LF{)hm)0g,Rj+89jH;Ui?$D6W}=K3He[yBwB~@TB)jfX6m^!QEpr83BPlVChFoW4w)9w8xGd0on7b&0WzjUEjmYt3epvz$G]&6XQRX1UjUW&b8NqeecQez9P;tPz53&@DgQa!-uW~E7|7im{kHF/F7l,7rK6[,KacTUNHcToWJC+;r6a.{I$Wi|m77/k(wCII8h(6y)7]n1A+pieJZV/GE!b8AM-Glhl)[6QenDpR#@hgG^[AT/ltA?aW}-o.-f02=iv#E^z{t2D~1kDbc,CH6C2YP_oGML$shb[s!0i_]yVnlBIuh!)n-K.8FsMlF{tGQG(tRAo(odw^Ytb5wsahW.9E8gnVoqD)=k8MXhKcpldFs9B$V^p6pbD13kM#7eB~$WTVO+R?_+[CKiB|3}aUA=PlEYLa$nh/iFFSw3[mgnC[N.R~Kj$o3p(168&/ez,#,sP~GOQ9UIrkWRJiA)vL.#Xa!hwp0C^?i.S!$hh}d-T.X67_(zQB}@oHIp_mv{QMxn-1q9|?J+w2|nBOx-~Wjhq0{nZlJHngdXM|?JfHr3?6In;1ZFGVS5T$v_}=.+bC|[@Z|yT/X){k@qZg^1ZAaB4.
::$T0qS@6YCr=!dz7A2#;dW5m19}&afhBp/AfcS~}|5.=F$TWnSJg{[S)-]!V!sLG.@1m9?6&Z,8l{zof)3{YfmX~2]1HNr|LpMR/L5O?N&V|nj-d5&A0ZSMQ&Fa3}n7u0|7s~#JSBlirAx8~raB@)!nLmJ,Kgzo#O=J.GA)FEL5fpLurCaSW68wgyW};p]M}xC9Jp#[L2|B${^zh{==?=TEc{0O|$EPj#$9XLkVR|A21WoeS@qQtQ^;D]ml,H]}60XVuY@ld~;uyySzpUm!NfmH3G)eXKQH&0UXEJ){0Rw#]W6OZ0Hs$YBe7;QC0m/8v#_]DJ(f6iiOyr,|Zsy8OrrbHfjDJD#.G~$&FO/L~v)FB1XHL0]/[5Q8JNw7lY=}U+IY~n0iRLmRT|/N.v!dHgH,1={(VLqU$Ng0GG[sj[PKjT{D}UeCugfgA3gBse5$+M7mc_$.jQ{+ptVef~DDG{D.-fxnNeO)#?6!oqFGT0wso&Ke$cJL2-9Mg60x;|!N5$JtowC+HqCDct+jPUN+WJA+lqnI9Vxd)+,{~=J=sJ[_cDz/{H#20Z+MSTjq0sbcCi@mH9;d!8+)u7OQyvbyJEyf9IB(Pihpu!1Wo-To)/o5V!/Y9Q;4k}#wbkP}{0kKq#6dL+?hIy.[WXKxogi[HhGd9O-pC|@AY(7.;aDLcl4Uwald|_z+2QSR9EH#V0c6hqwV/,)9}QnqD}vD)5Q(OYc2UA36uZ}X!||cS&sDYb6pl1+P7U5B5XIYR0y#l~8w}I!Do4Y/I2HP|4@O+6{YZlIU;j/1(ZsJ29XH3uHY9c./t#4mwS7xT1?U!nh-mnXAJZiueKaTd-~Y16eDj+h[a/7wX!^X}baBFd|$V3KL]^orXITdA6cR,Wim4tDM)z!UvTdd(c{+}={c?82/6XTP#}f;[jF1+cu$=s#J?{zUwOYlesgrbY4pbs0^t^TFi4lPV}m3).LT]!l/q+KLH9WG(zD$8K0@)Lh()N)1nA2Ob|1RKY)M{h&H=jm&^
::^Jm$gNx,gNayZnYp@Ec&l}2L}V2WvFbLX.}J3o}++|_B&)#ET~VlDL9TajuPO.U!fGQ#X/)]ACv?Nh3GHy}wwKWH8,gH_c9!Ba{TWPgZeDT7l9;JIkz_B2/oi,=58s1lBxVKDYW2Mb-SpF^pkB(wi;oh]]o{U;ry?I;khIP@[-B+xUq0SvZ.Q,MXj^i3W=Ee(4qW9?$SjRL^a6RzDf}u6yJjk;IeBa[eVW6HHTM8T^UHkHwUe&er#qTKYnB2MB@qd_rk-a~[XCpHr5VbAgV^fH?dW(owFt.kVtO}emeF$;uh-,$l^RW)YblC,gOld-F(S7N_H4_$DQ.1!NF4vI]}[IE=V,vG^QVWoEN8)kgI!/T5YlT&a]bZ91|),UIPPT|/ntRizL,(~dTcJuuwGT~fD1DhLXTw6$g~2pHORy(x-OVNAvR7Vcg6|T7u?!4yx&b{36_6_LM0kfP,kEm-1QgS9?EIqzNBJo]t0YbF{b7u|EuOeDCgJ&[Rkxo6Sp0Dr1lTgbCCur0RNe8LC;Hwh5slv3$lk!fnPRFdDZ~NeY;b@_DdyS+_?-w1sJ7,pY@A0pb!+)XHmvsGFKg-I+~f(aHdns,^iag7a7O9#)bTOX~2]D]Ih]s~erJ2I5m$~8ml6Sy!c)o7-EI1[p.evIikpI9^sfsQ3p2PZAFZf$mM@DFe?-2HRjPS0cgB!+w8T3z$tV]poDz02JYhMT]e}lxvFdvcsB3OD!_3Y}=1ola4Nz-O8WL1;rubBP4b2LLfzavhRwXqw]$gb;~,+fbIHRy3WC~pLyK5c5cu;3B{Bd[JS[;{=Z$!.L1R6=q,m.,#-/!(o&dX1(]Ylh?}9OUMlSLSkCG;&EgpR)$lKOjxg6[w@|w6Gv|k2QQE;FfDBtis9!d@g5Pzx^g&WVwMTW.tVQ#swFMZ|o#z}442pw^Q_[m+-}uuVvwm,3jTQ|/x]=tmJlTZGiSBQr29g/|NK~.j!Pg@$=ndDgL06GSj14N3eJF,UxZKO0xK^AmaoX19RZ&
::J=B|XLqg-F~v_=UX{(&7Q9BP,jYytD_)tvvn4o)]y(Z]P3(Kc|P6TZO3q_0)2ZaG$FA3p]I],~dyHonL3fC[Xttcvub1j2#NONg0FTQCXTNzx[$rQ!IO$~+&2]v?w?7}/]s-~g-bep||+#k,2O0;~wO,#F^3htB(kkrm]l&M9kfv9nOipi]+CmMsfwJf[^4f{bep!PZ}fWYCL-r}z.fmHSP|YdGK0n^;j!fxcgE1z}lCp[y!91,BYIpYdiEoH$,-Exk@b9qKXmoGQ|kk07aAe7(ycO@fBFo0yeQBaWs{1V6VaYb+oq1,YAO{|{rG87=dYicP25|OGI)qeet.+T[ch]RYanT3S00fL}vjGGbn1,YkSqQ[w;Qy@Gm0ZQgZ[KkIy?kKc,}$)4sp@,pGXg,hLXqAuDq]uhRn!&]$]ep0&rVwm;WnUx9XK!/2i@au5aVOMmVMP1ADL!^}85{LAk^kD{=Nh9c/lm&{VH[$XX55h@0JL._mI7Lg?n=EzQ_Wy-W~&hBZJ.@yNQ1]@FGfLS/aHXFvbX77lF]lX3dUF90b[7bx.EX~BCE=Rew(Kk&JwqjBZVUot?2bHBTIKnqjW~C8Y]/da2^]E-#o@B@Ww]s|b0x&,ZZmUNq2eJbE1Q!i;7?$pbz[$Hp$04_ddz&[alR$Tzs.v,OOZKlQ!J7~t[-APE~@!$Wo&bNCOL^F(^nBCba3w]&Q2!uAj[i.QuM7gl2Q{vr5n|~R5D&NSa0@omY_mn.1p6=6;;6[NVo02pZPCKVOZqHHMkm46R|0iBLB==iaN8h?@pWeVnU#w/$p/dBkS^[y)XPOu#r.$65qNLV2^Cm9?EMbwJ~6ibWYLdo[(pEbWbtbS/XbK$}+9^K[Y3,PZe#kxwjd1p$4Fow2Fy/vEJ5td|a8vpD84C^7iQ,G;#zP?~,YH97jv|qa-HfHozeA[^3Y;efhf&!tj.V($MXuDXm1Kl2_uz,v;@!#yng&(]Q4OL^x{+}_)q4qAFD0G7D6YeAqPzOY+&x{iU[
::dzi?ianXw4=H9cl,vY}y8byX~TcW#38YEk8z|a7c3VHQ[8#_SdHNE#eI159?kcm{|oomwm;$lH-~6-oC1o8P#f,520O/fm,WjQ;5qkDUcojU(HDyu|azncn2RLnvz~IRTN,/O1XVZz+h_T?}cso+AkSJ_Dbkdm.kXA-;O)Ek+t?hX|g.xtUpfe0a5szT(m,qi{~RZ5Y22ATEyocd[odEPvPH|kBX6adS|l@r~SEWX{z4a3/r,|2bLbOgoK;rH).WT-]G;?]OH&AIXeZJ.aSJ4,)Ip(u2,B6wdzQV6{/|ZrB806[8G_Ot!O7=iOPz+|0X7e1p{Xl2LQ)GgVh1#nZZGW/.&mH,QhP2UyYw}Gak$Da,Asj~on~o=g^r+-3C75unx1b1I_ziF&QwvS^Y3z/?pfc7-GGk~eE^!JLil/_l)&k9XZAKBmj2U-W;c{zHmq+x]IzWb@ULMIT&yjYp9Yuo(3Ymi0oRuykKjY.]UL9M_+XZ_[ID)kLd=[n}kD^(6_5M$#Q;^O3u;;P;lNr[QrHYvP/}Td,T-f]G|kQ5RjY}Yz[2X|YUSf{1Y_yd4lYg3]zwEmZx?|YE6V1w.FO_j;F@U_^no_?ukI29qMPk1Ar|^A=UL5c44xj!=?FV[wCMr~Cr@~8wJ&-TbzC$Z1-I6NsN=8RUylK+k7,.DLEghEf-fOuTh,!N^,BI{g75f}Xa#,L=kOP_)5Z{Z@Lhiy/NM_3dLo)z3_Zeye{bW3[$W}G]-&vG_&VDuoO.yw2?e/roA~y!3/aB37)NX[X1bLE,Vb=WTK!toOZIpOo4XWZw.B0UN~2[~y4{Uek=w?P1XF!;FTLFF@6&H;1Ya~2Q2ElZ1g7[hAg$3NnHw@{rYNDzOs1McbGf|1#qJ0qC@Ya#CFMf}(AJm4^op8@(FT];q}xmR;(ZgEXu4jwTy~sPhe8/#-s7,}WBQq(MavrZ7C9-L^k1z.0ek~l2^1+!5H#=uhA9JjM#M.YwDL4i$bXTyd;-w&5mDVv#^v^.OjR69O4
::6CunH$X00!r/3#l.5}aTJ?V)rk,bT]|jT2)[-yrOJKB@fTz[o5ff|0tHp;l]DscK[ukx)?8UzKT~uF9LyV1TcD7H_,C,]iv{7G#uPqm,hNOXbBe9;f;1IadUn|(6aC}RA=_OrT1/OYz$g11.60M)_f~EHN8/!mJ6d{Gky5?#.RK(7j?I,})7lK33L^)fFj|kQiqGkuujCsJ[Et8;#{X{N-WZc8s.^?+JXApf!t[/uBXmy37E+uzwUqGB~k81{7fkj[LKhu=PCAQ$Nc0pGH1)r;xP|DfcjsSYPpC~Tsvo1/d#4F~@MK!6Y99^40QA3R+UQD1PNpZ4u30=rwz?f^HwVUt-HlZ@F#joF@pCg/TRT@_icXGn6l8EdLkjVZHeP!mngrUKqY;ifF&DtUTq=T7E!~_]?@WMuS6gwZqLe[yF($,#_;Aw&6JM7qGeYa7Fj~[FY@JC&)w+8sUHpGo}z02GT8q,rVRsuqOhclKeLhNsf/QmUk6L)m(m~H1j14P0F|w-=,quQefg1qzx6a1_r$$BZSL&enFhdLz+4wCSUL+9|I66Ao$n0N,~P11@wlrQ^sVVi}npAGKmz6HB@J?Iv=s=L|hvLRr,~&51}kBg_lu?oG&h-7RU$,N7(7[0/5ETQH~LS2?o(0&&$V~FH4vQ8h$IEH!]-H9tTKgflAnZ$fKPpH|9j1y7P=xr$akDgy=3}b/!6;Wd|n7}+ga@voR4av995/Pue9aJ-Tm#CzPsc2PpmJ8d6P_)8!lQN[2V0~e?7u.R/Lk;,?b8T4tk)~D{7AIFYmmT=#(rdZ7}}pB3WJU.[B{RElVTNYl;gwL1G#_G]0rMqsp@-nAa@uT6fY@1UH0k#Uarik3ro?WgT83Yy3Ia6{c=c
:bat2file:]
```
</details>

## BAT91 encoder/decoder details  
Tweaked version of [base91](http://base91.sourceforge.net) that works ok with batch syntax highlighter used by pastebin and others.  
Same dictionary as BAT85 plus ``<*`%\>`` characters that are less safe when posted online.  
Generates 1.7% ~ 2% less size than BAT85, so if a BASE85 encode is just above a size limit - 512KB on pastebin for example,  
BASE91 might make it fit, but otherwise keep using BASE85.  

Dictionary (can be randomized):  
```
.,;{-}[+](/)_|^=?O123456789ABCDeFGHyIdJKLMoN0PQRSTYUWXVZabcfghijklmnpqrstuvwxz!@#$&~E<*`%\>
```
<details>
  <summary>BAT91 encoded example of 6.1 release with randomized key used as a password:</summary>

```bat
@echo off & color 07 & chcp 65001 >nul
set "0=%~f0" & powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 1
@pause & exit/b

:bat2file: Compressed2TXT v6.1
$b='Microsoft.VisualBasic';Add-Type -As $b;$k=iex "[$b.Interaction]::InputBox('Key',91)";if($k.Length-ne91){exit}Add-Type -Ty @'
using System.IO; public class BAT91 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b91=new byte[256]; int n=0,c=255,v=91,q=0,z=f[x].Length; while (c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++;
using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0; i != z; i++) { c=b91[ f[x][i] ]; if (c == 91) continue;
if (v == 91) {v = c;} else {v += c * 91; q |= v << n; if ((v & 8191) > 88) {n += 13;} else {n += 14;} v = 91;
do {o.WriteByte((byte)q); q >>= 8; n -= 8;} while (n>7);} } if (v != 91) o.WriteByte((byte)(q | v << n)); } }}}
'@; cd -lit (Split-Path $env:0); function X([int]$x=1) {[BAT91]::Dec([ref]$f,$x+1,$x,$k); expand -R $x -F:* .; del $x -force}

:bat2file:[ Compressed 2 TXT_bat
::gSuP2(((q{<z((((((kc((((((((}bE(I(((G&0Y((tf((yGDe-z[hG(((((((((g,6.LYj@m#DJRN#^R-5Gyn%<7q$xWs)b8_?YGz?%BrfEI(|J.Y)iG(dj|xJY((bc8Rok$1>/3`$tRWD008[gw[b@/fKl-i|2=!w#t?g.]K>,3gGZ9M,.((TpuR[(q{<lZ`S5opZdY<q5nd.sd1hG|G7?_9(E~x(_(~)=#f_<,y#E<?$auA(eRs&&*#xhz\[G~!t>,c^tbE8c_BOVGsr%>6azBCfVDTY?!S,uxCqbAF((F(<p254C3{C$$;+vP65;3c5;PY{x,Y7{@^mna&*u#OG|72Pp_k1;x<LmHH{X)}UikxU>7NWa!e1.)s/0xshbG>d3!MY)]XSg_SI[8H?punA`-`Nt2q<)xc<x6<6f8.eD8G!3Zqb|f?(??s[2ScBXFVR]6-!6YLPzOZ3A_&}`*t^..21t+[ao4IX+bmZEwk?k!e)0.I{3$pj>Sd!8m,@W.<_XvA((6)R[N>}JP-hF@XIfI-7gnwf)4sW34pxo;BV,Dw(+m]r,}yZe3)d\<CEi(@BOx-)>k{7i$lnRf*Z-@FnJ6zDJ>yKVIT.X.T^\VaHUx&xkY.9C2Ky-uG7;,nS7-jX\InJjnNyWmxp>\?E)4cGARV+}@+HY4{,=[yW4KN=q7u]]8SEmNp@-|N%.7OjoQ=H}w*o0hA5az$pBWc]A(`!a#V20@95`};`F)a9FgBIkdz\jU=M6dH5#.E6F1!z$|fFn8<Rf{4vGF/V4+@4%<#]nXy%HeL__aP#tacFc9}DICsWO&B@aMRH}[;*J7{s(mG8^eE2O=rV+kpsAa0$wl^Z/[x.l=6|zhe>y0?8H-C~v.]Ea,#LsdgAc\xG^h|T_XE~<f}8#jZm$h6DHC;JEmS6d_=_iXQ2c=1;lGt[(rsEu_!g~!_Song\^Okk1c]Z.z%*`9FpV#!<wd3Q5l]=*yR9h9T$z!_6h&v./LT\}bCk{HURd9p_1dDmE
::SoB83@ky5L&6O;|m>dA{kQpj~]SgR7oDZ\6JcfS,j@yHg\(Vr(MwfclLbcMv%{\!Q`!.ouD|M>qO7LSNVE^/.hI1CMw36QV_Ac4cJe#vap[7vRQ`[*B3D&+[EmjVE@{F+24,B*_J8BC=i^){2-6F~bvqAN!TLJV,1y]XrP{pssJ/HY+i.Ln#70Q6%`-].5LIGi6MA,.\($?qzP+r(g3s%;\q8V^fy0IFgT<JBmplnO!V`/b)0DNObnzWl4dnj<nk2tLF(VB&T;+Y<\uukKuA}wY5`D#ed&qX<3r`g5,$)%-U^&udT&iXE7UT+ru6M&>BjF_zi2=-g9.f-q+H~N4d4ce7ffOI\}od9|WdS$y||`5?v52vn@-HM@XfX{g1[Yy&Uh44{8*aR7IsO{(7ufJIfRPh]YU@t>&sP~>_h0Dw9h*3>Hrg<aPxW,1K^2\R;>M8ybx0.f2{VD3P!ety=*OOa&UxV.)+V5xNJNIR_f0SVTlQl4m,hb(Jkc-(<_LI>nS46|avx?VL9<waK#W+^t3.o%Nd,U;vm}miTuDIV%RuGZ3EI.l,CY0S^PbgvveuZr%CBtK-q\fNgm#a.NigWDn]}E>t6I\;)chQyn[OIF?6&lC=exhzJB5$s!v3wr(Xyp#M{mp3fk!\Jev/tFX%bH6LE;4yfJ/ODc?wqvd{rEv^U$/wX71#w^zOM0H*?/A~Yp~XTz1$X]}+,11QZ}<m8#F&r,mR,l~m06y}4fo.hF%nZH[\M`cScqi*k<!*lcI9ZlZV4FITVQGakAld]MMXnMpsdnzr^6/_lvXeiNB85>nqKj2C?Jy0t{v[Ok,=h,^qV)8ovhcQg[DSMLW$?%E@|?>+]oQ{ZE[6#a;-ls`toXn.s<7[Lh*vU)Q~wy?~\jbEgi#l7y7MOS=Sf>Iwb5xv8yt<>jQRO_8@4##]UIn^w`#O|3r3XyyRP_]p=[zykA.h6y|U>k>a6~<_8-9>dT9M|\3U!{LUw^X{c)tI,^Lm47B~6UG0r=mi?n?qDk^l
::ex&t5td]K~tQLoMl|U\9\=7dRk;-27?`NKYuq~Z5qieFmppl=NM@BoISbz}46=w&^p$1z#/q?GFM6&w$>{FpLFBKFU`y~xuh.n=d=2OHufo*NC3O^_,u4/M<1~4<5n&jw|-@|0.^.Gt.?c%uNLtInv}RWyV?9vW3C3f[w{HJ`xywLlPaJ9)tk]aIY*O(9Y6HJxL0<\gC&6&F#.U&Y<>&4TR6,yp9^M>tgT!5em?;TDxMx3C461M+KwxnO%TYsUVWo,`s[H9;Emu!v<u7>d]-N[C%)G{>.Ri=v@(WVuM4_!!i_t3pu{-Lu|kiUTmI2pA|))hNs)1P]?knY\|\ZPIhTQ$wk@1FS;%ORp~Nwp/bdm-.YA,D9jL9=@O;Y;x~`z=bsB5+!LplS=ex/Gak%+19<l11{jd>5dkXv1-B3Wk$LhM4n&@[4P~XAd>niTz+Bg1QHUp5\_Nu4oc%5%Y~eroc.jQAKT]#w7^?yIFb$AhqjM7R\Key#L5`C)#=i5nm`XFi6TvyB}5EMZ#e|od~96qK8;TM_OR!zEZ,B*!Oqzm;W>;M{Co<@@3ZiQ|/~UYi*=*H^fV$9&dY@o2@Dm(t*^mr)f{I}Q8,/[i\Z^ntxX)}y`yN<3uW4dqD0hg3OwP59@y}Wac.3w#z,.Ol0bEY9n^cwiKg-_odi>PA10J1)jHD6EJjGc,,o}UV*7/W$PR}UL`Vxg3Ag47qg[X/Kwt0.KldS`KEcSJ#}yf9*QMCS!j!7RUjkpt*N5&FIL6v8^W%#Q]aohmUY\+>qB-uxDl^Ft*}-iv\l>dsHNsBH`^k!#vqS<0}s=J,1Zt7wQ#l4xtaa|5=^{K(x%Qi}BD6T#./iXqLG!+/$Cd1r]qocsgq[f2#Usr)v5Dg~AZ*O$84es@Sad,6IvvNT5/x(sB5*v%$ycOcr[MQ]*RvaFt^%^p3=^&cy.uHBr@4Q9Jb+wU+?b(<m<Lx!gO!+&vLYBn_]@uDV~^d-PkI(A#k]YA/Y>*]N}+-wk#mo^ohKf-]R!Dw
::Hb>~v/~cu0>,]On`ckgdXgo-,1nD`s%e|nGsr+!.Tf/+p3pmRLrUE_z-i%Z\Na%~hz}a\V/=z_J]qk~RA;z;N!*!0[#?1$S}u\vQSpZf?w8?pgxS8-WNY~%%Hsjr5{sG+U]%>wL~{h3i.j#J4XC6dCHRL/#M=Bd/|VTP-/r4T`TN_Uf-+P([KKu2%<R1(2[su-\.e,\O2TEQc`w~<T4yPbO`JgVI</@}Jn&V<@%hds(={+RgXGIn-Wb+5F6p*rG]@S]f+ZPhi0%k3]mLCWMBk2P`~j15^q~_v&J{;GpXYeWs3+v-]CnbX5IrnRf*$(.=@Q+EnDrp$&%m##cC~VG5oY]#VU}<*]fZt*fp&p6W@Afp>g>jU8So90gTs[PFov`z62g6EW&~Nd66gwZW=E9#P_8-XjdJC\S^(U`@g|DG$hH_brBCT3jF1t}sR*wW{Xb\CPptWO3FI/z.|]6}JI-+h7a2G/o_`I}?m1c;/tA\q~860Kt8Q6w3Yz!We5($_f8%Zbx[HTm/Sxf*o[k,aJQ*l-s7|ql~Ss=f;l.Py#wv2X-3&Ai6{4oVKDv/anTafD!Q%+n*n~ZC-o2WiVVSv}t,^K=2vYN[Cl<SK_cnbtIxl+bld$eCq+X8A}dd3EymR~~hYP=r1G-b[Q9{CrbszX0/8<*Xa@mZ.{p6>FQ&ra0m\_+<Pq]HF<2C{ER5r$n;8/xYCrb!A0]9^Go}HmWO!K]rKfSJv&hNwch8WC,OoO6O(8(bpA%)4chF)3mMh+A+cqT4cB6S/sEDcX{?3xc;o#~8[l?HG@fq+8Z)p@z/L80N4$Y[PK0_*.5~UI=/U4Km\FcjJ>u^&4S3tdA.puXI%OZ7=/4>p{47X+ATaH?zE+sWrTB}_dm_]W2[@B](dulXKswi&torW6Z~A2$X3f~@&?T?g7]Sv{d+~egb&*Y]a)N5/]7b(`}ZpOqV9!AOkt,epxp2oV}]C$Lj}TL,#8M)RTuA+Z9VgU^?{-!$t#u75fMR7/rB0<6;($$Sh!0d
::krNpIrv]+CeQRa~Y4jpPf!GJ9qA-0E?)$jiO-|Oy#Jt`#}50|Y=zD2HhL\+Wr-~;OBOC5&Tx]xy6MC|`I~(L,1=@+2Y=\q%S0G+~UxW*6~D7I$$)v+4W//\\I\E`x{P0/!Y/SnrrUXW&Ik)FV/`YMJrm2KL}KM([M%x0QF[W>>cVd#)WJ>6Z`VHbZdy4/<B]?d(yJuJ-`@`R>#P[F]84ze;+Ca%Z;XS`TFL.skj$$QO0mA\Ric459n%nVf\ywY/s[y_|4Io1H_n=;9dx<e{H{#5<>MbGc%%P,^pAK#R}<OeZQ+=w0*l{kXi#|b+!eD+!?V6J7@U}GBlJ1iL,,x1QGV7\vVXR^&()dm04l=aVLyC}-hTk0w$eA[!.]D2Z#f7fID133SME(q4RT5rfD\-hb]uN.*(-`vjlpcIT|*D2y55D\/[wcQ.W-y*0DbZ*bg^#deM+q7hj=OnLO7NbYe%*56|FN]zAx0X]mF$|b@8,!Af/yhhicZ|E8tE_0P?>u[lzqqpQu]zYy[igtyW}/;&\Es6[2~TVq&F)>cuR^r.Xl>i_N7VleHyy[SP<v/tv<5WCi`x%A+QJg.Y~I~Rg]AeJMx*b)9?jR=+u1PGk7aKy8Al/AuC_$!,4`]DGi~}Dr%a+ee{#hSPI!T^G$)y0*#}qx8{g0>zP/8KfLU59KyQ}[})>4Ld;|}FyTSp.Cc5db4ZP.ZMG$|)w0-|gLr,s&9C]9hl7T%_z7[;2e,!gdYS](Niq=%K5,6>2{D{>,K`K&kHDwIk}%^e/)LDQLk?~fd.PT[!JBPcw;bNag{,bEnqkDdmBV\Gi]x|avjh$&}60J=rK8PAsq%vW~rM~p,6/jfBj3d$_(y?rY;aQM+^b-xqeC8Td%CSv}Kp8fbg~Aq.AD2Nmjt;UKJ1g,w5s?)V~Z{ZK9g0.wl,u?^;,I,SguR`l)*(W3D2&.=`hA0OT?`6MKnd9mu.rRY{\84L75U{Vo04Bu?hj)UO7)zY%-t68?9C^I_\Th6,3fnmal~Nz
::+JQ7G@*dNhgm}u>5s{@X6Id,DARxX=^Ki?*qc)~Ee#;,;Kl~AAh`TYZxF2eQ-Bw`vIppv<;XX0r\*[0S[2jjUN.M;Zn.<TXz#I^hLzMGKR0^cAABD\W9JX<J,e|!.`,h7CzFkY/kj2nCTJQoU2poU-Q_`8NJC=\CS/,C+dGZ4Ah>K,`u$)CMn<PI40TbZa23D-L&gEX*@OUMynTW|PDI)^/zc})A3qhoKV$CZY=h{?gVBu/u1}xL<>6GZ0qB`EV$s`xSua{\rB#e]k(D`4PJNT[$hUeB>{>a8EX-t%BXI^6WoYoMa*igi@6UOzYDck5~keKFJqL=q_qW8d*=3.pTNYn01ph<obZ{*[E~Q{$kT+{n_4Px5_3T%@zr)q0j$MkrH6=k#wf)^*F?s$4kX#KjP!<t\>fC;HC%0?wv/SK=f-b~Huq8(((*Z[nCQT+@g`OKB4}LGee&VK$~yq=9GoN|ntZ52~W-l~GPY)#F-z=h(zuurLM^yR9`D5M9*F\Q8cJeqe0zZ`alH;{[Qr~Kof1W0K$Q-IdRt.;#0?eGM)5)%o},TbRg*3jJu<`i[ANElRd}RJ]Hx99Xl1GBIW$J0O^!tlr&b_?@Dxlp\I7Su}LE>p%]OW+L2XnzaL0)NMP`M{$t{K(>Dcd{x{Y\iC1+>xckvOAU-Wg{#7Lkru=azYcJ~g>ZJF(~{1Fk!d%b}j#k`pqtV@)a(e&dJ`H!6?dr.)okHX@_ohT`viN8}#fd_}B^b{bO^CvOrQt;40rGvGGd*+>SDZ]MpiG/V%%nvw;44TxLvK4EfqN#9}?u|H0!%d{HmU`-bwO^Fnl{*hO|hbDVmNE}Eux2Qjj6vxZY$E$fLk}8wfOh+TjZ}[%kgr4-=_-Jzh/}<eQr\`52n!fLEyE0%T7;1E)xp~vZ.AN36&WbQ<IT|C4>pMpMZV93C#pRu8{SiwI%L\jb|?*8fN?J%V~knJfzR5xY0[XyK_\s1/pG^GxfI@si!&A{![F8P4cu2PWX{]P*%HoJG|vWIKBY
::M&!GXQAw`wcy]+,^=KC}e7DY[+SJ8Pxu.8pJUH+bxPRfuuf$2pfI2?DRN>0FuDV,%SeuYqu$<z1`X6wIgmqJ7rI3{lQwGdQ-bbTs|l1uN9k_1$p,1Lb9<i7PGnzwlawZO%p<_P=./Nn<l^pq|3\aUv2~UukF4d6MpzxwwEy=}*UAbob_pqZ~)J}08NG6|4cuNa]\p.&ERM]\lLj51`SM1A3JA;*U1II>Gi!xMYi?ri}m%B}5VN?0>EMz~UsgSkQb{Pf>%KjW{F[ED0ADLw2`pB2}_2)eD?uXQW1J4,!m=)P*piDEkJ(Ia*raKE6*UOgh13C]ayA_HuQtg?zo]Ox9bQ?Ud!V~1*E2\gGc=-TUh@E#QU[5[=f4n]E+.};PZ};P/\tLqoo5>U/?1LNU<N%M;xnTtd/aX*!$~7qP5UBdEvPb=S2~lZ8Oy=Gtm`TY(ZSam_%+zyYCYWH{n+(L&u(S]4yv,p*6gxD2Q1t]~jT>}}}bG/f{^,cP[In..ppzmZr{*Ye,yd~=Mrtp#|*-L#rQL.~WHY&YHz6Fd1@2w+<4tw(|2=sO&{_7,%T_oy_Z9tLKEOro,.HIpyTrz8+AC,3R>.FdN4!a_`{IIZzO<(QBJ>#<}E|Sr+)Lw.|s*o{zBu{Wm&Ie<QekbuFYMjd9nnvz,_$rvvQ2/b?1ooq6sL1`=Z]Q(&x6M;@/Ap6s[7[`{vS,,2\jmKtb/FDODBT!|!_mu)BW~5hX6h$xEdU0]2dQr0I(y^N/8sY
:bat2file:]
```
</details>

## Intuitive multiple encoded files support with low overhead
One-liner trigger for multiple bundled files expand in one go:  
```bat
set "0=%~f0" & powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 2; X 4
```
Or split into individual triggers, can be anywhere in the batch script:  
```bat
set "0=%~f0" & powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 4
:: ...  
set "0=%~f0" & powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 2
```
_where `X 2;` calls the decoding block to expand the 2nd file data, and `X 4;` - the 4th_  
Tip: keep only the last `:bat2file:]` ending tag and skip intermediary ones to use consecutive X parameters. 
