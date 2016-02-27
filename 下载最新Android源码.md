
## 在Windows环境下通过Git得到Android源代码

参考网址：
> http://www.cnblogs.com/xiaoluo501395377/p/3404628.html

这个速度非常的快，这时我们就得到了Android4.3的源代码了，我们进入到刚才clone的android-->core目录，然后将 java 这个文件夹拷贝到我们 sdk 的目录下，如：

F:\adt-bundle-windows\sdk\platforms\sources\java

这样我们就可以在eclipse中将源代码关联到我们刚下载下来的4.3的源代码上了。


## 从github下载最新Android源码

- 01 去 github 官网下载。
> https://github.com/android

github.com/android上托管的Android源码是用git单独管理每个项目的，而没有像googlesource.com那样使用repo（谷歌开发的基于git的命令行工具）管理所有项目。所以，如果你只想下载一个项目的源码，可以单独下载（比如开发App想跟一下SDK的一些源码可以下载platform_frameworks_base项目）。

- 02 所以我们就选择 platform_frameworks_base 来下载。

- 03 下载完后，我们就可以进去看源代码了。
