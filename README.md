# Compressed 2 TXT (formerly File2Batch / res2batch)  
Windows 7 support ( PowerShell 2.0 / C# 2.0 )  
Very fast encoding and decoding BAT85 class  
Multiple file(s) and folder(s) "Send to" selection  
Optional line split and prefix  

## Typical usage  
Used mostly for sharing configs / scripts / dumps / captures as plain-text on message boards that lack proper file attachments, or to safekeep, run multiple tests and sharing binaries in malware analysis tasks  

To prevent copy/paste line-endings issues with the script, use github's [clone or download - download ZIP](https://github.com/AveYo/Compressed2TXT/archive/master.zip) button  

## Uninstall  
`Compressed 2 TXT.bat` adds itself to the Send To right-click menu for convenience in usage. To remove, just run:  
```bat
cmd.exe /c del /f/q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\Compressed 2 TXT.bat"  
```
## bat85 encoder/decoder details  
Tweaked version of [Ascii85](https://en.wikipedia.org/wiki/Ascii85) that works well with batch syntax highlighter used by pastebin and others  

Dictionary:  
```
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#&()*+,-./;=?@[]^_{|}~
```
Encoded example of this release (with batch parameters `set/a USE_LINES=1` and `set/a USE_PREFIX=1`):  
<details>
  <summary>Click to expand</summary><p>
```bat
@echo off & pushd %~dp0
powershell -noprofile -c "$f=[io.file]::ReadAllText('%~f0') -split ':bat2file\:.*';iex ($f[1]);X 1;X 2;X 3;X 4;"
exit/b

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

:bat2file: Compressed 2 TXT~
::O/bZg00000r3wH500000EC2ui000000|5a50RR9100000Q2-n{0RRIP9~uAv00000003i71O[/ALvL-xa(FRKWn?]SAXHdXE[EMH02a]xIZO)48e4#XjR6q!p#T6w
::1UDi80DomWlQ*nE@ZMK36|B|?8Jn]x7~V7u{(jV2JF1g~wOfL!Wyb/E6a4oeYybcwGXO/f0CQlq2[wbY37@Fi0h&1SUuD]C4m,R9MP=?wCSF|F@8.OYjfC0Decg6f
::wwQZO=L,x)cIKGI+os]p/Tj}j(7P7q7XN@&|LFe!AOHX|06/_Q1KsY|?~R/u5hN/;5E4i&iO_c#LjNcD|3fyYw,[G2IZz2Z8U*O{NyLS5h-X)Xkl[fNo3p4j2XOnX
::wNN9jRYwf._2@y5/e!IJR4JT-+8Wi,kmR6+xIrb_[Olh2h6K6w0ab1R,?JVh80e4n6}0{;GaDF/RulKM+7lKP3cc|g70Ee4-I?Vph+UuKJqDJcC~|_-^3#T~Ptoaq
::#uc3qy^R@)//&bR0HPKx2^EDUbGlt]4s^6a?-19q;AB|&+*sD7JUj3QPM6r&W6HtJrvu;&/IyDuJPB#?Hi5{jTc~I/nZ/[}H4XVF(wyE1I}qDScs8t?o28ayQ=k@I
::TKdf*;k94G]l;rJi7cv)/Nu~GQ4j8*Ap1@d0;vJtjyibfXlr0]0,qYS=+SqfF8HsNc!cuR3zqVUQi28hSY|vCPsL|rPE2K2o8TKJ6nfT]sOx|qE)fLJc_mz~VTg?_
::UP90DNTaw{=eZBc620u-QcxQQ/DS4K+}4&lH*GR,/|46bl[ESM6_SNP4Ri.pMPjytqx=NJn-q*QriF*=WbOb&Xl/uMI9)P3EXtz{=HTRW;9NkDvFB{Zkd@g1n|v~i
::N9yXfwjSrDe)dt0Ap6^An5DCGe|p#r*sFl{KTpTEna4h7))M^dX5{;?r??ESdpmHrGHwIpUfSi19&ki*)qNMyTHp7/=mxTs6CKdOv7BY[EKx3FG^,(7XxgQ;reP,{
::DYz.YO,DqJEKa6!]]Z,lSrW+zl0zN2aeA(Wn?RU(PS[OihDzd9S*t.BZD9C9DxBkMuB~1Xz!v|4l?LL9s__4yF*q.VEp@px38}W7+RzY637=,jH02[iGLiL73N@yI
::|6qc9P,!QFQ/ffSf_zlbdlA|kD;a|@-l,ajI?wUSiKM/PlqaNz[j^M7_QDrDeWiF7#oY8]5bnyZ-c?9lJ1Vb1)&Ibe1C.2zNjHSHvJFWEnbr~+x}Jq/]q@,e)lXp8
::5m5KXCy1+6C/*Q5F1A9MySS3aKH?5^!ndD!XQ]p+xWHvinx=22(pF&s0K;SJg5Ped,~~TI4~7/6f+T]KnTE6xwSONt.A[!pdIhX.^L0aokjb7C&PyU[vdh=T5l.kd
::Skog09;=w99Av1[eCCo9E|8OMCH_#)XdJ2mUj*A~thm,0_3?tckVIxv8w8Bnfx9o6B^f8=s4Q}frg,nsTqL#IjrqZq5#x@4I+puwa(U7x.qk4O+@/ZL6Z,#m2Ltj=
::;R2wv(}0_,]cTT0YE1REm2XxcD}T}wkno^)=tUVlqs^yvu3t#q90XT.UrTSPq!Yft?j~beE,I-AzJ&8mE6I.!jhuW/zJ=;uJQ~B/@]a.6_QDsHm#Sl8X@VzRKJE._
::Fb[|DV[G=PiZnbpxA;Zb90@KJD/F#T[Pg.59#Y!5MSH.YrH@n3@b*^WVsQoc_{}XIwYm?nk/X64OA/a};Eiu*W!U2E^^&kn=-f9EaF&J,guGtu9}0jo/RRMIzRMk3
::!ffK+Y4gPHDgpBJR8M3[2F[uJ*H5rQ4|Q1+/NZxxY;S!UX)N{iSI3[q4uFN}I7j&0jGNOTIvcnt#Q^0gvt_yRa4zEt0#}jfhU,UEU_+4g;p{@Jp?DBZw!3ySUt^SF
::v*98_b7(I~em&Q.KSe|6^BGo5-O]H0C!,.So&X9P)8iz!mj-*!R?/Gy]0u;myK2=_;;==nOAV@4TgHBt(5R]qxGeR25u@K!mOWQHjvi*n35?JUULfp9VTko2[pXxY
::R{72[g1yGoatWeZu3x)cTxDUeyZT!/bC#7G9hvaRhF+I?1M[=&2]tWdVn[AF2brLysS30BWh~[b,U!8r69E#[VVAnUZ?e}wVRDSd#3D~KjJiRW!@AU0U6z)#y&Y1N
::RTifTGU/C@K/Q(Qrivcn#qY5BgX#B_g#]p88cDoAYe,m~qmVBqPW*n|zhkqEvlN[FQ};kG(sTNIFQ;/zFm)?Drov;2(cOjcR.@_e(5kIP85gaUj+1~hOiA*ggGRO|
::#&x1)QxOU3Xg5gpvj-[|Wf[8_?.+D79a]^v#.rBU-jds7ZpM6{Kh8UJhi@cEP{!vw*LVD0K[RKW)Z8PtvYtvntyj@OD8mhk|Hm/^0uEFtfLWm8avtUw,^FphL~2o_
::C6sFSKJh|/M4z2m.aNg6y@e*+q^JDzEvRz#z5cd@#Cp^!Hh_}YbHlliU6,TD)!))U;*Y@-D4@M_HnJCh-2&(*?y.(&Jm}OLPq7,)8z-2OQf#0YHUZn?*.jx-tIrxg
::7*uQujOl7cHg,;{7B61.HRvVPXs=[=@m[YsDc=!3niPlvxz*EHMdJ#AQ0,,uVPwJ+SuNA2*}]}nHBvo,IpP;Q5-3.h+yU,Qd/i]lfQ-dnrdN0ryj786xz7F]y!/n(
::lTF@Tg#cY&X=T+RtXzT)n{xSc9Cwud-5G&vnU?gqUz*p?U5fQ8^(Fqw]&,XE2qEeNPPR3s+O|f).E~wy,A5W8y?2x|F&Fe+{b.3~Dw/hBNz=^|1L&?jE;nC(+BJbE
::DYPR,w]H&wFG#FCn(=!p(|vN5z[R[kHyhcBSZkk-K7-?TsZNCTzu9DD8Ohp}.5zU&SeMsu@=6Amp[,ej(;-uB*@x0LsX6hM((_IAE@ii^Sdr9e3R?iFm#^PFPjwe^
::[jEU}]Tp+Gl?IyX8f1rY)ctUs{|wV?aP7B=5{#MQA}|**)t/O(s*C5bmyn3}o.-zdUN;,s{xrXrEwm3aN}{AdW1Y#89Fon/ckj)1Ctyflo{yPFf6M5v{6dm_8hVnC
::5cs3}f?xXBJ3x#WtKV97cqhCx!VO*84jB;rq4+t7U?j4qpo00W]m-#WL^f&q,ic~h6JY]Y39;QFm0^N0kQ!FT+UO7ROSBV72{QnFye6QXrK^b!yr,WX?8MjJWr.Ay
::N.Dv0CyCRSXp(_wKu_J]E+gt9_ZVo)ZYnXsBIm!q]Ia.v(#/Xo8HvneZc9ob*(=&{xu=eM.?J+[EArSRhl)*qDW@|ylmxkDK,(sB6nnUsfGm0NOgFhZ1Ya6EhJihN
::.o=zX*{VazO93bW]#Er^RZY&~wHm&0LF[QD^id0s&0kjaPLnLLA7J-dh*IbF4vglrtHzU]_Z(Odmi^edgcj-Znto,M3PT*K[tuE*JJm04X)A[;3wwrpn3iw.f0raR
::]NJY1@]L!7G-p*T5dA?G9(FeQZJX(/U/
:bat2file: README~
::O/bZg00000q6q,100000EC2ui000000|5a50RR9100000MgRZ-0RRIPOc4M800000003i71O[/AQbj?TO-^wkWB|o|@@F[vOc7gvfQ;nV#1sGkLj]V?003[PZ?Bjj
::)+qq-X&fli2#SWWBcK2XAb;pdwI&K2w5?)LXF?13,!TcIW)n)v005y35u8}aLJ}kZ2mCbh1A!nbWMx=R;)iHTwl;bM_xKHyh5h[HwYh9}w(cpUww7!|8nc,HN!788
::tRdtte]2-{|NS7u00000BLf3fzd,]iB4wc{6EQG3ij+35fB!mhV-xxeg8*6p7SO!_aHH(556FPXKvWV_3sFTWcRW/}iw-ws29bRLw7.*z8QtIr08u9BD4Uhft|0i1
::FE(Jh7]F;3rd8veQ-;+Mn[~=(WRp1.kdD9&fePqA+sM5(y?16]N.ESH&Qm9csYxjVjAg-Q.uq?fzd8x#63b{gC.ZUuKrwW*_oh@dK/A&p3MnFyhMU!)vAL-A?VDI3
::E~z2jkEDpv3MY?6vVZ{2#Qd9|/lGcSfkkmKe9*BR*{vtALpy=|7u50Q2V^AVF3tFeR)=2*c~H@1vW)/yZT*_5bqJm#;bx)|={uNYKyFG|K7u^yCwoFm!0Bd;37qUs
::#D{DU0*CMD!ZU/*wq!j~Mz.;7emv2WN|A|&O5.taCk_nd^&2M^()qdt9P?=mA~s~BA5=WvKBDo@M2v)2xQwMlx;vWNPbznsc[pr/-eQt];?+CHQKszRBwnp66zCjC
::4y;cxv7@[#.-c4+7Fm)qOM=W5.J54gqEjiEZe;i|/7{-06ga.XQhP}HkB3lCiH?v4o|=RYgwNBA*a9o1zHcfhpnCH|L@pVnPmg}iufrC8FgoAiQo1=rs7M!mumWn=
::!LGJBv9e+lU|pixt+|-hncdT.*aG#?6(1-qdYf~]!vJ=SzkRBcW8SVvFW/xKqd)RwrRBWqq;mFC;AnNH;U{k7Z;v7yV^&/[@Er+/3r=TdNe.qmEZ|R#;}{TGB^IVl
::5-9muRU{obRlEw!_Mt)u3aNcUci_cwf#T2f=m4UHVAz{_tOU5|gZ}|D1EK?=^e3/JNy-)lX&tzu#ZVK0+/)cOC~K}3qM=4#md?4/L#5SS@oO^(wX&_!g@+RAH!GGF
::MXr1p.G,|apKkmV4YNYK!DofMB[VOiJUep_lj(~Zi?Xg4-G=][eRDPz_TM4M333r[R}5VGWno6RM5IA}9_l{vDu,5vcLjAdtu;LJ.YfUah1@CH{iQvp{f9=]8w@pL
::!OI/#ZIPYg8p&kENP]s-!c|wUY/g/97gTU(wRu,q*&ZNbJ&h/*69p]p!4.GUnrw-TY*3Sw@o@rbQ?{i+1aH_jf,Go/2U5CuUEM&lG(YDHiml1)w-(][n1hrUU~D/0
::6.~P0]z?eara8O2fK/ojXNV4KisH1,;[l&&7JsEBV;mW1rCOo]+~8)t.lu9WwBX&5)WbWE!&RJ!a65JDK6}(wsqZ-(mFn7wpU#]RsA@oCXZuZ6D*_Nm?-Gz}{CD,]
::q3r_R)~lMj8eD;qKSvIi1J2OPTbx4)4ebF*&4fE?xt}OWbd+VkPn/#z]x^eetgL7bF6&nfp(rvlvm(|wzI){p{*#yQ*^gaGdKRpvls|}@0[^FP*z,oibrBI#IZ6N5
::^75Oxw6s;9!{cJ0VQXzl*d?4{[ZFJ?3vPd+F?pD9U!,lwCkdE_*b(D*BzsxnxZHE4Juu7&M(H^]baT^nRCk7Yl;,6=JTs|gS}RpN.aUnuY;s-^qBg6&X4hEVneSI&
::dPJ,;9q.!E)WLuF;*AErBt3OEnytMrDkzuL6?nNMA&+IlA;LUJIy@7vHMFQnv7VuXY?j6A/aP0=9q9VC_mX[-^YO=+J&.N]d(ghkSt}&*qrN^vSN^,umU]DpeL,80
::Y08},7^!]f!2eGyDaG](44Sr)5N3a1y_9rlUSu4io=;,WAiqX)TLnd(?/qs7_[M@.eE@F=MP))@De!)*.+eRGJbjDv+FeNsuGi(9h4!NO[bwx3dJLdf[a+inrx4Za
::WxY4dna*9D(=/QakjZt}Jlx?#cY=1iH8D[s+YM|Oat_+wENr=CMz9Ro9d@=VAbkb]8=^?vB-xwe/+kg|vS]e=&L8}HdyI+S/;_]##|?n_=0bj,9]28JOGdVMdqOmw
::Kek2~[9!,]AXqDuCl]-sU&vqU_C0fYadkVpYvD?p@fbnFc(pZ*Wf)K@alyiHb1zuAG^?ISp*}/Kto(]4.3Y0j2X-tazL-x0kDFkp*.d^;TQ;V2BJ9{@_Jj{{TwTpF
::Z9!=LunmACQ}I,~j@3TU_nQ(B!4zFQVLKS!uS[VFMqev]^QEMgkN(P#HFseQVTJW.4px5UpjBr4Df|^b;G;i&ZC3CJSRy8&D3F~W./!WCnS+n@m5EVKzjDbIP28LW
::[|q_Ot|G&heDb=3)-(esui9Aze4unl*-pnzk7upkVK4*/4@knSM(c,mmf1M=zBKp&rdB}0(yg.u=Xah3FjT7YvC5]~jqm[PcQgXWczOW]Ad}}SjJ)wiN_MLlsaz-*
::unxX7hw4O0r|I_/.)J0qX!*BFZeT7W7v7Chpumj95!V56Z={2Tk+|5fnD1|{QS((H!AC)?BJeE[xB-6]7E4Eg+bSVi!iP[9]1Q6.(a#-sF1r.ud2|7O/o2(5_r5mG
::z0-8b1rV!=VQ6r)UD3aOa_xUrt_Y3OBwZr6Z+R_QS/C@lKq=jzTrm,44JLHsPnhVM(B0n9mO6e*)y#^O#xMP!Q)!&)dZDD2/~&)|fwx;3(n6+c71g9!&u9(g|B7yc
::@?pjL??|-v3wdKn63pc6=TCDe7mR26?.J;d@NmEyPFd=p;@rGvD67+HtEmzp])a#Yu.+eN)NK4e7Ha8orUM?tAhBuwPYC?upW@Bbb(7W/VJprGVE=Ee8GdVP9[xf+
::?9NRg@4Qube0;o-I=TUy^OmwcUx,l3NDl_L7He*Cy;/8@EDqbPiQ8ef]7#;?12^-GL,VddKM2A]xc_mBmyaIFi0EkN=vIm?{.CVm/px)oOu#D3cQ8t1jhmAjk9qr5
::V.v5[QZGO0V5s0N)n[SF#;4TcHLU/S]R1gG,!3;i?xF}R/Dml6C,[JWC#?P=lXRe9(J@ERQ*Jftjm9PR0N@
:bat2file: LICENSE~
::O/bZg000002m=5B00000EC2ui000000|5a50RR9100000L/wH+0RRIPM-5+?00000003i71O[/AOi4pUPE&nylS^4ayaGoATY!L#01&FS00093H8KDI4n-h~JnaNL
::mY[PjP5[jJ-~)DV({K9})l)WU[+c(p|E2(_5Uc;IGXOwE1OQG[/Uv/Yg|nJ@44f]zf(PkjM@}=JeUmGal.ZU)ZjuaUlr4rV|0n;d|NjvB00000002NV]B~ul.|sxX
::faQXM0q#73WE,*Dy|[o=fP@O-zHjy^H6U1fZyuK@1;r#vKDtOv-AjzZ-aXW]Fj!3uSMb|@25__;F/;5{4^I|r/rf6w!C-SoBoAZ41F5)7uE2C|WXAeHv2};V3tlME
::g?VsGUJS7l70lgB6tw@*b)^O.l^WA~G4.my+=Wj|yHF8j-Y&1UUf^rkr0*gPeIQ~qKs;VP-Ra4027QvqNv|P+?Cp(gbn^pH*yoV=RujSa;;Pauk|HlyVt^?T9wui_
::eDdbp#*1dt;!mx/FN@LZqWix2J78rIxf3_]?E,Rs9H,+,x?mCN2iVm-#Naj]h4sTO&~ok+@~sCLBTLTWJ.O~3_1@?h#e38qY{MsKd(J}H+ZELzdt{KP2P*&77e2Iz
::zse!hK^D!m1PRG9K3#s[cCj/.duEE8T{OXVrb,X!w46.fxKYGZxS!d(Zkjq4r8GAe5JB7n*pMS11/;gn(^45L9MTHCE=/&#RRnX2Y?H!p*G7+Xe}UujjKdv-96E1,
::C=}8xP_fsjJr^AhWT?@AVsSHir6V9*t3HBF-P6||wPoaudh{WqwP!1hh#;ZO!#uWt7T=MT7)hd{N;C0zsjjO+w=^Lsqn+FXq6x4cSGL=vWDACNk*J*3r/&M]Z&ufM
::IgLG_qkcw6dwdinRrnc})Q7IbYFsxHay9qu/)&rtkZSfymlkMNn_XAMXB9aTIjs}]&lIeD|30RY]n/{OroY}OH{YY]AM60z
:bat2file: ~
::O/bZg00000fdBvi00000EC2ui000000|5a50RR9100000O8[_?0RRIP82|tP00000003i71O[/AE[x@UVRUqIX;~JBWpe/UuvCsN02u)VfPjqvFpvQZ0000D00001
::0000gAarGTbUk5pbZ.p_Dj/QVY)~OgY.SA#00
```
</p></details>

## Intuitive multiple files support with low overhead
_A single decoding block that needs to be placed before the file data. By default batch script decodes all bundled files in one go, but it can be split into individual files anywhere in the script:_  
`powershell -noprofile -c "$f=[io.file]::ReadAllText('%~f0') -split ':bat2file\:.*';iex ($f[1]);X 2;"`  
`...`  
`powershell -noprofile -c "$f=[io.file]::ReadAllText('%~f0') -split ':bat2file\:.*';iex ($f[1]);X 4;"`  
_where `X 2;` calls the decoding block to extract the 2nd file data, while `X 4;` - the 4th_  

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
_Decoded result is binary and needs to be further expanded since it's cab LZX-compressed ( expand -R $file -F:* . )_
