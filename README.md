# File2Bach  
Efficient file or folder to .bat converter via makecab compression and optimized res85 ascii encoder  

## Typical usage  
Used mostly for sharing configs / scripts / dumps / captures as plain-text on message boards that lack proper file attachments, or to safekeep, run multiple tests and sharing binaries in malware analysis tasks  

## Uninstall  
File2Batch.bat adds itself to the Send To right-click menu for convenience in usage. To remove, just run:  
```bat
cmd.exe /c del /f/q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\File2Batch.bat"  
```
## res85 encoder details  
Tweaked version of [Ascii85](https://en.wikipedia.org/wiki/Ascii85) that works well with batch syntax highlighter used by pastebin and others  

```
Dictionary:
0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?.,;-_+=|{}[]()*^%$#!`~
```
```bat
Encoded example:
::O}bZg00000YXJZN00000EC2ui000000!5a50RR9100000K(z(;0RRIP4FLcE00000005ax4O[$pbY=jN04]}`#UQMk0b788jQ`vv5P1Lq07)J]0Am0E08L)TAZc)TW\
::NCABX(MnAX(_!0WGo[VZ=_AUZftoVVtF8FX(;ZQWnpt~ZY-^Tb.x,Nc%4IXX(;ZRX(MnAY|{UBaA9|EX(V(IW^?|BAa8VNWpW^4ZfR##Y}?CicW7y2Xdr2GAYmYEb.\
::rteZ+PBLXk#R6X(MdJAarP9bRc4RAYmYIWpZ[6c4cy5ZewL2Z+PB5Wo-6*XmlWHZXk4MWgug3ZggpGb?B8AVQyp~X(Md)W)^_$XJKM-Wgur!Ze)}!bZKvHAa7[MYi*\
::6MY{MC}Wh*!Ncw]Q#WOE(NXk#RCXm4%KAa{SFWo(0#V$U_3W=`j1c%3q9a-BR4AaHDDVRLnIWi9#\ 
Total characters per line: 129
Data  characters per line: 126
Prefix: ::
Suffix: \
Decoded result is binary and needs to be further expanded since it's cab LZX-compressed
```
