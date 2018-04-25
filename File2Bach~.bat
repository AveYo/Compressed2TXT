@set @v=3.1 /*&echo off &set tool=FILE2BACH
title %tool% v%@v:~0,-3% [%~f0]
set "res=File2Batch~"
pushd %~dp0 &cscript.exe //nologo //e:JScript "%~f0" "%res%"
echo. &expand.exe -R "%res%" -F:* . &del /f /q "%res%"
echo. &pause &title %comspec% &exit/b
:res85_decoder */
var fn=WSH.Arguments(0); WSH.Echo("FILE2BACH v"+@v+": res85 decoding "+fn+" ..."); var res="\
::O}bZg00000rw9N500000EC2ui000000!5a50RR9100000O8*$(0RRIPei8rx00000005dyl(i%BMrmwiGD2Z]V$wg7VRQhlB$pY42?0Y[fPjqw5acHS07C(eA^{pnW\
::jEJ[Gx=,WvsP5H+=KSTvPLl4Ni{qp4huTardqYNMXHSef-KRz##RRK0MW[=K,ro6GZI*CNl5*eAR(N=U_oDt4tBs3.Gtk`Z!+HW=%ZphNiv=u$=xYy]2^YljjgV-In\
::HV0vU8)w.S3O-2ql64!NsB|##R9200RI{LQ)),URibE=hMgq1nvpQGWVC^%c=;2qky#5K7c%kEvw8;N7sM(4.KmVN3m}f|UlzAmsHt+*818jJe1w}09)?g2zJM77cG\
::%s|7JtF.|wT]kXL!fs8s|GA$9+rC[}Xp.VBEtph;wtfFiTBD9AJk5;Tvk3e0u-ct$PE90F1.47~}~Nw^CcDk=`1(ClP|Ndin*_!N{PVM3I696_5Haxja}s,MX^dtrx\
::LTN|kYWJ^QqF~R_O-DZ=r9+5sUbiAUiq!!)9Nv,]Lqm9UQ$o.XrWo~[U0kg1hbSt]+[,nK%;^{s#|l!eq*?;TV%R.#c32jbI+vbX7v#w0DM]i[+cDerSvr68~J0.aT\
::gcEloHC2WdNlJMn7~eB9tvJgL#L*Rj2D^,2k5[gQv%6%_=dsV#IsjJ5%e0],n1hlQ%s%DHxG+qz%R7HpasZVMl+?EsoTx9w}Tw0cER8]x*6NzJFC?p#2ZJGDc)De8(\
::l]EhaUG.]sEmD.$EZty9nbmU?wJz1X`fD^PSh!c3Kl58]9{gpNV|uCWoS`;LNf(f-xr[8JT!jP0T03VDqjY+p0V%tJA{Pb;focNWllWl(tfG;nKWw3zUX25=W*qWNe\
::T2l[aL,+emY!yt8*GKXAtR9dM(7lc5*s!eDN);f+$,UiIJX0IsOxJ2!4=.(%}3-B4(}K_SZJ8.^PfnmdLm8Id}1r].0rzI|XIIgq$CF62$FA%%`wIH0)n[;Kk}kj+X\
::Unj+yTc4hx%Qd9{!}F9)Cc8_soMb6C-1?6a+Lp%miAj`-ox]Vv`X3)I.d{-8Or(V}|4yI1w.?pY,_t7ihY50JxU+)o]]M^$fB)K-4w*FeIe2`]^[fy;Q;kLR$^|PT5\
::!4-*INgThLJpgdlWxp.!~JRguf-`3`~Y)N_-{1cFz4t3vZK[%,%YzDyLMMj!1Mx5tkjI2OujH#{_k52SgpwZ8_jTGJ.V-y^dOgH0]1#EW#?Pb265a^|?J8BiSMP7bV\
::y(4Wg=(Goo$$Jj0jH.yM^G}uk#kcZ#(EEpw]*DOE$DxU*W6jR4p{e.[-7LPkr18D[Y,k=Hn8Ib4_(0wisl1d.jZlJpNg+}1g4tqribpmYr7Cg#Q3TPN;#U5LeKPqAo\
::z6=O7-DyH4Kr}_)DP82aHGFyY8|sRm2_~(77o-Ci8.n;!4WVc+1n4p#LiIdS7yc%QV2j}K4yHw,NC;va+F72eNaHoG;?Vx{e7hY;n`)$chSw$a;n+IBbzv;*otuLGJ\
::l1e#[Y~SEFB21-b;M+J$90,?t9]?{k9#SMu#%nqS%vs+u`6E!ChZK9K*oFq7f6[Lo*Xc7q7sG{WJNt!2dcCN-rj2}Gpn6h;HZ23i(aKDPrX+fKSA914AHbxo0BH]7F\
::NoGOJPrp=H9xDSaYZjJB{J}wgXvf%sGus4-?I=v+5_KIc=9t0+tP(d_5G{3X}7md(%X+]!%8us9+VE?Nq!wWf#LAu2nFQJW[IscW9(1VN7{W,syX]JG,vycRlHBZp$\
::+|M4G[u2s3Sutqag#g7rvOY^FX.yF=DqJv4V}KLo!6qFE0fRs|XXw_r3z]1F]k!+ZT+A$LDK=`6#]#3K`OciHl-_f3_MMHoe[UzWw6n|%N+3.01|YI$3x9Ti?n?7hg\
::*73%Ewco8N#;nLVJ;La4?9|OPS[p$Ca,dW+8...+*17e3#;aeGdlrFPF!1^sd_!y}i;W~c%.6CBDt5$fqgIMe$HUwqgT!i.r.zO.M60?$Sa?j^FKuCt|Z[c(EU2UOz\
::w+oR,2=V*QloVW|J;^ZVJFlWOR|p#e~uU5d#f5|gbkN};,=L|RXfcH96PVye^Qsubj5vH1iOs4Rja%o$hFmuuq?1(M{xRdihIgjq3QK)|2q-=c1,rinH}.*?4AUsp{\
::DY17OdNC8|jdA|S^grS`Qr2ULt,SSKLgh40EBS4nf2m.mcp{o0}~4iDS?kbzSet}gr,k0l867UC0D9wLY^R9.r`g8DW_khWD3rJ~^hQZ2wjq?JHpKOt0e.%EMKUQvW\
::%-]Vi3Z^kCE.-rg(RI6jL8fk+f%hrUHWhiJQF;lJ4yL]n2Sziw~pfpWT,)*-?QawiJzQF~kO2+r+|=vMvi}GP,MvsUZY6WU^{)pnj8FhmChHj;-Vmb?f7WBCp_ZzBu\
::;r[).r8TPcmAg$LauoWs)]yQa^$3k+_^?Z.zl(yCSw{C7e_K[~AjQuj0wkR=]vGp,GO`H2Qchw39s$F#]OMw.Zv=lGQ1XJ0{WFsor%7|(U{?%MMbC|$+ixMDgTv3Om\
::#]7`]mH#csMo~~Ug^sdkGw4b,l#a8i6vyzP,di!.;HyVaBDtb`my5c3r?r+.[?!YLxTlFT#]Q9gBU0Dp{H,Q(wHlLzQHdc%KIFe8;(JZD%R7W5n[L7,YQNQUk_hCUS\
::.KW9+P!gcrukP]*i*F|H_;KLl,CC_I.orU9A}yfzcqq!$G%Ksb#fa58O|mO7mxOQIe~xi=md=QDGRO*DL~#|iSqL]R*;T9[1aj,QZb-cc_+I-H2p%Z_nED?2SB|\
".replace(/[\\:\s]/gm,""); r85='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~'.split('');
d85={}; for(var i=85;i--;) d85[r85[i]]=i; p85=[]; for(var i=5;i--;) p85[i]=Math.pow(85,i);
z='00000000'; pad=(res.length%5)||5; res+='~~~~~'.slice(pad); pad=10-2*pad; a=res.match(/.{1,5}/g);
for(var l=a.length;l--;){n=0;for(j=5;j--;)n+=d85[a[l].charAt(j)]*p85[4-j];a[l]=z.slice(n.toString(16).length)+n.toString(16)};
res85dec=(pad>0)?a.join('').slice(0,-pad):a.join('');
xe=WSH.CreateObject('Microsoft.XMLDOM').createElement('bh');as=WSH.CreateObject('ADODB.Stream');as.Mode=3;as.Type=1;as.Open();
xe.dataType='bin.hex';xe.text=res85dec;as.Write(xe.nodeTypedValue);as.SaveToFile(fn,2);as.Close(); 
