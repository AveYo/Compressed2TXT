@set @v=3.2 /*&echo off &set tool=FILE2BACH
title %tool% v%@v:~0,-3% [%~f0]
set "res=File2Batch~"
pushd %~dp0 &cscript.exe //nologo //e:JScript "%~f0" "%res%"
echo. &expand.exe -R "%res%" -F:* . &del /f /q "%res%"
echo. &pause &title %comspec% &exit/b
:res85_decoder */
var fn=WSH.Arguments(0); WSH.Echo("FILE2BACH v"+@v+": res85 decoding "+fn+" ..."); var res="\
::O}bZg00000sR.f700000EC2ui000000!5a50RR9100000O8*$(0RRIPpArB700000005dy}#%l9MrmwiGD2Z]V$wg7VRQh6r?^E{2;i.LfPjqw5cDYk07C(eA^{pnW\
::jEJ[Gx=,TvsP5H+=KS%y*HWW5_-!FpxjBDF4aaBX=Sjbh~ESJ%aJNl03,O1Mg#}(P)i[Sl7YX0B(Vw)iL_[j00}gHWZ6D}1Cw{YyZuJ2;beZ?SaoaNy$C9F]5=VeYF\
::e4eX0KDYZHZ}Vf=%dtNdNxtzYu*$0000PAp+p{m~Gx9y.TERo,dtx0gw=w)`qOK)FJF()W1{9uGADZrg_C04}0+[xX;|Bbp5)jW.jFg8r;0s${%)Yqv[U$;UJlnZff\
::[LwLwuSWI{+[cP!F*j9yQq3TwhlV]|0gKZk^9(c]b~vF?m?3OqK*]Qs{85}{`,]Ja)F.3D700tYOLyk)gf{C;x{iY9O]xG*kmfCn)oA1odb0^q]s%=Gxv_!qHL9bIE\
::sU12P5D^AmGc^RC4*5v,#g^_)cNdRGi7tO#pRuEU=,?rJz0dguHfq{0eju]T]H`WNc,7I08.}u6R8R(mX]?}AVPK2p|$=j=_lTCZB01.Dj=Ik]}0V_P,eoxEVdEUPj\
::MsvxQC?g*Z(}6sEZuN1*4Fr,df,|?ahJ7fC?vjQN2C2_mXIAgUC21F6CXXmY5v7PHD(%+PL43d[8va5IE]FZOV2I(ziDnPOVl+lR#.9-.qh%UXuCO}f.iB_IQ#x^c5\
::Gg0A+3XdTDk_MSf0_rV#H2OD_r^UtKT*Fvp6^T(8pd;;[G%GcZk8hmte3r~{1?,p_[f}CkrM9f-uc02KTSnYw!hfgW6K5lmVz7KX%lR9x5z,dr077drwu14Id1PEU%\
::G0R[li+?_.UXl_-8Pa%nkZLV+S|oVAOq.le3-4gLog[Q9[*9F$f[an-lDHkRS#_),YTo$]x+]VJ3d$Jb[~K4TpV]0aZ[hoUvxK-[nrd48?Sh[jgQH,JvHVT]0I~slP\
::Pl]7(K^JOK{,.9AbOV_5LZr24Xp3|y.T7jpjz+}#(`w9F.SXB!uJQ^[Ti71u=^W3U+#+{2pLI6j8JkQjFvaJ!a%9VD+10.0x$eYS%4OIb,3ZA6oF,WALTg=R~DBKTs\
::6L9$xl;eqO_Ja)tGJRgV`.*Ol?S}kD=a;!|sT|DsI^7~dfvSr#jRAeM4E^*lY6s-!bg|f]$4JZCAR0B0`Vbgnq4kAU5X7ZM|FommwD}aw?t-7~mXQ%QvW%QP8FKoF)\
::h1AG(I3;z`Et6LDRJH8tQ(1X{Yw}t0^Kqt2ygFmvk;7k%ogF)e[r(J}2P-NS]6JZ;QEN}*$!hEd_}cI3suNWh=m1L^6dCJi5g0{a$JjeS(UEebazUAkP%EWc+AcV-n\
::{!X][A_XC,,icrit1Jq#Wkb~rojcVn8K`^.il^QT1Sw]qQSL=s4wy`jH{J,)2POXOr,^uW^BhWoYU)sh?R`wNR8xQ[+Z0+oLMB?mn0Xv8Rx07XsmJt8IJV+Caz^B?s\
::0Z4VEUp[ZQ(bP2jO=0pd?^*oc_.jD}D0N#Nh)7X~xNtvzv}{f6rnHk!1ITQi%3ipOf}3+)tGkzW,5{|t3NMP%RlkH-8e+c}]TV.,O#t.AAhQ0Gw3_}0%-BWEm_.qw.\
::]H_cGtdgoKU7RQo5*Ds4xyDS?tVKJ8Ya^6ZzL)CnSr?0#}?Ro.foVDM#GO_q7e3,)Tsk|xW%K)y;-o.rZWd5UdLb-$xCW}t37h[igabQZAHF?PqGN4q`5ys^Q!=-Re\
::Ou0fAa;-tV8e#LjUZQAn1Rllo38qtW+K?ek~f]qWxBXK?aKn|Fwq-jy7AP2-)L!)E!sAH]T0QGu5^D2H+moo=}pl2ww=q1-F%8$kvn?A.]Yul,P)gl{!J5$o*RrcM!\
::!F?,}jJRuiAB#w_k8tW[c-x9ZRXuGEC,-ww}dFL9zV1Y$jeF~xi%opu(a.2xR4u{f[+v8rrv2ij-EO#|y^6m1RxgePk7`5xauewRLp3nQVsHwRU2NZ0Yc{+3hKYH[s\
::bAV2x4(eQS+Gg4E|Fb]6;hY0p]MzE3k(VXlPdgxFd%4XxYUBXDX6(BVWf+s*6#un8r_NcVC,G?wh_{{yMs~%=Rr%fYy-!%*ljVpc=Tw[J%KESuPQoZbM+fDx;%y4LR\
::jjo5}dJpRvO}}^BcG]$6X=yE9rn]i90AI_dkb9YQU!eLW)]IRMb*mW{,*vjcVub*1(IgC$OfT[q%z,h!*fryP7`QQ[YMNUwa(q$-;{,B,}J!!9)wNnDSe6SC(kuIU6\
::IhzgW`iO2c+`V3rkdMw_vojK-]gmz_~F!35.!DY{=LI6GgTr~X)B+^=Un,0.L`1CY4gIPaT7-b_?wZP)$_oTn[^td}up.j*C#zwLMWT4G)x26CI{w9`tFwBKK^Ey%a\
::k{KBt!jC=Qe09Q);=eA43AbC[m%6g_*,UYlTRRPGqr[7hkJf9`OCaz*s|rHqT?Clc,%.5TA]q3G(O5]m.Y[-G6SaPW%t8yYuB(!U*C%(wsEM[P$#BI2o]cUzVn,oyY\
::4*(pD8SAzIDe6X1P-Rdry3Z1H{Aid3m)+~l*IzH5GlIH~pXQn7ivHd.ddQttB3{O~O,ER!O-aq3Y155N{k5he,#bL;6,o8dba;].(6}F.VNw+Y;1YC0Bh!91uIuKrI\
::7Ejl!4lPQ4X^gay!60Y|.{BW$01uWQKv`Dbsy%IHWkFyv8oi(AtYDxo2OYWoLa*jJm(HZyIwvUrNI^]W~aa*-~E}[N=mbXU}%1*#5-$5Vt|d|cHdCf%AnV}}mU}o00\
".replace(/[\\:\s]/gm,""); r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(/.{1,5}/g);
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close(); 
