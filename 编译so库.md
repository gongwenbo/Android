

## 哪些情况下不需要编译so库
只修改了下面路径中的 JAVA 文件时，是不需要修改so库的。
>F:\cocos2d-x-2.2.3-xtc-0.6\cocos2dx\platform\android\java\src\org\cocos2dx\lib

## 哪些情况下需要编译so库

修改了如下路径中的 .cpp 文件时，就需要重新编译so库。

>F:\cocos2d-x-2.2.3-xtc-0.6\XtcUtils  
>F:\cocos2d-x-2.2.3-xtc-0.6\cocos2dx  
>F:\cocos2d-x-2.2.3-xtc-0.6\external  
>F:\cocos2d-x-2.2.3-xtc-0.6\extensions  
>F:\cocos2d-x-2.2.3-xtc-0.6\CocosDenshion  

## 如何编译个人.so库

编译引擎库的方式十分简单，只需创建一个新工程,然后到Escapli中编译完成即可，最后输出的.so文件即为我们所需要的引擎库。【好像，只要打开 Escapli ，然后点击 XtcLibProject ，点击 run as，这个个人的 .so 库就会编译出来了】

>F:\cocos2d-x-2.2.3-xtc-0.6\projects\XtcLibProject\proj.android\libs\armeabi\libcocos2dxtc.so


## 编译好后的so库放在哪里

所有游戏进行 ant 编译时，就是调用这个文件夹里的 so 库。
>F:\cocos2d-x-2.2.3-xtc-0.6\LibXtc\libcocos2dxtc.so




