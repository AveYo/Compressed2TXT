# Compressed 2 TXT (formerly File2Batch / res2batch)  
Windows 7 support ( PowerShell 2.0 / C# 2.0 )  
Very fast encoding and decoding BAT85 and BAT91 classes  
Multiple file(s) and folder(s) "Send to" menu selection  

## What's new in v6.0 final:  
GUI Options:  
~ option 1: Input decoding key as password - saved in external file "output~key.ini"  
generates GUI prompt to input key, for convenience  
BAT85 has a 85 characters key, while BAT91 has a 91 characters key  
to make it meaningful select option 2: Randomize decoding key  
strength is good enough (85-6 or 91-6 \*factorial combinations)  

~ option 2: Randomize decoding key (use with 1)  
~ option 3: BAT91 encoder instead of BAT85 -1.7% size but uses web-problematic chars ``<*`%\>``  
~ option 4: No long lines (adds more overhead)  
~ option 5: No LZX compression (full size)  
~ option 6: No txt encoding (cab archive only)  

:: prefix to disable syntax highlight in advanced text viewers is always used  
encoded text is either split at 128 chars or at <1024 chars to keep lame new windows notepad happy  
improved MakeCab ddf generator to handle localized and special characters filenames better  
two pass MakeCab to reduce size of filenames tree as well  
improved BAT85 encoder / decoder and added BAT91 alternative   
improved handling of multiple selected files and folders as source  
prompt to accept or change the randomized decoding key  
original cmd / powershell hybrid; script-friendlier $choices variable  
perfected handling of read-only target folder by saving to user Desktop  

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
Encoded example of this release:  
```bat
@echo off& color 07& chcp 65001 >nul
set "0=%~f0"&powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 1
@pause& exit/b

:bat2file: Compressed2TXT v6.0
$b='Microsoft.VisualBasic';Add-Type -As $b;$k=iex "[$b.Interaction]::InputBox('Key',85)";if($k.Length-ne85){exit} Add-Type -Ty @'
using System.IO; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q > p-1) {q--;o.WriteByte((byte)(n>>8*q));} } } }}}
'@; function X([int]$x=1) {[BAT85]::Dec([ref]$f,$x+1,"1.ca_",$k); @("1.ca_","1.cab") |% {expand -R $_ -F:* .; del $_ -force}}

