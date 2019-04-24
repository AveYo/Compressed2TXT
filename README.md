# Compressed 2 TXT (formerly File2Batch / res2batch)  
Windows 7 support ( PowerShell 2.0 / C# 2.0 )  
Very fast encoding and decoding BAT85 class  
Multiple file(s) and folder(s) "Send to" selection  
Optional line split and prefix  

## What's new in 5.1:  
- using $ instead of \* so that the encoded text cannot contain /\* or \*/ and break host script  

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
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$&()+,-./;=?@[]^_{|}~
```
Encoded example of this release (with batch parameters `set/a USE_LINES=1` and `set/a USE_PREFIX=1`):  
```bat
@echo off & pushd %~dp0
powershell -noprofile -c "$f=[io.file]::ReadAllText('%~f0') -split ':bat2file\:.*';iex ($f[1]);X 1;X 2;X 3;X 4;"
exit/b

:bat2file: Compressed2TXT v5.1
Add-Type -Language CSharp -TypeDefinition @"
 using System.IO; public class BAT85{ public static void Decode(string tmp, string s) { MemoryStream ms=new MemoryStream(); n=0;
 byte[] b85=new byte[255]; string a85="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$&()+,-./;=?@[]^_{|}~";
 int[] p85={52200625,614125,7225,85,1}; for(byte i=0;i<85;i++){b85[(byte)a85[i]]=i;} bool k=false;int p=0; foreach(char c in s){
 switch(c){ case'\0':case'\n':case'\r':case'\b':case'\t':case'\xA0':case' ':case':': k=false;break; default: k=true;break; }
 if(k){ n+= b85[(byte)c] * p85[p++]; if(p == 5){ ms.Write(n4b(), 0, 4); n=0; p=0; } } }         if(p>0){ for(int i=0;i<5-p;i++){
 n += 84 * p85[p+i]; } ms.Write(n4b(), 0, p-1); } File.WriteAllBytes(tmp, ms.ToArray()); ms.SetLength(0); }
 private static byte[] n4b(){ return new byte[4]{(byte)(n>>24),(byte)(n>>16),(byte)(n>>8),(byte)n}; } private static long n=0; }
"@; function X([int]$r=1){ $tmp="$r._"; echo "`n$r.."; [BAT85]::Decode($tmp, $f[$r+1]); expand -R $tmp -F:* .; del $tmp -force }

:bat2file: ~
::O/bZg00000fdBvi00000EC2ui000000|5a50RR9100000O8[_?0RRIP82|tP00000005XyWmEtFE[x@UVRUqIX;~JBWpe/UuvCsN02u(VfPjqvFpvQZ0000D00001
::0000gAarGTbUk5pbZ.p_Dj/QVY(~OgY.SA#00
:bat2file: LICENSE~
::O/bZg000002m=5B00000EC2ui000000|5a50RR9100000L/wH+0RRIPM-5+?00000005XyWmEtFOi4pUPE$nylS^4ayaGoATY!L#01$FS00093H8KDI4n-h~JnaNL
::mY[PjP5[jJ-~(DV&{K9}(l(WU[+c&p|E2&_5Uc;IGXOwE1OQG[/Uv/Yg|nJ@44f]zf&PkjM@}=JeUmGal.ZU(ZjuaUlr4rV|0n;d|NjvB00000002NV]B~ul.|sxX
::faQXM0q#73WE,)Dy|[o=fP@O-zHjy^H6U1fZyuK@1;r#vKDtOv-AjzZ-aXW]Fj!3uSMb|@25__;F/;5{4^I|r/rf6w!C-SoBoAZ41F5(7uE2C|WXAeHv2};V3tlME
::g?VsGUJS7l70lgB6tw@)b(^O.l^WA~G4.my+=Wj|yHF8j-Y$1UUf^rkr0)gPeIQ~qKs;VP-Ra4027QvqNv|P+?Cp&gbn^pH)yoV=RujSa;;Pauk|HlyVt^?T9wui_
::eDdbp#)1dt;!mx/FN@LZqWix2J78rIxf3_]?E,Rs9H,+,x?mCN2iVm-#Naj]h4sTO$~ok+@~sCLBTLTWJ.O~3_1@?h#e38qY{MsKd&J}H+ZELzdt{KP2P)$77e2Iz
::zse!hK^D!m1PRG9K3#s[cCj/.duEE8T{OXVrb,X!w46.fxKYGZxS!d&Zkjq4r8GAe5JB7n)pMS11/;gn&^45L9MTHCE=/$#RRnX2Y?H!p)G7+Xe}UujjKdv-96E1,
::C=}8xP_fsjJr^AhWT?@AVsSHir6V9)t3HBF-P6||wPoaudh{WqwP!1hh#;ZO!#uWt7T=MT7(hd{N;C0zsjjO+w=^Lsqn+FXq6x4cSGL=vWDACNk)J)3r/$M]Z$ufM
::IgLG_qkcw6dwdinRrnc}(Q7IbYFsxHay9qu/($rtkZSfymlkMNn_XAMXB9aTIjs}]$lIeD|30RY]n/{OroY}OH{YY]AM60z
:bat2file: Compressed 2 TXT~
::O/bZg00000qY3~300000EC2ui000000|5a50RR9100000Q2-n{0RRIPAsPSx00000005XyWmEtFLvL-xa&FRKWn?]SAXHdXE[EMH0KKAhtV#-Y8e4#XjR6o8q5uFx
::1UDi80DomWlQ)nE@ZMK371q{.3{6=SjBlC.e?RK29o0#~S}noVvf}{niT@W#HUI#T8Gxb#0J,c/gb0Lygil6jz$QTOmsT6,(}Xo-XskWnq?Ia(.T4N+Q82r@kN$66
::,;;dTwiKqK@KWdJu5Y^)3o9XrDF_-LTK[On|3Uiz0001z0RSQg8t!)u=7^x!jv!H[gp[#BNrIk;68}HJ{~[$7#Vuf;)|}1H/vxVTjWjNwOYpvqmjuXl$r=XGL6sY,
::&?tWvrNCm{(n7[Ti5wMdt!~kf-z[YVg),lW&oi[+h7[$pIV1^|5AK2uNC4}k&0Q2]zasW&8Qb7#wVb.1o78B3VbCkIP[9@;qWDK&l)Z;I5XMk27~gJzCHaM(?]!]E
::)D$-t/[lPkG-^360!hq0M$U!HqD8sN(7Us5Z)OZ|f|{=Z,2w8i4QluQK=2f}icnd.{d[q^D~}j#izuNw.zyN6RRaZ0HYk~$q_[VerDv3zlu(|o2~tPWbGq1qObgT,
::fn?idghH6#jv21kC!|G(AzD2CFXREr6KFpQSd&nf!=jMbIlwyio4Z5iIs;R)u|EEJHG?emdS!_^C@!}If60tY?go7w+D+]@YXW?4rB(~6B4u6ZBd,|XjhssZXBVV&
::xRlRsM0qL1+;W+bWvO0Hk8.Bn1A[s6^B+$(F2iao+RyLex+l&wIT0O5E=^i)MZjtSus8V?hpH|fa-4MV2&+z&4CJK9D^OWmlhhT.DagSJ=y2)7K$Pn|$akTo)2+q$
::8EwVBUHw2OYeh$xX+zaGc?Sef.]nWFIsUjEb7ns4-(wSLq]K@Q6r?V|4)^+=W!mr$z;s.ym4av+GDdg#S7j65y_qE2_c61NQwMi!0bXR~?Q+0gRHJ5GNsFq6GFLLA
::LfeLe7|TY5I-rh3MG,FZew.!l[Qx#E&]uas/e5L0RW!U72Mbdms/Se$h--XAH}mEB-5m9+kYv/!mQ@N.tdLNgJGSK5,^7)7^p4M6J{vO4)P(ObJVwgv0hFQ/quy&?
::lc~Vb21;-et^d?E]6wUqdrl)6Ik$zoJat$m4/K$xyD3dfvExsu4+cdc;[?)z-lWWmEhM@s+2HQ1S$BB67Co!xCmN_9j@AJl9G1RJv(n3xERfYS{G/b^MQ|pZibfdR
::,qunCBBLl2E^4AEvfZVV&=W,RKT;9M;v-Yp&,079qrwDTi+BX8GKl8}su2_;W6T1^SU+(vi0JtYH+b}{a#I^AMRo]a;n&p(Ju[#th6fqPX$3h#Mg?{TSH&&d=rw55
::Ck_UE^oE;m=,^)AlnDo[sck9l@T2R|s0nWhqS0CL?fW,=,5+9|&&3^56to9-UPDVsO~X.HWC=|$kH0ukZr3|;q${Jg9bR@^gDdrC1UmnElv2yVtd7e4V}b+g_6lw8
::le,@J!BYC0;Q;j9f@I1lt(o{dsR^z}RHbzA4A5xvaINbL(YR[,tQW[kW_)&&NnIcK231Lrj|RTe&w8jo?}Xu__}wl0a{@I.(d-m$Y35sdeq4Ht8Lg=[dwC&{/K9h/
::uZ&(daVsG4tld&zVQ}F[NWUnrbiUuB6PXBQR|_&-bBp)HMB5+lJ,co1&;#9zUfZTVKt=A~a4#W;NSssBrxs@LW8^0_v7uvQ=+g[jnG/!iZGQj(wuUWe&@1}8ASpc^
::#vjL!&-4|)^f8f?Ms+O]l2YwyTK;5aB?_rxJktip2[;D+dtt2&-U9WB=aYlP4_V!?mf76]E)GI5q}2v#li-oXtq8bHsuNB?paZSd&9&Hw!vrI&Ao8{L&NZM!eXK1u
::&UhGTZ}(I)JlV;m?AMfrLf]J.[4YBR5AGyqGU/yKiMvzqsJF79rnN]]HJ+{|o-VqUCZt[zs;GDX8z]me?8d-Y.zT|x&wc)Bz4Pc|w4z|SD+j}&N+!&QmlUs/FlZI@
::?@54)E3Q_{Tm^ru&K~.^&j{}@SG~Mil&4KW^/j;aZlnSEBLk&k081]aTGiJos$pWXbY8gvNi6JNUX^gi4e72-.5?Z;z]Ab}#p7Yfod~OM)4{bJ.r3hBrNS.}oo|,#
::DT0jpj|$NI0J|&~N4U{TjQ.#Hg=L|@a./[avZsM0kd/.+mlY?|Bez$&,~t0JP2DYXo/2s)c#H?E$7_6n_8$,0uW/sKK36N!hXn=LLGo/1W7P3rxQPiNKE5!@@#0=h
::{BSxa/f[A^w0_k_v0}&5,2HrDu0.e8tCg~/^4jtARf~(dz|SA(ow_IgBnPJB]u2f=_Tih?g?GwA4pol6T0p(5)d{b24UYeZF._(wOfbL}z~J2/;|yG6$XQfsQk5mN
::a_&4ef_dfU4h!&=zoNbS$Ah&7TH$Rda|X_#z5~U4+PXkuuMu-tx{zO+Ygf]xkHY4/r;Ew6qkA]eH)=[KEL_h#2_hZ,v=?jX8Y|l/fLU5?fLOKxyW.UrAMmZvnm.sp
::wlvMmdLrvT&u5U)F94nR6nZ!ql2UgfUBHxYi6703M1f?^O,6xB1wd#vmb$JoVTdf0_P1q|n}nLDUeF.&4M?R){Mv3[YOy])4@xI;R20&Hzze=rI9PTUzYAbISMeNO
::9t@#bUEOJA+px92!Vn#D_I8+YmH!#/42X1$Y{E0mPp(QnyES|lVi5ZX=SPOnlm-M0np;qnF23&(s.P;/2wq?eDy1O$8qxmrL]Bn}B7qayIc$Kv{@7+/,NqwnFDQlf
::#Oc/49_eSCbw_uCxvKf8tOgkLk7oxXo06,SGx6u}z+iJ]AbVI=8Q2D}H)_0pRv@/Y^WT=50GW7Wr;e1-qw{uH-dVZ${,paY+!yX|N,IaKI!z/sEG;+cpZ4kI#y.C1
::WoiDFyq2)k#$Tn!uAVdSS;nB(]coxs{.Q.(Ubp~!P2fYBWHXCi&JpR@)!D2+)vsKB(7S|!Z+pqc#7(Z[C{Gz^Gn^.TS]ZL.dHLiFiOUl+]Jwrn{gr=6[?63]+DcGi
::]q(xBcYVf,ZB_g}HYNUvu8sId7m7nl1XO5&K!q5^lrG@4(MUpXAzzUX^K+[ySbi8R(@]Bl4^cLBzG|=?,2dMX2#_;2BTh@M06-c{QO/K7/^(~~@l&4PYNrjEqNOxW
::uKkJfL@)J;Qxl-.{+o#2PnwQVL!ci{j@jpCa4.Fz(MI?!B7G)[1DSh9QxFO8iNs!4$HDK];;ggVZI)kN3UO3Yi-{;A?[p}sSQ89A?_c(?e1JBqWF2B3eI3QZpuX?7
::NuX(wpERXFRKWU?!=WrD=$g_&VB/Wn{NDRFNFoHACQUC;ni/Ur8v/czjSdG(YmZsRlb_#!q,IiA]+jWFslKXybnF]qoB/BnkBdFmFYaj-NB/|)#+EhpZ)}~CNzHt+
::M+-OMHhF&trV]$fu.L0CFXZi0eE[U
:bat2file: README~
::O/bZg00000015yA00000EC2ui000000|5a50RR9100000MgRZ-0RRIPHWmN@00000005Xy^EjJNQbj?TO-^wkWB@ORyN;F6HWpiefQ;nVWMcpTLj,P=000kVJJUCF
::(/63MU^n$h2w9u41{s[n1ED&a03E8)EY/gqsLdP@f6wvXfUp1njm!WP0RU!0$qo_|flvZ52nLt|GZ2AnCCinw-$96H,5&5^XUS}|xTiP8n7g}ECT.?J^l@Ce$~j!+
::9XBeob#r,wh,z9JOBVnC|Njv900000F&bfTZ=l.t,3VRmXjIHA!dwvZ^zJ(A@BAdohiyZ239({bQlM1]fb6i1.R|uO)96YbB66smG.U#{a$rlD96kV$zxr}h&^z4=
::8zd3{g77j7kc?c9^Isi?aybHPVou$gt5@tSgUp,v$za4Tpczf=a0^V$+IeKLui8vy4Xl;N]Mt8}lH)wSOz?k]B^kgu-n&@UP-W-KM4aeQNq{ub=&sVxtfCl?/TbkL
::L84&!bEP!ys&Dns@U)COda|uRP(ttBiQ5()K--sK;M.+rmYKVuyNF(xH+Sy;w4}{|4FB@KFFQ0-6L1B|9nR)aV1^8AgG(sfP_5+r$7~HX[@d;8SrT!ykqnB-LKcCb
::fr@9QjnN?ztPX&;wqw8&5rR7bh;TunjY4gSPms(N4@KkjdC@S8cdI1-a.+(.L}8rtlM]9p{PBdg#&T2r5/2K[Jkkc1;CBCC3!!!qpW.[1{=_zXI!JH-[5Ip=78V&[
::#vDY6!?+rr+I6.eRd;#Z@MNs}R+S3@,!!X,GU?PTj]/3&Q)=8A^A&VWEm+{CyN1sT={d~-pW+9T1zE?&2f0DT7SCo{2u;Nq0Ig)pIa|N7lC~&EVwtp(gLcm|eoDxK
::Bj@TwKCQW|MFRSk@^Dqcb74fl!8~&2z}.ouv.0/Ak;c_Q+O0H)i5N@obE?w2=S?y@xv~n2&G$l!MZFD6ie)7$FQ?6X9Ia9},eM/=Gn6}$tYU;FF^t-RId+Q1eJ?pO
::7V#cv{BUV=9;U3o{6/[llj3nJaRVKQvilx/9Y;?eWYDH4Tu,2OLV|(FE=UZ8y)mq$3B|d-,.5vKoPz60RhxS8,v?BjIYt1tk-sYPu$c0_3@^r#?MXunI9w#=-8d{1
::ITs4_R^_HY+TyN[uT.#K,rwXAsqJmpzx-|Le+dh)/#RY-,6n4n=3Q&U.TZ9OMcT1#7sugtq01wOHqJa{x3-t[{pVI~TCXLIA{~=ZT_l)Y7M5~f=gxi5{=8v-1SOC+
::A1_Qzkn9@zWpaN=E{7h_q,Clb/uaDWLhEF3g2B5}nmWUcD-XGWn_30jHicCecKk7uHo-Q#/lbr3O?1)Tw?HgMQscoBXk?{ysrv@FY=@C10IgPwb=jkU#f3{(Ru;Eq
::;y9&W+PY8HWOGUMjtg$/WQnOF+#bp7+U_!RfGyCBC|F3cytX)BHwCwJmTEepfrXijpPa=X_zYaa7J$pj@FFS/;CuMhV[P?7tS[7[b}(6aPm?rjx.dO6CZ=X3D$si|
::BP,)++-)jOX_XlY.5FfW82dZ67JPBof@6+09F3w2DU_-3t/f)zm6+qp.cEtBKm/8+xDqX4pYWI=4CXqy#M8!?P;MjWyqx1WDizt+^bnf$A|Bz+6lIP/P$@q8;@fYQ
::);#pDCjCOa9Hn3vfv3Nwe5gRTj,_YBJ_~wS7)qH3mo&L|vWEwf1/VnjDqPdoqdx;=(4qG;i&1V+V}1)s(m=p#bNIRvvIrba2{Ch,FUTVJO;sx?C3?Hq[fzdZ!aFXn
::_xg(^EYZfgvrkurb^bwAl/#TgcRiGxq&UlO#ElIuxJE&4Bkk9eElEUR({[kF0AjPaT~@sV;rYN+F|sq2S(u0X?hI0Jnhbtl;45l2InC0QB!]CKv=V.#Vh9Kfre2Iy
::7L[kwC]f2tauVV!^HWhvtnG;B,hlAtAuGGr8-HuS/=3Z2QWec0kIM0YadOEZ47TmW^GdBRb4_~ptT!^.DH4[cOwZ$y^Uu)]MjjLp@_xY{#[7jb)m1qv[+q;^MMRdg
::[E8eiUT@yVYe8Er&C(;bjH~2A[K4dK-7{F(gH{M}c306E3e)5EUd[w6MFt,~+^_1O28~,}g5GU#$hv~_{ObF2pd4UxyDyR0){#?zg;}P4^4F_IRHJRwZkXX1_)0nU
::i=Q.5B6(BJ2h_b9C)0Mc9^g5+ppUJ2Sqo#5&^cN?r4jPPW+@JBq/VLwCqbhr!oXZkKpG;+QsWQh]Sf?+AShmK_}TpfBVOH8F}w?W.b^@SwP8=]M}=]l9ygAY)B-$z
::GY.f1N-CZ(+(c[5c)p&hmV;4N!sZI6+e~7d]Jn!B4?@-@)~5x=T3?x,t,V~(HctnU-JK_.;T}~w/J8;WD_,TW#}wCv#}jGP.k-;IxU{Qi)gS{fqM.Xv$q.T+5C|Zz
::/YH/D),XQIr0QyY0=~Gx8iSJ~@hN9$8fU$8jpv8oT#{L(V3$@XsdWX@@u4mIZK6d?pn=c2r[Qh~8q2A1DO9zB@7jSudYM3,bK(y6jeSbpzV~pz#;iAFIzBCC.rei(
::.vJjelqYwWyJT+qKpg?VBmkr4GVv4c{|e?[M(AiSdh{AFz4g2i9~1eEIM9}H_Ik)cAq?Ah|5-p_lbz]$Ig|(x9E^[/17c6^!9Oe&r(=4a[&PkY#&89jQuOqJ6!-;@
::E;cYytlU{I]-s2JmEU/fz?9=phq0F4L?s50?V.+a?+.$BUd.5.[!$7{4IH#@XAX+A@?HpyemPQahm^C#X&F,L,d3?Dt]s9wV4uVBSa9EVsB_U(HZM3NAN1CYQO{jL
::zv8Zhyhl8tw-RTjO5Tt}0sYysls]Kh;zH~Ek|}dv7E[Mv9jmvo[~PQnV}r_E2l9hQnYbD.)f2G}(VjQr2W{n?J|Z^?K?BttOu|oKT,dApeU}84y)jm;$-R5+7ZH6l
::a~dTf[6i!BKiqv7C[1DBdRx3/3bBOju^9u3#4^GorbYcyz(ek5n{45PBif3E]$$mRSl9(aB)~^|FqDssXXL8&WV2sFK{U=B?R|iZ{T0Y6]+GlKvtZ1pdm30qj)F&w
::-avecxX6/I]HU0Vq#3(nE6)L7Pz5L1@avDAj~8bBAT/[fnN3h3Md~X4NDBT@{73YOlO(J^2b3lKH.1pyUV@/&zPIrlAFuuVXxV=_3qp@A4-_tUx}jnelx6l&c4Hr)
::w|G7qW6Ppn(d_Ou|0f5-=D2+Mv,CZoyg?!?Mj~IN#Qb]@AX=EMcPi/sP-H]w7;BYff^xH~oml{Y
```

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
  private static string a85="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$&()+,-./;=?@[]^_{|}~";
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
