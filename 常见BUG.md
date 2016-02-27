
## 安装失败

01 ： 安装APK时，安装不到板子上去。  
豌豆荚提示： “安装失败，软件供应商冲突”

原因：AndroidManifest.xml 里的配置写的有冲突。

比如 package = "com.BBB.XXX" 这里填的包名 和
android:authorities= "com.AAA.XXX.DA" 填的不一致时。

这时，就会安装APK安装不上去，死活都安装不上去。