:bat2file:[ Compressed 2 TXT.bat
::I#jg|11111W_(/#11111NVz34111111}^8^1ll$p|r4Ni-Z)0C1llZ2;zVbs1111111KT6Yl[4,Rq?}8B|D3$,{0zA;zExbMs;UfEJ1R/-{d!.11KB2tG9#h9.=HmM$nF$i{I^ja!6UWP13xrLHP29mZ(ZGwc2qfA5O9#V0O;rD47N1)u+{GI_jQ-KtFc~~2Jb~1llApwMRdUS8LU+V,N$Ucc+9&Z(Z!Sn2di]g.2Qb;g!N[6ck4FO0,2?y;#m}@ixpY-LGVi$,h[TUmib/7WKqoT$0pI?jEWcQ)=jlE34J7}DlZy111)pP[v=1,2ww_f6vC3oT+IIU_XxhT)I#u,?/p{-]ImC2^L?i=rHqCaz[3$6w~853=0lhOO{W~}Dn?lG,GTfhyHTaal3}MzN8!ojHI98s^pJ/V|nNZPp~n@MnT93?#S+2Tgff(a4|qk-ea0uOu{DDS/G^dax_hzXQUMhIw(R{2$f]oTo@q|11h#U4cB?a~gpHA)TW5n8EL&7z0,8#h1UDY^kKn]TapIhKp(Hkz+h^[Q0.Hr=cq-GGZYFuf+7u;LGc[BzT5-v&J}STFvWsG)]YjGY,1JyJx=Fdh8cllnP1wUVn&aDMRwnRdM+&]|tLTjlds~g])&;6v{mTAJp0q{;]mPs2g1l@rS^l/ylmkj&r+kIK)MSeghAb9UH}u[Mi,uQ~U7k}?.k/8qb)ZjpZnJR!+jtU?SC=rNzsxF&y/c9KZtg#zy{q(apkcd~s34NUVxv;Pe|/KPvsdQx3Q6BT^h.ovARF}=3$CFjS_Da^=iYYR8L!]o;sR;nlV[Rj#|?Y_SMbEPJUzI1OV4AgX5itxwhe|s{kx[nO.]HHOPwymHeu3UUpvGIM.nvyzdmxv,mqRtI(x.Fc43~d3jhje6_~LfM$F758$04$)O;O2~RO)[53Oe#SK3ucB!Y}s^BHa+2Y6WCc?pb({340t8EL0tu8=HT&j|a5k@I~W}yec5xDr5+kY6Q2hlnL;;22I@Lsk|WuopMr3g&(
::@+Qcjf=_c}83HO|2YMYleGNRTM@~-Vf0T&m9jnR~KZ$(H&qWVsFD}0EqBz[s4{UT#IOo&RzrcI8VU5yvHyOKS1$y#K{KKy6e1K7!{&{.2ozaA,1b+pVQ9wcpkVojx&Tc~PbPJSio/ufP3!ikkA?5dV1kD)o4OoZBX)S2hB?i|2a3uZ!h+!WoF]nj+q+m/IMU!o=C/ZbCA&7rQMA+Io9r[Lhw60q[gN$q_vOrz-aJ+VdX+P~Q6zu}i4nuCjTn4AL2x_bk]7K6T/7_V1J|r2]NX^.Ua@M1ro)[6YZXXgCQ4#w#pF3bU@urTcV/jxg@cwQrX)#JgS1PnU71mvAyO-Ppjz&SUw@bYNq;yaFZ-kwzRq(Xlg7/qB-Xj,2#@eUQpctK$n0_/W,2Eht7u2.=1/|^l.64!7#M-{nbL1BIo)H#kch^ydTwdTZ8$c?QERiWV^Qk3Dl$)4h3Q;uDx,8e{e#3v$Lb}f{-_0XwpaPht7]xjUQvsk!,NEX.&=wuqCNGQTp+^7O,D+zk3!=P{GPawR#-}].PLE+JYlJtvVY(PvzAHHh-TWFo]Mt}!-)eLBvRfWRir2ii+W_Q1=$+u,RDcfXN2slk}z5Q4v;juC4oTX@Cf$Og+!w=3a;0_p&h?MG4htS#GSrfWSdp+!j]Ej~r![jS{X8MwfvjXbEoiSBnY=0?Qxj_F?wJ7s!UOc1D;KTVgQ|EDvOQceZum)R$!@X?-{Q5-,gstS@zRqF3)=fjn1,aQl,_=r3JOdoHYf3_]B)[xI[(mINn$lFtnsQAm(OCq^0cSc/v$,xheXBnW&cV9_=Nwv;hTl5rCx]xnx;&rwIlNiAj^h9^7q,kE&fW|UTr=O|8RaZ/)=Sh.65qq#kF=5LaZW_Q#NTGVq61-?B|1l8GxZ|_S7v~JDfxQS=A)tVDQMoyWq5aIZ|7{lo-.Z];-f}wBl[,Ho@AM-DTId!Daz$pnuRDLmt.p{tt)J?mCB8|H8y;TI0#^x(&lt#6heqU7a)}^xx/5/m=g~LkUDq
::UDFy6qWBh^x.pmP.GW&x#^&ftUXkv,=7Fsv,kdXumfQtNyevR6;[ovp2&u6CQ(ddB@fO$_T[&S[sLKR^WxVU8cq.t0M?G2a!h.lo)NX]ndD2=a-X|1gDe(84s6!_c1j6cPTY,Orm=lHJysz|uxn^JojEv30Kau2tHOqi3-OA8lC6&6UhRzM.Zr?/uF@thSs3al2$sS5WYP)qSgN)80$~j2SUm&R+r,-LNyT0,qFob4;R,,nt47EGz][@bD/Nl~;!i!W--)Ik9Q}Dt+w68[-^/i4ucc4Ny6.Lcrj~KJ(lw?Ep[/xmVjG=#=x1}mY@kI&AsW={uCVY$1W8owKcC(mxPh=rn1l;ZIORhI#-)g-hzN([GHl|X)1UOOw;^}9Yk_gwADRh~esBd!-cU8#6M[j~e8Xo5FV,U4hI3QCx3-qU{?10jOG6pK-+5I0gJgLdCq^&L(wTyEY)PT,$g#HCZ/vB,4O1_)MH,T#!,{z5|eiqZt{/+5R{RP@6(t[gfK6Rk^d6-J?mOO?PYJk_RZW/_WSwPcW;bF#GIj-]4I#n]CLQn,c{se&$V)k}go^P(u3WmvR!;CRny$2FCmL@tg!1UN-j8JN}U-p!gx{f4y{B;!dkfVYlJddao=+TIKh9qHbe].9GHB6Yjrm0^kpngU!b?CuRQb.nHrXuL+}KE=M#jaHQC!{[v..P.gNd#Yl9=@/qvgVQEMxx7l2Q3H7bbAD?h7+UfMow~(Z?hZY+B~+9D=7y1l6EVL[{q4r!+w8)+P4ayC+Rbyq97v=C(byh_6}_m=KaA6SyWKozByr=S+ZBU-6.Bn21hdt(V~C{(vHI7sANY]at$XFCu&b_W5y(dS9yn1JzmI;-f62i-RQlv&.NvBvhkJ_UE~.@_-$y]9@g},-B5f0Z]#[V4IebJWNVwj8Up}Xk{M|9D/&2ND9[0awmzn{$FQ?aI-wNE_.v0NQIAh1|P#ihzHw}gDtkc$4OARcg{)k|B(a]bwrhTUUmgE]LcR?bPLU.2PbyqmF]NL}
::#Lw^_I4PQo!?0-es(o&M|Zc1}vucq66UhJSBgFJ~9A2od^u[3etj4Bl=Q,,V6O8q,eNSUyp?P_IISuL~yK2UUlMZo03H=9,waj@uK{v9.ghv$(^c}$O?u[k)vHVHgF9hD|aWgS/lubzdZ|2A-(H@vMSZ/RE49[js#1l7d_7iqV5~CxTw=zUF5s[YP#Uf6-j7N!1ATfnsUoW{}+pEs]~B#mn2fb#V4dX09LVj&w5h(o,Lk1H+n4lE}S(8{[bc7.gd|nr@/8qN-,8#mB).v.4K_sHAtDE-pk7@/QB.}l9;k{o=oF/g3,-7I3QQb{tay3]3^c/9nTw&DqAHV-Q7s2gfHhB/@1SsiN)JxKXC@nJ{[^5JE7$PAhBwJ4hMH_HZmccEYw^7?6U[A1{C5}pw/|[ma)DEY8Va5s=#c-g+]8Ed}dQxN.IZ#b3t2t#zhTKZki,a9FzC?4qovU{FykeB~Hd4WO9t6fmp(Q0ac2I3IdUH)fie9v)@l|y1igrinD3F#/D)Yf?Gtp@ZiR[RzPQ/HY]hoyho3C!Fc[ebn,_0?l+}]0d9wz5xn^JsV/9dl6zgvedKP@0jf3W]Zx]b2zLCau~zY5zKzsGn-t1!I?)Xs_l@Mk8B[.R0g;((HI[@[PId&cmLK0H#Z2SV$a1o|geO.FX^R3Ju[hhRwD6pnJ5C9E9lLoP(jkqxz,n=Y}s37LT4,W.@0i~ZD)t{2FQ$P8io9l=aRTcM@HEEV};!K0GFQG$-=c=A9kJXaF5BA/U,ar(QLACz!]3d_OgNrbnD.)o-)]|tCm]{esfE?he-atz#7@v;E.o_iPh7W4td;&Ylsd$qEjySSGoo_Y8zJ(E&E4^jFP20G$#;xnA^htsm9lqAz-|O[|{[6VA5qQV)CFI7+{l]/lJ1kUQo$)OW}p~yEZO;]_pf]swO2!ip&oTZ_J4.fu4|k_(RZJ0Q|6HE=RcRwYN1.hdBW0p9myb1b/mSGE+$O?}Zt)V439jK&OR4[F;MX=6z,cAkTWD3Y&rLcMi
::KV8bA-HR)W2)w&4BsKLzV_JePm-C^FdL(^5F-Gb6kwjRD7t#~~&9Nz6KmBaK|UJNT=JF+bzoz$JTTMz5lFE]/?u7w_oIRu^Ktc|oJ{TGPt.RRARo,aE;4m,i+UfU-,z|{(3HtrG+epU!@OlF/7&Htq=e3]a~0H?vDge6;Yt1DzwaXmqjM@GjN4?KpsFU~=C#m69iIgi2r=mOpZjJ7l/UV4_EmA2c=HdMh7&&6zW?#mULVdAD1=3z7{$oBiO}]7yXbaRi_AJOQgbG$d@Pkmpfd_LdW=|4X]Zt$i[8@ByD&uIBT5H/^|-Om4iszyoCswem|r#(Pz6breXd(Akk=bzLlY$({$3QI-Y|SW8MaSOUR8_Qnf?U8sVNZT/~9$AbiPMgoUDiaZ|.WEq,ZQ2Qx@Y9sEgWKHm;Ujq{,RMymag.I(ke7q|G=fM!f18_P59qSZ6_vc#Y3~o]u9eGr+Ks&Xc&#v9t]W,|}4zr#4&7A7~ctt26zQE;k.H,[Q{JvYD{Txqk#ZU[]glyTg[wsSY4BwccP5R}Z6bcgC3|DNLJLE/_KckQm-$=TT4rn.Cw#YmmG11wc^ib9(j7ejau)vN=M2gx-upq4P/CPP|?VTZN!x^!r^A2v2WG}8t4JDdB3X4(N-PLOW/ml}1xdc+.=U{8l,T0yL.gzw_V-P.v8m^G?;Ex(m5w_C/gjeKI{N]pJz9UDU#i.ijN/JD?#ONm0R0KL,tuf+-w}Z8hBjd&K{R#I$#-}NS8/]|y5H199-/zpDbJc~Nh=s+Jh?X=[W[&HhfN&]-gR|1d1xeFu(A!JYi?^GKRpP7e{E8iK9v6r@~&-v+v^.4^2!94u3ub79!.;~9r~Bc#F!^TZ,-W6le$GrVvinh/~?c$cPo&TOQvV7Y{{2h1yiVUp2k$bJ~JP;QF+[x.;[KTD_vmeLyjri8jXQajwj$fe[diOQkpO{@,Z7{bmocSSAx?-BO5D&agHyK1M_b=1KL;((wR6}^J^rcdOrWn{W/eQl!XxdtbKn!rK/8
::qR|Z-aCGEjY6&5T2=j._huIa5y#x+I6)WDvcbw-u=8Fg#Ab&xMZh]sIB_w351b^5B&StB1P9$c_8H2Z1Hxf)7Zo]&bwps#FW{u,}wSC,1)a?e}|gwD~?|oY)U-t,}/EIvLt/Ugy6xBH~f_C&f7a.-nn(t7Y/Gs5|_~a|7=.Wul,rVomWpivm@7M,!OusmX^&sJ_Ww!7pKL/2m$!@s?p#p#s,eC#SsC6.no+qC-MiFb!Gl21@hQ#r..Kvn0$I),p1RD(gkGmYb8r=JY3kY)L~Asbv49)twGpFWxBotbNKAbgvkq3h-_SdTrXUXY+cmjgBiY7|HZL-k3+aZ8Xs5TwB})ClSgPI37zgW0]pb7+2@Ja][24e.5b|hZG_MFAq=}w/eihp[LwpI$MBZfJo}zq&y_Wu/EBcYw9ydEleU9xo8$=i1@lQYz~bIjcK99YNIP[pvCNj|&VJ_p-4[Hk6W@3ig,^$Wh?FxOO-|Rm_Y9Aev}_q&)~,$8#x|#l+GI8Urjl[ywNI;v@(]fl3!,4WqRt$L@R8LuwWw3cT&]]8U&7_;RHQit^Or6,6+^#L5R!rdZo{-bCCr=0rpbhJTaW|/T6N|eV6x{L~Jv8a0Ur#Bb7wYm&#R,Gk4f7Fa2PS_[+TxW]@hr(g|yvRF1WT+=iYE}91rhyimq}ulL,b,WN=0.G|egMoG5m]O&esX$oM(F[o6FHS@!wbMIa73GY4BxsItIUi-!!BNMk!)_)&req}L/FVL&0g9,^MAx3d}X}S.W$Mnr|d9|dkpdhKOQk=U!^{rJ{iYrYPo@P$q2}uIc]{YS#wx5vg7R$DEC5$n;ltUbRdUntXRBMnu.NW1V2w,!PpErGC5+va)EM|[J(vyTOSq!cxeI;TPFV7o)XULL=l[;~F,W+1qA6sBO3{hQ}gJ8t,.g?X=!S4AC5SS2bM~1nvKar~8tT7w}G9Qhk/aZwG(v7Cc+/56NM?@=7}^Tb.qgdHPq33t5u+2IkM~/lO];8T@PaLvZg9dOu|a(Y+YnU
::-3D_1|QLuvsmog}y-FH9_IRv1QfGr4_H,fQ#Q&,?1CLv7/T6d3s2M@S?P{tl,V@fP@P1MFm36LY(lq6N?dW!8##2iUg|LG;gTDIYdG|q/{(P!gj$NGOnqSXVt;4ZQ?AB}$S8WLa@=B,gQ}x-6Wpb#Y&?4QwX.g(,;j7feA)~1V6Q@aG7IP@YGG75!hE|50kgntVB7K6.h8J[~@FU-u,fr)DyZ0ci4)B7X=.d}0=L92}OxNxtE&JcCB/A-F+(}I,#+xE]#c[qRpLCn9OinEHg[?,77-P^fU!fP|iJ?u8SDyhj=mW7UQFg^dlWO[7=e]qCFU^XE](w9gq]26zHbnt&2!p7gsZvQ[.jxc[K87I]PVg{K,-rIhxx#$6E/8_/&4#Nm!~6ye]zl}1VH+--Eu9MU;;2a{+l??9J8Vu+]u]Dqv5fdx$C9EiL2y(cX/ihr8FyRso(E[hm7)&l~?H0-1eBGj6^?R-v{)+it8W@$bC;XTIX4bVv;Plqs^OYJ#2({vUJJE57SyEFDriLbal8qIk(+2ahW[[7Z$xYWOGt6)dxICYZqrYQ#q!@/r^V_UiFKBes-h&Tn~,of{HzDu$.rL}.dW6+&ja&y.C-wAC|G5aO!D0e87{iBVOVun!$X|WfV.]3{p,.CCahM2+pEv!NH4g?aRK|pQgrO[smmp[JhTBzJ}=eSh5dv[hEGw/9CNH^p7ji56[Oo-,+-bwTBu=Y9d(dmC(XY7PnBBse^x/s|/]vUK+aYMi]wj~^F3Woe9(Fs}o_y=8Kj,;{rp=0i8tQfzj9R{pu&RA^A2+G
:bat2file:]
```

## BAT91 encoder/decoder details  
Tweaked version of [base91](http://base91.sourceforge.net) that works ok with batch syntax highlighter used by pastebin and others.  
Same dictionary as BAT85 plus ``<*`%\>`` characters that are less safe when posted online.  
Generates 1.7% ~ 2% less size than BAT85, so if a BASE85 encode is just above a size limit - 512KB on pastebin for example,  
BASE91 might make it fit, but otherwise keep using BASE85.  

