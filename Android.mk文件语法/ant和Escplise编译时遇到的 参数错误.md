

## 案例1 

把 项目组 所有的游戏 打到一个工程里面去编译，

统计有 13万行代码【不算注释和空行】 

然后 到最后的时候，报了一个错误：

make (e=87): 参数错误

原因是.MK文件中包含的文件太多了，而windows对于函数参数个数有限制，解决的方法有两个：
1，将当前mk文件中的c或c++文件分离到另外一个mk文件中，即是将单独的irrlicht库分成两个工程编译，通过链接so库文件最终生成最后需要的so动态库；

2，这一种方法比较简单：
在Android.mk文件中添加：LOCAL_SHORT_COMMANDS := true
在Application.mk文件中添加：APP_SHORT_COMMANDS := true

第二种方法是从一个老外的论坛查到：http://stackoverflow.com/questions/12598933/ndk-build-createprocess-make-e-87-the-parameter-is-incorrect
据说一般不要太普遍用，会导致编译变慢，但从实际上观察，并没有慢太多，并且个人认为，作为编译一个不经常改动的库来讲，编译时间稍微长点关系不大。

## 结果

用的第2种方法 就解决了，但是 编译时间用了： 26分钟。



## 关于LOCAL_SHORT_COMMANDS

关于LOCAL_SHORT_COMMANDS 参数的解释：

设置这个变量为‘true’，当你的module有很多的源文件，或者依赖很多的静态或动态库。这会强制编译系统使用一个中间的列表文件，并通过@$(listfile) 语法和library archiver 或者 static linker一起使用。
这在Windows上是非常有用的，因为它的命令行只接收最大8191个字符，这对于复杂的工程来说太小了。


## 快速编译软件

用1个builder，修改的才编译