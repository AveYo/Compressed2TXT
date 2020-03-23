# Compressed 2 TXT (formerly File2Batch / res2batch)  
Windows 7 support ( PowerShell 2.0 / C# 2.0 )  
Very fast encoding and decoding BAT85 class  
Multiple file(s) and folder(s) "Send to" selection  
Optional line split and prefix  

## What's new in 6.0:  
- GUI Options:  
option 1: Input decoding key as password - saved in external file "output~key.ini"  
~ generates GUI prompt to input key, for convenience  
~ BAT85 has a 85 characters key, while BAT91 has a 91 characters key  
~ to make it meaningful select option 2: Randomize decoding key  
~ strength is good enough (85-6 or 91-6 *factorial combinations)  
option 2: Randomize decoding key (use with 1)  
option 3: BAT91 encoder instead of BAT85 -1.7% size but uses web-problematic chars ```<*`%\>```  
option 4: No long lines (adds more overhead)  
option 5: No LZX compression (full size)  
option 6: No txt encoding (cab archive only)  
- improved MakeCab ddf generator to handle localized and special characters filenames better  
- two passes MakeCab to reduce size of filenames tree as well  
- improved BAT85 encoder / decoder  
- improved handling of multiple selected files and folders as source  

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
$k='?{PVyh+Yrm&!vsa}-U9,TOg/#fLH|36l(Qw@~xNb2W;q8oM$FDXBZIn1S_G.]Rt4[7Jed)jE^5c=p0iKzkCuA'; Add-Type -Ty @'
using System.IO; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q > p-1) {q--;o.WriteByte((byte)(n>>8*q));} } } }}}
'@; function X([int]$x=1) {[BAT85]::Dec([ref]$f,$x+1,"1.ca_",$k); @("1.ca_","1.cab") |% {expand -R $_ -F:* .; del $_ -force}}

:bat2file:[ Compressed 2 TXT.bat
::#^x@;?????hdcHN?????avPS8??????Ch~h?HHm{;48aDO9VAJ?HH9fn.xWD???????y,3}WxZq}dFC~l;#_!6BP0Hn.2tsWL51QZ@[&,OZ7+P??Vd#!eX^3XcT8h
::MKZuI3sZi#B$~w?X@xNNUZd&.jQ~wnE118l0X!?0I9qcVNJPu)I_,T6?PFDBr5KG&v5v5.[Epi}/tAW/.jgLxQ!Y)+d2),-w.rnFYgUUVMu(|Y2#Y9ws=D/[Wb.Qx
::@+h5i9{J)X@ZbLavoCA5H^oDr-&~@p42YX-lwfX+pAV{$kf4bT??hdKqE2vN.Zj}.36HfZfz[}~PI=os?+;WaVFK$vket4j=aaE-hd.km=KylrFdJBa$H.BnED{5=
::R.uCc3QzgN((s}4aM&,Fd{(mGI&4y-OzyHT-Ii;JKRV8qe750fqvTO,J$eQ/6AR0VHh.PEhW3zQD;B]Gn]?-HvkR$|L_4vjg3zM)-+Yd]Jpi/PMG+[&VT(RXcF4Ys
::YZRVmCg0MlP0eOno@F@=wYYdIxGeDh?JRI^r/KU@;&BZwwx~Gv[wY+Brr.D_n=Iy@Y+gwV2(amC!0ns}dvSyR?@c6=Vx^I2!7n7&T?/hgO.ooP|W)SKP#epp$VY/o
::MSD|.;Dikfn4D.O,xXU]9-H.Ay6-};IWqG/!Pt=L{[q=V9gGfMckT]0=t_ms^_y+l9&cb]{aj_@^-,[4f}3?vPh)I+!)jOX5,1Po0a~aV?T/ZGFMq!Je[QcA-{}yq
::h6}xKVu3SZ!ES5a|d!L)M.xcT}IjyqIy)Gx4{WX@e;;nbeOz1i4~~qlW63,C{co3UT1B[$VL||tOp]+$^C+6]K1yFWZYj9(;)v,n34ayM=/GTho{NT$lUcV?gqQqP
::T!Ma!3@Anv8~#yOqXV24Jb]}2TdM$v@c3}3R+YMyB5I(bI7Mp9r((+&B(2t^55P^4nVZtJL!Yw^wpa9kVduz~39rX!Y,[3Mb}6n;r23Tq]oJ}!o5uC5.,qmuvKi=t
::QVWz70/Uy$7$a^y}ChRhHdGCXNM~~7hM7?#]^iXWyt^.enp5bI9.&=e,a#NBWctKiJSs?RGRr&G8bP^J0&C(Ayjy-s7#UB1T-ZNDI#agxfZWSh$W&{|7!JvC{Xewx
::!mEmL#sm7mWyOk@2TvTa?u#[dK+gMgP~hcgdgx#2GgbyJ#~/^Lf_X70~uHdYxU2g~O)F6_qDU[+oZDNZcsWEK,k8+9!bs,AsVI[?bo^?R!tZT67I|uvwTrSIhx0Kd
::U!DONhKlSToZD$|}1_z@RvSY8YryST|i#c~xG~E.|PN&@nG,wm28OZm+fJf|^zFtzCgCm7.|zG1sexO,f-Kcpe+bma+(Yr9JJLXqiyPZtK+M_K~vGmwH7KwFX2/(q
::^FBW!DmxRuk6le~&s${wSJU1FBFx~V4b?2dH}c.P^/ZnVIjvtA9B=eL(_3HULi9pfoD{u/NRY2Vwz0u=.h6n@+URLm8$AJG5+i,|1ns9Mjfn(6]zTgxQa!AM7g?m/
::+oxc;sh$mQ[i3!Uo71}XquQajvzjS!P6{qo/lXuTd=A~&+J+4bk+K{[+DAxSiAIU({F_9;d)lU(}&8|a2A,zK2^^9VIRS!3bd6t.?CcUX}GlJvNHx~~xu2$,Uts5^
::&XRYs+[E[bPF=89lRhT3{9F9m9r8^.v|/Vm~w$RXV.@7z$M-A$huw7Iom$VR!vzBhUJ)PRD+~?lFR-,zwn4o8/3W3e(OlphDdQ6J36O_ok8vAIy7/1$aLu$v]SiPD
::3vpuhG=$&nF_JYVosUD=+i1dw.G|knkpjJ/0q=!{}H78z0&0g;|Kdco/zbKc_7c66B2(Xwm|x,,2[]ZzQ0;[EdN1ymrD(k=Tb)8sj?lV/X&r0fYOj{-!2x=OB-4#N
::GXm__dtJIcWKExsDN)85/TB51Pt[@F(M_}N/zz6UpJu.4W}L#^@zz!nLxoDCF47zEGc.H@=y;Uq$YY2nfF]1wOCl&qD{Z-iKzs|.VN939nMla5=7^xEkSEj4Sv@Yg
::DNJ!DdYcsj7Ji{/yX=,y+Hlf,|?/Nl,;R1)j$FbbyeFXolfsI#(o.hf#2;FwrNOA(JWyPj(I{g7Pc~HR~K1Iey5)guF&4XDz?_23f}(]s.6)lEMYx$DO]aQjNy.@C
::6)PGg1yGH|iDaVz#wQDPKQz~DMg!,&.yXA1UZe.?I,bM),}b)/Fa=pO1WEw([am)A-nG64_W?1ZMy3wEL1.lT#@H-=seSucpyKu0${iXOkLL=jc9zS_n.6YRrRZ6c
::g=8nNM]GRHbPWnxTA6[=I.)]p~pf2W$Q8lQ){culD~IT@TfjVt;^g4q3K1fF_(^jVS5_^CV.F)AmK;=iHA4glLnn0aZ]|Q[Y{Gv+v?L__1O^UES#2^Ir)=&h@1qta
::GHT{JWGWT-YS;^149)]b&TY+k{+#SK|SY}.Rlp(A;/_E0WZbTiZ9/Za|zeLI)B1~;6+~}e&OVt,fBBr$Nx+Q?$c=RYVT}7ev_n,mO]dAUe@=^UQylddfnH^4GAy$h
::WL=.ol_{R-Gt]j42}W(9Xg(K[[K,Wn],$aqv-HT~BZHl1Sw^Mp;M;bcYn5d0f&KXI3AxL_G]zX@6P4xi$[)UZOpeOU}n@V=!Yww&G|7,2YM{)({l{wO8TxYPGy{LK
::O#(~1W(NoRI&sC]V9zh9?&c,Y)S}ImP~VzC&/g{~MWPT.zzd+MUSPqy5fR07P{B+7#S}w0EVl&}7W6~A@I(+0}!AeH+wBNw2sW3aKJ?mn^6q{jEZpJTDD;2a@].{o
::,!N{cLRydgDO_#-?D$D_64K@dWSrMbS/PFg&.ypyDRG1)-3I[R~[i8O-5&7q55-wxsW)bu=TJMnhzE01FY$.rhSmDMMSgtV!Koe8D)sK.(#ILTaGmoNP|N-4Gl^[8
::Qy_WgvFb4!/HNT]y93aRhg8rhB5vKEDq+|_WWxL!l_CDo,e=t#W@PS!)C[Ng/[mr^c[k#)^O1m!2nqZ8b-(P8?fz!oL1uYz9yqm0Vs_Xos7g/C,@MV3.=B6R#P]}F
::ZYFyma{coe#_vr/EYIPH++tOG(p|)[XxRSe}ZtM4-CQ=~#j#H_(D|~0c[f_KYw.QU=~a}eB+^Z,6Mm8@4vjU@v^/g(7gv3m]#P~eQlMKC(#]zIc#HXW9.;krL!mi0
::pb|-A{m$sYhWP=z8Fg6eY.,Q(Rlep[8R_ggx2d@cDHR#PPy{Dswu_BV&jtM27AP79f3/2|#IhVoe.@Lu./Bw#0Nhn~a^n{=Su4eXDd6b-aGPoG#FVNNo)V.J&zOG&
::i+W7]0@-1HE/I=&jn=LPey.@}W)r$Ln@4$V7}(~TNzE(2(INvGP++~rTGzM^D]bWh0f^FBW-_LcFZgCSOxi1OajpPtbY_c^p/h7OM2U/C|K0X={&fc!.3rwVw{yDH
::?n4&!j?#PRnq!a=DXeK&Yh!b-7n2_wZFQp8STI(^za155=DgrAGGsl2dpwA,j}RvmU}VgBT(;4U]/6ut3iyeLK{[!/ZfetR{}FQROX~7B08?s]+m.}qf(|NI#.mXt
::=D#OrkAYi;?n&[N6I?7d[pe_lBNauUnAuyH)!J#tGMI.xrhP/W/rkd6[r83+;zQwvWA,rl(6d!jqld6YsYL|[?qNmMFbH2AmpB)!_$&lmX7qe;xc9RHOD-&$|=HU|
::o2]/P5${xQSp+p;hzV2xY~m.x-N]),,($CqD6!b9^/U=065uWtQs,]Zj9N_OCaE~^POmKb)!!/06M$Q4s6E^n1FJ+/^P-[@MC$MB[tRl1g0]p&g.^i#(~Xsfxm4(g
::]/1eo@ZG}@/61gh_yB^th?jM09GQ;Y2yMD|jm]{(J7g2?qzY;E8rJN;c4BHZVtdm,YFu.)W9}|qBy7pkbch.wVpICldUGK(n_;w(1cTqQX&Eu=[PKZlHy9taK@7IQ
::WCa)Xi;AGa~8XjQyHlt?$]GHR|[H;RKL-8p/jHCZf,cWQSX6mqiRXHDs$foSKvl.WRefv#-^u)N|61}oHsm?P^quomnp#(2ps-zWPB?X|#==Jvl~5+V1;SOeo6_cF
::z2Ombdd3?~~!;j9gqkTQjYyY-s$]+2~Mrx,;}{p)8I+R67BqFT,Zv&T@g[wQ1)IxGo|qQW;QTFtbEmN(sIGT2(UeV|.)15(Ywr8EU,x(Al&qDz15P[22!PV$Kg#4V
::}9OkZaA+9hpt}H}0aNeTOzrFhm]TX2Q(CiK8F[qZEr?/GlOlIAS$gMk$c3C$0OKsM^3a-Lq0XnwDrC9a+-R^&aYbX_|D!yXyVC9xRBF!LiR85)eWj0Fcje~nQ@l{~
::3=6MxIvW(|I@;bDE,]v/mH&XDpr#Q/.RZJ(t5pDo$5@lGis9uiy]ELFJ?|03j86_#;6abW1E}b.GuJ,96r?K+Fk2nXTsR={TM/^3Z]TU6ig6kDP61]7z9$TO+zn}G
::xou{Bz;~cp_5W?44V|2gE5Rk6$!FRowkFc2G+FiD+DAOpXp$e0lDXMq/DwL0PiM0FxLkv.YNKa(_8x8=lwJgWVxG.WxOw9!vW$S5,?b._#YZ[JosJ,)QkfeV4m+Qz
::1[Kbyj6jgxJi{@}y^;&3U0@l!Gj?PhG2PC(Rh;GG?!5dnjmZ[i)[^q[E.p7YSUufo@qkDf#02hIqCA7/C+uUx}6[+g;nDeJYVmNjtJfR[c1)[s&V5jHnJ@hgG,F0_
::xpjp+;}s^LQjNwXYP+V3(T((?IUsuHsBO=A(?B5$9@[uWGOYEcmLeg@EDol@mqg4SwPzF]}4L7[]VC9.mp,LJ;+$9h,[t,^wn_Jo0x]Sx6@UjW-hj{gQxdT{-z8|h
::xo6tSl}MNr9t=?[3hBv}0J+)Q8cZNat7}~k3aN?uy$l,=c~8y-cS-Az9K02NI6.tz]#J&J;b|KC+m1}VhoK)cMx9+0iGa{.+y-~_$xFsG63h+EU#HIzKK4n!zp4cg
::&~ICq5P]dYyF^&}VID8GElN/G2)$rYkS8m{YC(-Z{uKeqpr0Abpi;RNT{(+&(|,s0-z1l-a]|q(p7$)}F-Y~uZefG[y3YkygFx[@j}Cmg93.8I_sC($S1TnHh,d}g
::$Esz){F)z!!9P!8QhREzvN[gBS?Wny/Dxe#rQe+/iY0W@M;=ZM!1+bM]$xy_jHs|cGCU8uETz.0=kK4k0tNmG9dT[chVO(QzE,w#ofF8gWKT.4kd!{5s1g,4gNM9f
::cU0b$wB#ziZI9-K4{(~_]zD51TUwaZ|;e71.6Ao=rb7JcVi^SC?|NvqRRD3z}+~gtbg8Y)QgNqS5dC,Xwrw$;Q{VbI@q12(0KK0.wm.GS5I-SWW!D$P,BrN/kcwHr
::i1d;WU4hm7fk=1Z[EvD{c6ItzVj#a|BPF#$kp!8AWN8~;c$KG;h!5Vww3)V,qftElyn7D2D[N8pG3nzc-&uNrzYzk_8#BSVbP}2.pdd@bso94OqDS{a)r#M|bh+r[
::N[_X(2Uifgl?DJ{U@u8XZ_tG^Fdp2xbRe}sYG48;bkc3]8CMRt6r7NhSDA5s_q3jTFn5Z!PxMDc87b_&MGIOcJM,[(MoBcTp(Ht5VW?ZNT[@u&dyCb3(3/Vf9Zr3$
::q7(bUv.un(Uu7}Yj5J~.EBAZOhFO)nU?b@M-g17R6c4$8&c]}x?2VWcMhbDRq!KQq.t-A(!F#+$M.[9;LY+gNDRm}(iPot{x{KO[Zu,+zLQbXM,i9znB5JeN(Ilt8
::1[qMWLrjlOQRhP}5[h+MUSC_AF^BycOVpANk5T+sDEFo)UVATMwl/rs0QdD,)$ElxZ+/Ff2BG{n43zDlvW)T0#=Tl&xI0$_||D(MyYw^K4z6=v{0yi~H^@vmyALDz
::gNS|YOMbLiJ9q&15t2f={p?S6cy.q)Ko8HPJoa2WY)29PfY!V5GL/{PsIh1pki8vwGVUjUIruCJVev_;;pp]WFL.F4W2e/+JYl?Po__F!b;(K-521=PVmT(f9ggT^
::kBv,aE7v9]X;jjwhT}#yZez1PZ19WTa?^^q-JN4bm}bBcZd,pcZjckMZiBUCn4P+18btj12rSZAhV~q~@aOPG=zmM&TV_5f#9OY./!Q|[eqIwSxrR_yoxtaAkiftk
::cKW.oVzo-ln-#|7fNMccP(f$r+GQHivRo{Cg~OshB|4o2p#SLyPJaq!4nROzRBAE3sJ^E^EE@^;0X=e|^z0eX&$Lyfr+jS_~=/)TZg-6_qYz;ib_AQwd1$Uc^D4|)
::T6-FbZ.NfV(YsQqcrB3TKX[D!_lPFV7QUgMdXQu{#BwiDi)X#Rw|mw&suWv(T$d,#8!R[GRG-LOYa^Q){MVvqcCW=ynP2Y,oC_(F/A[/d+pLUNIr7TsTMRLx1vx5}
::Q~^RbUT={h]HOmXiE.FB}c@@PtRGJb7^#4Dk++~qHIA4FqxH)?$xl]S[vpK|kaW=MK}6Kz~hG$Xh-FrG3iqIkS;LU^HR6_O,ZAcEti;1iwXOo5M.Y27QgSs7I/^.p
::b,pmLRT!jf-.2#!SUS--6/dPeM,49gMi[+62)/+;?DKoB?r~
:bat2file:]
```

## bat91 encoder/decoder details  
Tweaked version of [base91](http://base91.sourceforge.net) that works well with batch syntax highlighter used by pastebin and others  

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
$k='xcg&N1V;]~h}dwuMnkF6Q87+r*#Ke4b{fS=RX([s-`<Y%5t)9$GHE0aBz2O|q3@l.oTp_mPU!?>D/\jL^C,ZiIyJWAv'; Add-Type -Ty @'
using System.IO; public class BAT91 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b91=new byte[256]; int n=0,c=255,v=91,q=0,z=f[x].Length; while (c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++;
using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0; i != z; i++) { c=b91[ f[x][i] ]; if (c == 91) continue;
if (v == 91) {v = c;} else {v += c * 91; q |= v << n; if ((v & 8191) > 88) {n += 13;} else {n += 14;} v = 91;
do {o.WriteByte((byte)q); q >>= 8; n -= 8;} while (n>7);} } if (v != 91) o.WriteByte((byte)(q | v << n)); } }}}
'@; function X([int]$x=1) {[BAT91]::Dec([ref]$f,$x+1,"1.ca_",$k); @("1.ca_","1.cab") |% {expand -R $_ -F:* .; del $_ -force}}