Dictionary (can be randomized):  
```
.,;{-}[+](/)_|^=?O123456789ABCDeFGHyIdJKLMoN0PQRSTYUWXVZabcfghijklmnpqrstuvwxz!@#$&~E<*`%\>
```
Encoded example of this release:  
```bat
@echo off& color 07& chcp 65001 >nul
set "0=%~f0"&powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 1
@pause& exit/b

:bat2file: Compressed2TXT v6.0
$b='Microsoft.VisualBasic';Add-Type -As $b;$k=iex "[$b.Interaction]::InputBox('Key',91)";if($k.Length-ne91){exit} Add-Type -Ty @'
using System.IO; public class BAT91 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b91=new byte[256]; int n=0,c=255,v=91,q=0,z=f[x].Length; while (c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++;
using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0; i != z; i++) { c=b91[ f[x][i] ]; if (c == 91) continue;
if (v == 91) {v = c;} else {v += c * 91; q |= v << n; if ((v & 8191) > 88) {n += 13;} else {n += 14;} v = 91;
do {o.WriteByte((byte)q); q >>= 8; n -= 8;} while (n>7);} } if (v != 91) o.WriteByte((byte)(q | v << n)); } }}}
'@; function X([int]$x=1) {[BAT91]::Dec([ref]$f,$x+1,"1.ca_",$k); @("1.ca_","1.cab") |% {expand -R $_ -F:* .; del $_ -force}}

