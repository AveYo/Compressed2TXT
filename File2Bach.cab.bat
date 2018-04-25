@set @v=3 /*&echo off &title File2Bach
set "res=File2Bach.cab"
pushd %~dp0 &cscript.exe //nologo //e:JScript "%~f0" "%res%"
echo. &expand.exe -R "%res%" -F:* . &del /f /q "%res%"
echo. &pause &title %comspec% &exit/b
:res85_decoder */
var fn=WSH.Arguments(0); WSH.Echo("FILE2BACH v"+@v+": res85 decoding "+fn+" ..."); var res="\
::O}bZg00000t%T1C00000EC2ui000000!5a50RR9100000N-o{]0RRIPj1m9[00000005ax8nPe-MrmwiGD2ZvXf9;5bO7k;Y8%k;j1pUbfQ[nV.3;p-Lj=P]000kVH\
::$jkN%`px(E2(.=4hgVcQH=wyO^CV?}ZE8.t2VYswXq}je^2q(fUp1njm?WP835RU,SO-afNVe.#D7ZD=,Et]fZvGivM0TPOPrkD%YEg2}d0;x)TBc;]G9;rw,8PjI.\
::W81p6z2RNH7FLPXhn#!Nj9003ZMWG5!0-Kn2%0;{7IdEMzE[KcIBt{{{9#Zo%DKZv;`8tB^Io.6B}.0S]wcVgrbQEIo$3toH}r0HXgG)ss*!8Y`AR8^Y^u_JI[Zfo)\
::Pi,H2XW)P%e01wzo_?Wr2wh-j%LjyWt,3E7eoqOm[ExF!vZg}=uE[Pc;wC$QO;=mB|T#_NTvVx9yfQkp{5H-9-06qgmj05xe;Kqn3]k79J1g~C8lB8V}#-hB]Tcr`r\
::Tie^O~f-nPDuVMAzI+|gOr5!8AJwYWFV1+lwArlpakhh~xDmeO8kJJ9REaN}5%.l*~e1|b.8gH)+8+o^2KymXpAf0}SVPY9NI%!Lv,2m82T,!g4=Ct$0o9~|_PfA01\
::BsWIAZZZ5,gtp%%aH?6bD?pMIVCbK6IGR,fZ?!%(7W(#DMkJ5h0hc~Kv]l;HB2-d_n,7etoj240}oz$$4hAVzSYb-D%$4sS,vdL~cCHB;7yggsV}dt97#2jvK$l0S$\
::86[b(R_4~h^R!tzx_Q?X}iN{JPb_()tlk+sDxYsaNm;nsp23aT_AcnnIm^]$aD-KcT(G]Op3t?oKF}QPVHKROK$o=m;=dw#XA,{Bp,8v{k+Pe1*y{31fje?lQZ%EA6\
::vs_#|O|Zqx`M6D]jzd|Kk.-|6S92cwXU1kGau4y|saA#[shZ$25)=i!GK+n=6(DAY`.f$aL+(PR[-T57-SGj+BX*RL77`bP#_WX;^8REXNr9O6dd)h4=(%#y$mQKJe\
::lQ3obf8!7[d!JPBi%AWy+2Ea,|97hDRFKaw8OV$gxs?No1QB`J[eXdy!|}7k]7L3q=R#rv}AC#3~6f4Hk6tvwa)?Wt}y8=wUJ;MCbv3)Y#X|[fGMD%{O{L*h[RAv;E\
::^G},m%IGZ=o{*=7#hGeuBV7Qi*C`nmdS]]9zMb2z(A;EhU?H+!ylNWg|mPG,TkBJ[`?(h{{%s7FM{0*m()+Yh-d;g+B3_pP(#!Is~saYsd{WTim1`~,#?L(`i_bkay\
::2`Y!OZE!$0m3m~y-2~Rb=ndX)O2lfyK}Q}C1b#Vm_C%]ou78!qB)x2l9Y1(h9_770SZ]]2se;%byTwiNW1ck4j1~.qDy^r7Y2qkE8HJ(VT_N7^k5Odj6N=trVN.=$w\
::OVya8Zus=rd15-PH``P.wiYpeIVGnU.P9k[0zM;9=M*2_[GS)32P5MkAdi]1O5F{Md7RMys;noNMJ,[d~j2jE^9g6.3Hl6bq6_]WfM~b%+aEEfeZj}Ze+|IC8fajFU\
::EJQ[3BuKb(s(s$TwV#vD6*[LVJ,9#m)x?F;oB$=uXizQTaX;1Fs+BI?pSsT`R0NPWw0!sL*8l_ZqfD+s1iD?GBh4cyWb3(S3.w2U)Lv0nNEmxq_nE[li-UqP0u%H.F\
::,Lij|rsYAtYtH#xOzm5QM9rrc1M.9ma)u9jOJekt).GgrF]vs^5~?rLQQbRBx5h;CpH#rC!C0Xoa[{kDbDM2R+zw,$H4jizvLz6+4yxz*nE}*n.u]F=b7yjl-C=aXU\
::FEZ8gLz|DKoK3|P[D^!^U=~sKFZ[%eQ_baM*#n-(?QxbJ+[,Y9MQKUq+Fw-P{l0k`|uvCo$XF)TKWapenY%M^g%KJH6umlefU--9LwDNI?^5yDT|jAks0Tb=eO%0Yc\
::vSHNOHf]t-J+]g,ZM8eM{(vtp8!-BBKW`=lj`$2;cW]|,O!|V}4jmcZzis|*pIZ~~5V`KQxVNggYZcZd2.esl|1[{oKP)a8Z12A=2p64C{K5}#}.JE$)Lz*ph;k`Km\
::y1%2)1FxvmhohE;NU]R(f?xw%y%.sAxJ2(pgau$VpPwxCyW*=}Y8!x(A5c{74pDxp!g})+PcIIsk_t(W+`Nz*r2)bY]SQ5b[H.Ii4G;4C?=xi}^l(=j^L+YXY5LSx*\
::3a;p)WFrlgNRCA[aPi%womHvdLz9eYAz7a^xoP+*q5%V%Pr($Axo2(Zq6M]donmBN!*Z-8#%P8ky?acQ[]!IlR_2M1VHh(dT(k.`}oGhifWb2$}g?55oIDO24GDLR{\
::}$M.J_,hzZ|;fDiL;Bq8q[d}W+uP|)5K}~B]X)9C7ZS+,Ij!KXpM-.B*6a7^lNUYL0_[bF#QlCZY5I]uLc#d-^b9CpvEpH{=?]=o4mJb,g)+0hl#.WgFj=A3q0jFFs\
::s^L,,]eZEH5k)ASvAluDfutri$]oLg[$SZPk^a*{o81a*7jstM5.39jmi.-FCPa6jh?WgX]o.8XYd_#^2RxGIuU_U[e|JTD%?ZGX(y4ebF^N[)2,H$}tpT$zw$F1-K\
::L-g;0U|N0b_(JMZ6.PK7l(,1D];|sGq.GU3|+yRbS~kgtJlVSE.EU;7yI1!fq%m9juS3FI$[*Amf1WhvzT]#9bMAJ,^ini)^o3unTQ[Aqko9v.l;WL8yK}FtY*`P+(\
::RB?-.d[25eFu7qY6z^Tmp$l_vBLhl%*bvzRq21GRaei-H9J%p=2.d+L7GpHJhoL|+)Hc$KlJEGk-hAC(f+%cyW+,EVFIT#bb45eZD3!,3__Wj;5.e**rNu$#u4sz3Q\
::1WvKxq\
".replace(/[\\:\s]/gm,""); r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(/.{1,5}/g);
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close();