:bat2file:[ Compressed 2 TXT.bat
::KaiGkxxxt71;xxxxxxybxxxxxxxxl1nx.xxxrz9xxx`cxx.x-]jti=xxxxxxxxRswusT(c8ky]E0rxD&ZbUGlzp05xWDzxqr0x)p.9Mwgx+D[r5{Ld8FqB]H\5gE7O
::CbI5@N{;hy)5q[,q%U8]_iQj3)@%t>}Y14?Zr1$O*FM,%`*g8$yg-d6xrzXzxg/;N7yH)Bj{qHTjeXn{0S$dv9JlY>/p}0!FXRnS3?6qVnsmbWs&55O=?yG5{LNd5M
::&$N@iK^j0kwOb.?ko}Qe_J?c6@BAiL\9qA.A@5wcxx`xxrZx8o_Uxis3e-d|SUh]akK}&vqCHfbP!5a1@j.2aY0H/Gba#/uR-az`3[AH)95@n(d42jRco<3<oiS{J!
::1j~}[ye~#uju74m224~c<!p6ul8*<TNOn3AFdI3A,!h9<gpL>.C|*[%MfV*50wJbP2B~|FUt2&]BopgV&m3cZPNxG%23Y}vGQ_D)]u)|DI[s>j3lemW%J(gaM&&;8V
::U2<e]c/|bXgV5&A$TG9}Qa7g*@4)\zzqfP+Y*S{(`~v4GaIpTx6=geIw1ncrFEKBXi2cU|cd2pCeX*,<e6pi.f?+J+9gW#Sb{tV@]+5{/u>2E]v7P7}1*yq>`L~zt!
::52{uGFZs570R&z*rDc&2F^5_/6Yb7K4s##<`n20S?~i`%!0%iFS4vF}TC[#-*Dwf$iXP&E!]<8D!-TLjS=Xs6J5}w0J)LG7O{dP0Y##~`|e4;tGF<+n[0Ri9PJl$84
::CzH+?HPEq=[h!ETOZ2}xiXX9[bq={hR&c3mq<5M,u1/zewY50e/w*&&D_[M6@\n~P)NOg>a&@+N1Euzh#,+HbnO}x7}@X}!>B&?6)G;VQp@mK9Ee)!h8&|D[KZ\wfv
::C(GD?<5{,T?SERJplm->2Jq#oVGtc||Ej{=XMB3lb,b$e>KE+6>3jMk\vF7dmuEM4*}piz_cS~%a|FQo0?h*<am;i*dM1U`(;s}C7M/T2e*S#%wAa_tXC{}@Xyl-,s
::cd5c0!B(<3c1SOVt$|[lQB5zZ[X2l;JS[+tI[FJs9bIH3bI4g*)3|/]7fzS>8gW}3Y/f+tHwwjiK13SUKYMW9R`+[t6J`q)*ipBT,V5vs0AVLyI^l9!SjjYZn5O.tM
::d=o>G~{sdH]/%w%qfL*^0E2\1vsaBi0{pd6CQhM4jwHtecs!(q2~tR40|d1A51nuv~UTWbhB<tWo<-<VN3`+=sA}HCVqO4ziM=W3)FD8wLB|G2;%<cK}\#JLE{{s0X
::pt/a4q/>W+7w3lOj(\yF-K[ay~{f[WAT_}@~![;|#h4KGQlq|zDQe!`fbJ?!PZ|Hw3C=fYW+f;.<P#;D^@*jN);ViaqUM_E-G1>nO!lY2InL+K]B$7`.@I(U[mB4U4
::Qu$m39<4Fb@}eC_q-{N,N6nL)hp?*.5_~j3kUyLiujO](M&9(U};6#~^V$.;}3^C3t!<%J*S%AjZSk5RRIT.lrUuzdem,P^*5pDrX|i7+dY~jDR{|(b1@Ft(MLkL=D
::0,U*9M/t[%Lqr0@%Mm~%g^xr~ID/.oKr!Y+tkGV|B&fARtgbuKrH_y=h!lr}f-JnPrtW)<yqjo$lLjkM_9jgW,&4Pc--d=[ukVgZ(${zv7\jD|mP2J.PTLi-m2Lg_#
::DHpb63p6wtTr3RMrv@1/^$rU.58/w#n>L*4S?@P*~r5BoHO(So0laH*.Uln!zG_b~1\r5}H]j}6S-joeVl&eu3hd=<\QQyJiG;YqDL]2FfBd=WMWdy\%BPbS}MKLC,
::0t@{vnq0ivTSmq[@?xE&&e9@@V#WGox/a~DDm|J%#XYPWTQ7tZ;%uz\Q4KKszPVE>]~&P(7A#w+Lm`8qBq36TAc/,lNX@W9ez9rtU1ig/,0;|h6#K$ul,D,s37d/LC
::t\?t!4Esh%lb-K0b0&.KUz]-vC+^d8Ok1YC?oZ`k3X]x^<S@Ut~q]78.AV7W)ZK,_$AE,Fk{[P+J}F!\\x\0mQ0(P6QB.V)E1\-+H50hTL+RD9a0?_L$;;U3+q`$(P
::3RWPh~/zP>+Q=Yi(i&vbeV6px1ilt+41~QQbeY^*qWa6&!X{[uoZUl6J\kd#<*C.1lB/fhj^5.13}(\.ri#&+02As/DnD}bGXCbAXY=U2a\Q>qsBf.8Gi0}fk-l|H;
::2E*Q0|CCdt,jEP>QkD;rPdNO)3klP\JqAuni$;3#UQ!*YE{GJW!4pJB/\OH0vU`2Q9&7L$B&69=*1C,$ycT5/<xeG5u[ZF/4UH^,gHKt)O&KZ`2JGMm=Pz4IA/EHY@
::}.EsZ5EYos}k3CVYcAL,TLVP#OnjlK,xY;L9-2c.{{QLG(StPy~HwDA=6c|-YWgqhfpdBc7.Lj0P.gI)LQT>bRe$uc\@zSk{cHESBdQ<1$PF[}Noi}Lo[8o(D0g_5R
::CHiFR=R%k8332=4zni],IXX,3tj&*|Ai*^ry\}ay}wrPVkca<kCILLv_e6k.;c-d]msO3kx\c{H{-Mr.y6lrHrJhuFZoO_9bMj+-#eDZMAKt9Rn=3cB-S^<j8,-s8i
::7EN>O~i0V`8n]60\T[59~2.(I2J4hd#lq%Bgb(6NY9pEu78Ld2czS*=KpLlXsf]xP.bBlF636;ijqdNE$fAD]g4LN;t8tG0GtV<z]2;p)rO((<wf$fViIn/eL?y2p-
::e`(v_H)g>)A[qOi,>6O_`9$G70zI}&SAt\>h4H|iU~9$G?2?9\QC*-$Z$?+XT&0X0k[c&)t7FK)SNbU=`8us/b1{lnqr+[hCxJpM,Z~?P[fNDzKhk7-A4\p277BEui
::EXNwKJJ$[%567V&Kts`SPe$HqM9rnANZe/goJ\!bZL;=.zv|}u}t+)|ydz__7=z9R&e~X=A=tt^HozR-z5_Vh@UpgrvrDHS+`G`;1&+Zrb{WjrI#[Q{k5A6gA5l/V5
::/aFRHI-j{SpUsdh4M*rxFM&hK+3-9||(`;w*gC|D6b3GP4oCk$!vJT75PQD#|rM-S=L+k&zUYDdf<1eCTjYcyU*fb)esB(;?(\xCWsO2Y-q6c=a@^>`aErEot;YS07
::>c_JRBLHSi-s\N|u5nQ9s`{(k7(N`Fg8V&{eN^X<XrZPifK7QAYgpD<,k8&RG9.$0A8^=(GjtX,X+u6DUfE~Ra=8{T!pS@9R2yTJ7+9c26B9%!>/+4,00{q<RGhey.
::~FzF1IP|F0HzS74KN7NXVI~/!bjICP.Bl-@=2c,?HBqUJfP[Qi{3?o5f@GCQB-X?(;V.8kmY/42^\#S!]CQSi-{S<_(`G}SJTx4N-^Of%p#LTC>rx.w?S0G9kqW-Vm
::n0WS!uszh,sW1h%&D#yep(Sfy~vhr+iQTz@O1Whlgx$S-/|`]({kEHn!pl*q^yY`cFbRI8-PTEMD94A!Bfe]nG|8~/[-3dHAjeIl8bgI6m8]-7v9fI$;t}XnhZ,3Nj
::Q4#u*=z8ab$/TCJ<9$e$RNHeBYPQdp$JT@t]KD*-2PW(15tviDoI-*e+Tkiz7&O9fT);[#_.o)G0,o!tYR/xMlz$pfvmIQ^rM7#Hv74gXt=@4oj}O2u9FfgQ\j6w}l
::T@?>-L~*v!}2I<sT0y!,YZloa$;Y2{~0~R(vd6VoG/}~ctj+/5%2sT?mM?cF,&QIY&ZB^Y8IapwnJg(k%Q`XUP3$lI7tIAjr(D4AY.ZF$MJIvcUAaR9PlR1Wc%HB>I
::d#Z27|WR=Y`G$lZ1gH{(<R7pGphyF<vfzhH!{>HAL?]*c;b+7YF_+S^>lPfZ}Jmqy(mte$jZ8-4V-YvPi^z_@CBc>pI+-?uNqBWViQG$YCyf;?$g58K=03,2;1+Nt,
::C^).Uo0R(TuR*GJVO&dO=@jy2*&GowumvJe{0QD2-NMt;Mi+3QT2MMUru.Os}4^d*Y,6$it]FOL6n,4GQ{9l$S0yJ}l]ytIH#~2Z,gE8{Ks;FBq~Y?$kv>#\VX-8MT
::EsG5oFEK~@O(6SJbC9q!a9//gW;c39yw4~!6uD/DS1Ka7.h|w2O]i&YKrOnhuG?K19h~uk6^KpGkWf,/L(2B/@~}q$pC,ZRUkEq8Lb5KAX9w=/;G+30G.}!LYM\3HO
::c;^RnU%.7Q?`d^=_eZa{IzF{$W`n@lt@+%?i+Ju5~zfrgEM*5f,%?s[zLi0.7ZGNro|mbM~p^h&o.q^m=Lqm$Lnf[F^)9RUNmH#6`9Ps#sJ>G{?E=!-UHU8@yDdDBO
::kTW(=Zmjd2MWDN|_b}}olS7U#-I!0OR&|=>+/DINuRT)am|p#nX&\8E!>rGHj4Ga<Uoq/p60B6RqS$fS)%lgG\\tIZji-.pdL7MrL<!#tEjm/oM?H1!~xQJAJ\6Snx
::I~dqwE-p^E^uLJv6bQ<}xWr\mc9;)L9LNBfA?aQwjdgzc!CLT2.`s3%23SBJLJ[3w$PC@SFId<LVnVE#z[{JX]6Hq00I+zh@xib+c.%y.\D<Q($ZhX}*]QZ4XTs40*
::dQrOV`Jz%!kZv{QJz(5.cO6?,*bizk<b.~713^fgm.<[&-=jWA^G!j%6U?iP.onAA8b%kt\8AMBz|\S*%l8&SZN9<bJp4PkSS0V\SGc3sH^crHP6;Mlu`8%seA8?N0
::vu3uiDxgKM%Y`#qgFls,AcHu0;TK;&/Bo*;4++hS74yjo0HaoB~uEr_`;.%CV7IK,$pW1<h>cVQMz1x=4s+uu4z*?hG!ZqBD,LThF_H<nUG72YO2],Se8b@m1j<rfc
::7.[2hZY??]5odMC3I-YR!RBTZGPis]zZ#rIje=ip^4{_Z=?+aL!YkU%o8B[A4Dyo7e&Y]]2ZZkcW\I[acu5s`\CIjvY*=Q;$D?p-ztc?FQ$!9ZI,5\>3~-HUYGG}1i
::}]7fzz\hIm4t1wVZ5o;NJegou}N/{7>g8Ds]uh@m4MvR*0Ud,fsya<pE}gm-k2ZH_HG^{LRtuf-fW[~<|]`E-1LFMte,#gj?<_dQ,kl`KU}a]$)A!ER-`tLGv7S5ZH
::%eTQ^IinF+A+%!SrR97{@wkn8Gkt{oA2iccf#}r3#TOdTcQ{ab^2)!GC<~PHV3[=aj>!7Txs}PM/LFFDh<nctQ%q=/@{Bz7%sosE#I,wxLlOdZ=+g~\cHE;M=.@(D[
::}~pq%;wi=ZUO*9gH`^j9nu}72%*7KSr{9\s~neAbs);cVWiVmc%wY0\q!-/JBWE.(BLB~e/dg*lg@>#=5})/,Q^[\a^|ScJnPFruR3{;L/pS-0/p{%4SWACF%z)nwk
::]F~jh+Vo5sMjs<]?-`p?4zTR,BRA5T+z`gO7nJpZAABt^+U-(z`s`M@sjY--2\feg~&@7D,i5>_<c!(I|_.\&6gKm<t#~qjJh2`;yIMy@aQBX`mjSBD_A{Hn/m8icP
::kK_E1P4/~C;-Kr07Qn|[;p|[<XQ]1}E;93X.%r]<h2G|@;x[k~@}w<.As-9cU8SwXLEPo2+r1&oGQS`\D}LWwT_a~U9&!B]h|M=5k,=#%5~2%)9KrV&tn]7Foc3eAo
::HT,w8A4b(Y@{cfDG=-1(dG_hqs)IiS[J>+@@`t{5cj$I=4kv[e2h~!O`/9GLg;.rt9P?0Q3i`FeY_Q0d[)E-j*8;IqFK%|C#spvJ813X3oXS*+B(,l@&29<!g@iEOd
::QE|n_x^CDE%0*zC-@yAw.%zVl=7;/1o$x[EzZ`awGhIl#_s\TZl{>=wWs#G4_ZtVuK|ZuPolG1s`;&cuU4#y#)Q1Cp[y&gY5{QL[B>gG@vUHK]paPnLeMHSBNk(lp3
::>C^cEnQ@nDRD9W@;SL|v+(a+dO~`5+jA5U!hW|u[(ojnvsqXwQ>WCZ/EL&MSx<AW3``UX{mk`1YqzI)-,j$1DQ|3I(xdWw[4Tp*H0Lk~K2\n&evTqcpH]G\*P1|9pV
::RGL&3eW9k-u0}#u!YVsUt*<Vo4`fhwm]@B5o5+m|O9beY\{$mJJ~?GU.J`H[1F(nvH/PIh%[Z-lb>,#H2{Un!).mV1,ic[\0fK<7Ej2O)^qkO7g!$eboN)mP3wqg|_
::?NZaXRIVh6r3VP?X$CnOC>l3)9|zo~Y6)5GD`M@snqbTvJb64myL7Cb#8i/?X}bjJXR*N>}Q/=RK=aXGU}Yt-lcTmhwYM/_&AF8Y94e|0$kpe{$a/un!goq?z2]Fm@
::xE^jd,$8a,/}`)&G;_E8ohh2>X*Nnw_NXJv8wm9*n{GA(B@w^GHI\gAUH$51*N}|nkBj[;45~w!B5o)`6oc(S+zI8<l]>l?}XrHxHE]+8zo`/&Rq\+R,GktI#>VbEd
::I^-Y05w7/wv>aW`<};Szx4,Hi8zOL8lj!^F//(;TIo>8[}UkJ,;(E]?3!ZME75]eLhYi]Y7P{A%~PVE~y2!;?MW-luVIx.yw6>xW)?SYO|?OPfp[2wY/c44GbjAB~c
::qN8pP-sQF>uP)p6
:bat2file:]
```

## Intuitive multiple files support with low overhead - must use the same key for all - to be revised for 6.0+
_A single decoding block that needs to be placed before the file data. By default batch script decodes all bundled files in one go, but it can be split into individual files anywhere in the script:_  
`set "0=%~f0"&powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 2`  
`...`  
`set "0=%~f0"&powershell -nop -c cd -li(Split-Path $env:0);$f=[IO.File]::ReadAllText($env:0)-split':bat2file\:.*';iex($f[1]); X 4`  
_where `X 2;` calls the decoding block to extract the 2nd file data, while `X 4;` - the 4th_  