:bat2file:[ Compressed 2 TXT.bat
::+wY$~rrruv]9rrrrrrS\rrrrrrrrpuqrfrrrg.OrrrerrrNr*u/~Tlrrrrrrrr@%{BE9frU<30)Z9rZZAi6+!<q)z_vRGr4qFrhNNg(PrrJn9zi?e@9+V}J4be/\y7>B]d@%%H>Y6M>Mt>(M8f2x-^Qm?l|^lH9dI[6|#;C(T#K4WR9_9hIXGrD@NrT~rrm.I)3KVguSk15!4MX3xbP[o9<Z3Qb@az2MUHmhJxhqi-f@4eQDUA]KVSdthr8*8IM?Tkwrj/2AcD=QP.ZO+ug=!B[y8M)$Xy0LY4v7CZ.r>_rrw.|rAV`^(XgF$1tw~(7!l(5/uz*>NP8r%Dpx$4d1v4cay;wc3|>5wU|0h)wU}u/kA,@?%7]uM\<3FL4AR8fCOb!4|rOgs?|P{{GJ<t@{zFJ*os8W@7xe2Xe4;o.J$mL[sP!J9zEvyhw/EE_u{272JT8D81g<?,UId`okKF0O-aVQ*ugO;OOCLZRBRgbrh-Lk*T\/Ev#lX)#W|HdCs2eO5z*Q<v^_i[X.B4j7`!,ZnNp-,9hOqXL[7oVTnBT(|n&RSTtAcsow!9nCwi_?mmTO099M-27.NOlrvGqibJ)1p3^\v1vu1h0d==<<XkVK{cUXv_qZ%\r0No?(5he`Y7X#H1;8bFKxb0=~(0fh1ENX}n&)J91dMWEU/zlcZGQ{q2#?E{K}PP<*@/BnI?#;r3j965rFzcl2wkir;l>%b_C<v3Y$k!BIm{]WR\Y91^fD%.L$@_/2*dlisS91<O*QY$tN)Xn$Rc;NzmQycpSz#iP|Bai^4lAM?0Vc6GKXEBtpes{1)q5~~lge1Al[u.,s1`i1hPuXO8}iC{bshNjhh`baoD-}7BD=Rk((NM=e7ZMFe@l4%u!sCNK/?U9ge@c`6{u{1iN$2qXW2*-LmLZ5!EwIz)qX7IL*t`_I{a/2}xPq5*PzR90P.[sAXUm{9>g(@%QVjYAUa`V\F)yLa2!/TWqnu^p`)sCMJD-TU7p!~W_L98\I)X*H9<#n*5Z5
::,qeu!,Q+G!c3iS$@N!_XcMr}sQ+C/cATQfqOX.Cd%{a|$s|H}kYZCy~qqC7zskQOalC88E\_,6$AxOt!{c>54urECNh*VLJUWg&bHK,m1^u,YKHM.Js//F]~!fXl<_h_aa1\^J&3i+ZZn$wdjLd)uyri?{N>UKe=~q.b|B8nMje@G]!]aAr[)eUa5hJx^TqKfLI)6Y)f\<r~=iicsm*PyyA$k7WOv`~P0{1Re)v!S/X805sn_;j<ckUM$j80UTdd#.l>DRE(^eMxVgsgI`L!U43$SgZZlaz4/Q!jw=jDZi+nl`&87fgHRJE75~<y0^-ipt2HAg<d=]fP2]HE1Xl`guJoWb;Nu>Ds##pjQA8hhy!HO^^W>9frPJ1@MFdo)6BXYf\6sl$oimQp-6vV9J-(j%EDtWp(+^iZp@C`I=${W/9s49c>vv2tn#X%,igkFCaZmAJkBC2K(Q/5jGMmUv4GFsIP.eyhn(yrCZ^IY<!eXP_U\mt%-QKFH;LD7Yo&nHM%(G6GH.4HRg&ab{Eliaj&_jSj#(0(mx.c.2KaqC.np,E)05UjVnm3HfK4exi#4IG)yPof~JcH-(bVmCbYAF;N[O{7xF-SG>VEJ2fGneT{byeN{l(W,6}>pJ9ckQRq2)Ia;A97LBT2P^F]v5Aof0fx-Zy^76|m|exSB5&pWO0(z!3w}sw|V}~R;J08(VN|GSlsfZCb#t~LQH3?ui>DL;aICDK]55l~zRKWvk2ZEFvd@l%~*{5)D5R#g8^IPZ27Pyv*;[fMlNRBj5h0_Z|(T`S-D^$<+u~VWIuJOdQzbWq-X/BDh`}%s0*@KKzV4zm\/_?y9pM}Y4[lN3YZi6U51kP5zpPm3g&s|^Uj=k`\=Cud4./.e6AS<nG]k)HTVE3It~pe5T-Gw*7M7dJHVVstn1pd]_lcie47J?^oE_LeiiIINT4.hAls>`H3@5%[>3x^4Ay6z`Fu0wrt=K[MoL,Mk6G1{yg{-bB(C}E@x#EW_+P0(w+X8.I]<Ud{tF!y
::/%?<35lXDhXK7wFEQm*YAp&UfUr6UjW<91JEQ)\~Ei)5OCPz*TGnJ@v=K>#@SJi,Nza}Qy-J~{ms`F99~#mvVmwo(&YMjD~2i4`swEy0@kz}q8k]l/#E$o#aLm_~xwe}qs1,N$QNEFrDxtrm0bOA]nt]y6Jt*HEEeB|w~EN[Y57)U9^J*tiPj7>..i><wX\~nk2[rZ+xJ\h+>w{4RymKmlO*JId4,S;[$|8uFbK5oF)3s,f|%P?/z^J-YMhWR{Ez?dFDR~bJS`kRQ}g4J&]C,Dhp_^VZn!A25<8}*A{ou0[W7a%.Lm!5l>pQZqoW{F]&,p[FYs`n`xt~G9>85s%jR-c\)uza3F>(osuZPVn(0w1w8?noT9E@~tL`;3dPg-Fj|e-N9%|Mx<uBf7%[wYLG(5`F<X%dUK-Mb7+s-7Z8f-ZhE_ZrX;XXr6<n?Ro1DK=j7rQx!;([wk,YEtXAT9QsPb\b=yF=(3kU!]1/k)Xz}Ub{e`h7@F1+&Mh|K{R@hE.PZqdfe9Xgn?SUIJ*WlirA]_~bS|]6G4FXpXRq;x42TN3HB|s-e^4(cBz&vpcB#Mdi6Vp@*;voVt9Wo[5MCMfsa2m`hPf-LQ<[n57BA7N_jN)4rSYMT]X+-(h;3#2jcP89M}g%cQr8x6/5U4T6mi@>\<.!;>|mylR+0v+IHii;EQLVDCR_P+U<$Ac]*A2-3<yDYy\Fe]h%DM@#@Ci}T8|up/J>%`Mf=Fa8(iq6{XMISn`)pH*fNolILZVSVb]ZLxFCZB5,&M(<u6LOK_RKR(rO89J]u(5MGoW,BmV)v+#?<>7;8.O4RD07,B9s<qz??mKzW&}A{a2\Tx?/UQx89P%oJ17hO.hg\#Pc`{ngS/scaP4C=p\!r|QE\c7i8la.s-mf!EUq)]C6z#pS(*o5w&{ho!9%-;L9Xf~f}Tiwh(8=?TcMyN803uL2D]CUQ=c({o)S.nRiscwIy{D.k{x&S]T68||c;hNdIVuX\0_?Pd\}dgnPA`}Mp,Oo-imp
::<hBhof6*WmDQF1GB{A]<S82=Yz~gg}N0H(r@)3>8r`DJ3mK6H0+P]eRH#(H$BEROx!0._EccT.NI+<P_(c13@k^E`-K9+BzAaS0\7g)]U[@`1uZD6VjC,?|?N<MS^1t@d./a5|?e7&A/+!qpE59}SHp@2K[~v0Aq%J9HRW>Iu5eQ39|dL};9+!1!EoZMCS=\h)+iBYM*QmjeTh!/JYNhzE#18?L,or*LW_9yCt!Z/om&sL~\<b$FGjr4BO].;Rulszc*$|.hR=\@QV0@[ihte#|wN8&&~I@9ljG2PJ#fN@yK_kJ]mqgLrE2Zu0\eD,*H3OZ`|%jP#uy_kchXk1`|wAX~F6kRpo53K}@HI3iSXiM$[ojf5|a|9$P!T>FE-xciNO@Gsl1W\~|WpqK`$<tdH1z$RjLuqs}bn7WRk$58O+`UU)=y~\>QV<uw~j@ABTwrIm[leA0n2[xD2.&Or[ah_1+#>?79#NOn296=J)M@cQ{Sbg`YY^n7Zg}Ez3mG{vCw=j.f~+==Il=p5Tu|rM5\/WF|-+$_.aLkrR/j(4*1so=d1NPklyZI(3[GK.*g*/Yo.FM$Win;2%^VBH$*9S`w\Nn9~Tn0r71RRGfJ.1>#`poAndWpas0{$g9%BEOKXS5|3|]k)#t8?$ZFRMrKX&dc6,]axHZP)zHV}C8o8O<w=.;}9H^z~lzITO\<V5AcrN?_Rf;+>h.Ko6N/7Aoyq*PEv,Bzs)T+xO1a9SKS+q-8|&#%\*t*s8qF$<L4asSh_z-!_lmNo}KisEf..`Y}dv$ESD+*$0j[R`?`sf->Q`H*ppVou=j2cebk|x%WEL,02>kW%WJ]P~O`Yb\RX!dx|h=J~+HZTFP}~tF#x_/}k=)qfQfa]LV\ySATfAGZi}Z|PhJ@KI)49B8hbusz(<bw$KH~@{](,4ZK.sD`sz#RcGC?kpjNb~h6dq$98/FwN$Gb}a8dxQdRYcW81JbhrH-_;2b*2yl@z_(xgO!mrnBy)TdTU(yZe+feb^,5Mh9;
::UCy}|9j=$,t6`|A$G||-.=k!PK],P|^?v6KQVK9F<jCJ\NBA71szL[`+|8q8Ij(6M71NL*~Zw2+34a/ya*egssg;UMDT#B{4/m5.NfWug%%zn]ZOynQ|+(49{mF*3UfoXi&9&xHdJRskNqtLRqIL}}&XE2N!&bk4ElBty7BRDRDh9q#Xs[ddzsQV*(40(?<8Y}N4*Dmi2-Nn5}3$&yo@|zBKOhr95.rm.~pIHsv~c|U#tA%so|v$0*IBKAT#If9!n(,M`^W>?*$|tS`G23<5IKYASW{jT/#um/PM}V/L@}T[BnsVKLp_7`NMP@`i]}e_&G]?cC#HUe<E6bR07=q%IPU1UnI?5a,=KGq|#JFi(b\]Y-&}mN#+fBvWiGNu5[l~K/Z6_xAOK>=ntBPOEIQfjZ&c23tgGI/~oA>t*ip7YO>!7@Tn#T+`?AI&rhh02a!YY926qn,ZH#TI~)o|3x4yD&,^k*?3*zj6Ycr|KY|qAejDVIf+DE17i?A>aBm0.$D_z4;&MduWXGBYRG~AFs$/aE$YgNewXwC{4eZRkM@oEb-c^S-ok_6Dh}Z+)o!lS8)k_Mn_r\E]wnoU2d,k*^Rjp^/ZTQVZNWDoCOH3Syv().h@#)tCm2h/DbQ/=7n$qK0XS(NLGDBppq}`E<?`Ns}2z[ny1#K?%Q(eOnC4Je$8gaCJ^A0un9LlHh;)S=TE;{YW|?B(<iK[l$o,3n6E3sCpzK1uSaZnt!kl^,6$z/sZvSutN70\Ws9bRg05TYNaW%A;w!kn.yU=R<?w0f{A%>#`xd5eUXFbGUs}ya]*5|z2*ImfIvy[e4Dk(_7MN-{OvI+6YBpOV2n}~CC<4Q`a=N(tB+x1mJpwnAZ(EQO~*jwcR3K(>wP`u!\=RQLm+yR{LGh4(wT`pisqJPcKh={K$H|o1q3~=CJr\+@E+Fo{uH]u->~aZLV]f*B.P_)QfMTY2Da6wbrM~zNic6aE^F$9)WqKdAzA}NOL1Z}H/=xXv5doQ2IMHY*.;;<?RTc$
::z<GyF=@crIL(i{,)q3NV[i~o?sZ?_$4Mvm7q1ok4ZVlqA5S]a,VM`(^~NGmB?KrV*x`;)S)@5u=9s;WR10e.%hc]y{S$NYeS%bc=_T1?s_)Hau{Ly`usqel]N[Eq1CMmz<A$`d)_GZL\]y/fqqH[MendY;>g`x`u,JNG9U}Ge@+{7Y)ij36z(`Dm[KC?Ejgn=|DGD{[-Y5IRnRnIdYni{V&iXZ!7L.0L2f^^\RE/Ej12T6fl+dw4Uc@aMPN?wusK=Dn[{FG_`~Vx]MQ9H63D&QH1pX`C,jqj[a;4)9ekS-MWbo2XXNI>M|VI8>cB<_4gW1VK7mG`m6;L]Js]*6[X+LJ&};0Osr@!eeN4ZOdf2gKc0yglN%D`aU*;PDIIH[R*J<~M|SR!SVPMl{sOJ#vPR(j5QV[ReTm1ns1g%!Vo1YE7vleC/Iiow)nzsR=&7\De~cc[9IlVm0Gf*Z*nsgcA7,o\Ak2PCsBA[,5!@7YQq`;Og6=>4C@HiH9<(\VBh0gSz(,r-7^haD`O?on$sCy5uAgS671StW0k+`-SG-60&6h\IBWNbL!Bj/DA74*uTi4tfU7liWe1rrkX>S44`2/7oex|{z8M<6rTeX0,BA/1\Z<XPM!o2HA&laZei*kO)lFEFp,4DU@#idMRWGO<7Ph)xPM/UD[Z2U?svFb#G#v[%O*VoP&kzOTu8Sjc^@HR<\,_IE^3L4ecfw-DIBKwbyR\OO3?5YSp|H9vZl[1oc;cSRz`nCvr]sHo#_i\,8xS{_I_8Z?eju(9n~o&08[n5z;avvx8AQtXF*QVy_?n4+9.z[{0r,Pks/{<jUUC9KNiTF)YJDX$mu2GrJ8TbBTH>$d[VU;{oFti1,,EsKF-V9agg<>zgMt+\+HQ[j2AFe8r/=Ot@Sg>-e;cXf%H~ZZJF+%dcCq{cxBv~m-=.hwSKg$dEU`js<W{ks/@nP>KaPV/+Tj>.{-]cjs!oixFd1v<I%|O-C>63I[NOWnU[^iI>U*Rq)vygwdlp,6TRs7o
::f\~f+DSF#ZD,&u9NHH%,yPVX-qF+/fzD6GXyAGpa9xI/[Nd+gqh7&%;{qTZ?+=e)FzD)shu38=`)<8k8_\Jqm*R!$|y!]NxMFerti3X[ORPQ;H80!=hBQG[pa-u%($?~^$-4qPReK8kdt.#3|gx&N;JfS/7-#$uZ6#,d/Jk]sQa),-ta)WDt4@E&ZC$}2Kq%f~!.c~C2C]4]Lon}~MK2S3(O2+@h)DqZXVQ8g/$is)axL}euV|G&~.E%<2k*^M~HgeWA1G1GJsnU}i;)=fUAJ=Ky@[ttZXmJkNhxVLwN?hD1.{b8x/\w0jWG0+!5s?vLSF#`LGK[sI\b!pv[SfaU5hyP*b)~0Hy\,^<3+_%M~9C;`x7cG#dLS215qB<U?6].93Qq^^Di(?B&\TKJyvv(x<8\VIyT>McQl#sS~w>!EV$b^6!R.Sv[=E4[>d_Z;*V08JIR>)>c)C3YF/m>X-R2tAPX]K8}ER4p](vuqCj.VM8w24.x~[v4loC!2JJPdkn/>?yK9H!i1GYZ>4pQfV#7!T\BQYGjQ{?[IV6<dd.xGDMlt!.2oQ)5Bf){hUg!dQF+1s[=>_lZ0,!LjwSs7qcX`*V^f7<?2;h4rJBy[?ZjR039YQp)(|3eqwYmGqMdjbq48!&^U@X>plTPd{>s}e5Zps&E8i]XP#cqG{fsRV
:bat2file:]
```

## Intuitive multiple encoded files support with low overhead
One-liner trigger for multiple bundled files decode in one go:  
```bat
set "0=%~f0"
powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 2; X 4  
```
Or split into individual triggers, can be anywhere in the batch script:  
```bat
powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 2  
:: ...  
powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 4  
```
_where `X 2;` calls the decoding block to extract the 2nd file data, and `X 4;` - the 4th_  
Tip: keep only the last `:bat2file:]` ending tag and skip intermediary ones to use consecutive X parameters. 
