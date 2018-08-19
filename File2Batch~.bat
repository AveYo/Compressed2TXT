@set @v=3.3 /*&echo off &set tool=FILE2BATCH
title %tool% v%@v:~0,-3% [%~f0]
set "res=File2Batch~"
pushd %~dp0 &cscript.exe //nologo //e:JScript "%~f0" "%res%"
echo. &expand.exe -R "%res%" -F:* . &del /f /q "%res%"
echo. &pause &title %comspec% &exit/b
:res85_decoder */
var fn=WSH.Arguments(0); WSH.Echo("FILE2BATCH v"+@v+": res85 decoding "+fn+" ..."); var res="\
::O}bZg00000od^H$00000EC2ui000000!5a50RR9100000O8*$(0RRIPS$q=N00000000wB*qr+?MrmwiGD2Z]V$wg7VRQh2oU!882wD[bfPjqw5Tzvm07C(eA^{pnW\
::Y^d4fijCll~iqpg.E4#B,I)fa2sH5vWAPbP_*mewSl7V0QmPH{T_k2GXO(g0CG^W4NA~~}DIdu0(4Dri5Z`QzXI8!-|b67-TRL}k=RVxyWOL;ux.CR.~qQ)vavhN6i\
::,+0z02YQ6JQD(g?`LR#s6uJAOHZU0H9$z3iW;It0Gv8vkXMD%U2`P!2MxFh-PBsk3~ueD5Ip|GT%0pJyBpJ}yq7l,QAfYm9%UZ7V,eZ5hfRF0G89`fgRE6g]^JDDUb\
::?4;kF#!($V%-%6lIaq^WHjrk!MN=?4(mG#!ECu?R}aBsot4(]cfid!.Y+y2S7$5CS4Bj]Kk?jNL!p8H?[GdblPONgE[%9Yv4EGD3J8Ko=`WEcm;=0yXk]jbL*c_ZQ$\
::bO~2g`WPaY_u*H68Esse6VTBjW,2v!C7t#;E2R}Hn0lP~Rkj3z!-e5%Oa1V`*1_l.Q1Dt2W[CM*AjU,$^Q}%e!X^BND)Va=LDaS`mE=sICbb_yPfA-?[uFg_7VjGU{\
::f{TGM|OX(eUY;x?Gdt-Cfzoy=I?dx`CJiIP0Fanb]KGh4.fEWb|XcuW5^yO`s+DETS;^_v1Q3dgzZr.)FI=0-NE2[#B`syOG{`tQRfKLV]Ie5R=khh4O))I^.sUd+I\
::SdAl;1ZtETU#?DBP%MXsg9uj7cx*9Q]O(AWALqb#2Z*`4RXbS+shz?x_DA_J9IYy|^!oEekb$4oeUQ+n|BoA$U!!R=EjX4E1jROhL6(?U}rK!IeFu=qB#zh}+V?;-n\
::5-VJU]EyqgLS%)CKaxZMvzx_cXI}gw[p*JoNw`gHV1VCDlT;}Udx9P;](CPMn*IuzDCA=5dcjU6w]H0NB*RaB3(XtVtJkXX|?_ESd}UG6+vqm$t1HoOZe0R6qJ.^Mo\
::U;9e*VO};yS`1WGnxuH!JcBaqh*nalk]QL#E#zFsX_Iv44~=Hj(e$Hkgr;vl3+)YZDFta9,,VQ!4?-IfsV1q[M*mzH%Hq?WP+X0R[tQWBYIMup8A5U$]UAqn5KBEZM\
::0-xl02iL{|FBd,S;ttGGQSe.pnjSY,1r4^P,ziWq*ymxn*0Uh%S?hZTB)K6ixSKHzL]h.2#Ox]f?ZxlL{lslSdn^.p1R`NF#byHdcqwzUW4p=7W9eJHhMyotfBX}8W\
::;lUSCHjk,wB#{cShwWb99]|}~bKBz3ne~1uZ29CU-vr{[aI7!0Aq6[H?%,th8y3zye[+GvKHHNwpq2wFZo?lyV|m~#LrCJ}^8~86+*8B|2~Ia*d;vDqz|f-M?,$22D\
::sq2dj57QvxMsc1R5x+MGxYV=SQJE9,p`+6#J1z1Rmc1U?QxH`TSn-iL#dP_GB0H8R|D*AL!m=J*rGwj0-bY%apk`)+0ZyINR-u#6bx4TZ[(SIdns-37hH_tFVm+DlL\
::!Ow]4bFVj3[TP7e}OO)7wBsC;Sn0M;TE!V`B7g$0$muL4{-GlUS5^pJ[%0c]8_$D=yHZ]?Jq|s[DB*?9s|sY).$epy$d_Edh(%*e^x]*Nqeyij8-z5}}hpLKBv**[t\
::}2AJrFKNVF.+7acwER{x+$=cc|sX%3H|PvobHM*,+IbA|kG*([tRTbfpgHY2OfhLy2Ab6Th?[C9aDBrOSJ9I5$~J7h8uHI*`e%daT%(?G}`QJ-(14QU(hJ(I=2uAZI\
::?CFNmP7mgZ{ydx)D?A)IK4pj1wF,E.]r?]~gJ#|R[N|3QhI^w}8#o9{XnB9ZFuT`kXE}EGbn_q+1ov{YcFvL+$-iZn%UE){Sb5?bTZ-g!ERs6SG57zRnGvKam#[aan\
::KEkp4}n6}pRxz$[|uJtfh![yVwyIO%He6rbT=z|4R|)qqps_)oEFH,*C{NJpZAHKS]{C5h$n,AB]vT+%S_{Qr7^#gf7KT;v(%dFDTC52_ab3LLP5]3K9083!W}8Cox\
::ByW;s#{l75)BUAf7Sg_F{C[VAog1f*pWo[H!;uLd45=9zY.^4]Z^2M33eec(sJB%^)Fcsf`{dW+EP-=a(9G;TeMG=|w%;1gJdRdTsU#;E(4K-)^S;3lh(=uZZjuwji\
::vsxEw[2y]t_)5*v7cC[=c[]It-5jkW.Hz+tEs#ocFb.mzrHVm%Si88J2Fr)t2$~W9-Qp=%%alxd*x{A.eFS]SlThX850d4JqT)2mh5+Au?$_^?V`1^Dh*_rW$_1*n2\
::{-3C^h88fj%g!M(UxXn^]Tv#msC*s#2%L4yuQSh|puBA-HR1i;9J[9}ImkmId})Zp[^=ex`Oc9?6;FO#%{#c6Ed=c1bbHpxA0wnuVoi3B%=wm5m8c0,QTD2N57Fu1d\
::EU=rYt3?bOEP[esl0$~6]Q2u!s11Gh%hvUb|Px~LgiI`(FW(ZC[ko*A|H~Vvy,%FWPZRU{h5v%i.f_x+FeWy;73yr[93Hxb,7.cLq}49rUOKHrMpr,#wW11O-(FH1k\
::GMWra=G,9i$6h|IazJ-A-60KSvL,S[DK)W^nBV_B|dWcT5*NMX$T?10E85)uS{p7VH5s(!YoVlD?H|(k2bOf]#t3!#vLe_#mXg{nNS1YV-9#`3T%KMC6V-z9?[iFqJ\
::yj$[1?_4nnt2=e6e-.m{N(7ty*jssY=pfM0)8GET#3J,GtJq~Qw~pggQ=Xr.4ToL=_tCJ)4N_FY8HMM={_8mKl,m(1HMm#hyO?x|Msy=N[iQM2m\
".replace(/[\\:\s]/gm,""); r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(/.{1,5}/g);
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close(); 
