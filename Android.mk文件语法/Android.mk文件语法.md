
## 	概述

一个模块属于下列类型之一：静态库或共享库。

只有共享库能被安装/复制到应用软件包，

静态库能被用于生成共享库。

## 	简单的例子

helloworld.c 是一个JNI 共享库，实现返回hello world 字符串的原生方法。相应的
Android.mk文件会像下面这样：

	LOCAL_PATH := $(call my-dir)
	include $(CLEAR_VARS)
	LOCAL_MODULE:= helloworld
	LOCAL_SRC_FILES := helloworld.c
	include $(BUILD_SHARED_LIBRARY)

一句句翻译：

	LOCAL_PATH := $(call my-dir)

宏函数my-dir由编译系统提供，用于返回当前路径（即包含Android.mk 文件的目录）

	include $(CLEAR_VARS)

CLEAR_VARS由编译系统提供，指定让GNU MAKEFILE清除许多 LOCAL_XXX变量（例如  
LOCAL_MODULE、
LOCAL_SRC_FILES、
LOCAL_STATIC_LIBRARIES等），
除了LOCAL_PATH。

因为所有的编译控制文件都在同一个GNU MAKE执行环境中，所有的变量都是全局的。 

	LOCAL_MODULE:= helloworld

LOCAL_MODULE变量必须定义，以标识在Android.mk文件中描述的每个模块。而且名称必须是唯一的，且不包含任何空格。编译系统会自动产生合适的前缀和后缀，比如一个被命名为foo的共享库模块，将会生成libfoo.so 文件。如果把库命名为libhelloworld，编译系统将不会添加任何的lib 前缀，也会生成libhelloworld.so 文件，
这是为了支持来源于Android平台的源代码的Android.mk文件。

	LOCAL_SRC_FILES := helloworld.c

LOCAL_SRC_FILES变量必须包含将要编译打包进模块中的C或C++源代码文件。我们不用在这里列出头文件和包含文件，因为编译系统会自动找出依赖型的文件，只需要列出直接传递给编译器的源代码文件就好。注意，默认的C++源码文件的扩展名是“.cpp ”，虽然指定一个不同的扩展名也可以，只要定义
LOCAL_DEFAULT_CPP_EXTENSION变量即可，但不要忘记开始的小圆点，也就是定义为“.cxx”，
而不是“cxx”。

	include $(BUILD_SHARED_LIBRARY)

BUILD_SHARED_LIBRARY是编译系统提供的变量，指向一个GNU Makefile脚本（应该就是build/core目录下的shared_library.mk），负责收集自从上次调用include $(CLEAR_VARS)以来，定义在LOCAL_XXX变量中的所有信息，并且决定编译什么，如何正确地去做，并根据其规则生成静态库。在sources/samples 目录下有更复杂一点的例子，写有注释的Android.mk文件，可以参考。

## 	Android.mk使用模板

1）编译应用程序的模板

	#Test Exe
	LOCAL_PATH := $(call my-dir)
	#include $(CLEAR_VARS)
	LOCAL_SRC_FILES:= main.c		// 加入源文件路径
	LOCAL_MODULE:= test_exe			// LOCAL_MODULE表示模块最终的名称
	#LOCAL_C_INCLUDES :=			// LOCAL_C_INCLUDES中加入所需要包含的头文件路径
	#LOCAL_STATIC_LIBRARIES :=		// LOCAL_STATIC_LIBRARIES加入所需要链接的静态库（*.a）的名称
	#LOCAL_SHARED_LIBRARIES :=		// LOCAL_SHARED_LIBRARIES中加入所需要链接的动态库（*.so）的名称
	include $(BUILD_EXECUTABLE)		// BUILD_EXECUTABLE表示以一个可执行程序的方式进行编译。

2）编译静态库的模板

	#Test Static Lib
	LOCAL_PATH := $(call my-dir)
	include $(CLEAR_VARS)
	LOCAL_SRC_FILES:= /helloworld.c
	LOCAL_MODULE:= libtest_static
	#LOCAL_C_INCLUDES :=
	#LOCAL_STATIC_LIBRARIES :=
	#LOCAL_SHARED_LIBRARIES :=
	include $(BUILD_STATIC_LIBRARY)	// BUILD_STATIC_LIBRARY表示编译一个静态库。

3）编译动态库的模板

	#Test Shared Lib
	LOCAL_PATH := $(call my-dir)
	include $(CLEAR_VARS)
	LOCAL_SRC_FILES:= /helloworld.c
	LOCAL_MODULE:= libtest_shared
	TARGET_PRELINK_MODULES := false
	#LOCAL_C_INCLUDES :=
	#LOCAL_STATIC_LIBRARIES :=
	#LOCAL_SHARED_LIBRARIES :=
	include $(BUILD_SHARED_LIBRARY)		// BUILD_SHARED_LIBRARY表示编译一个共享库。



## LOCAL_WHOLE_STATIC_LIBRARIES和LOCAL_STATIC_LIBRARIES的区别浅析


LOCAL_WHOLE_STATIC_LIBRARIES会加载整个静态库，
LOCAL_STATIC_LIBRARIES只是加载静态库中用到的函数。

但是其实还有更加深入的 区别：

看下面的文章--递归引入的问题  
>http://blog.csdn.net/zhaoxy_thu/article/details/12955869


## import-module的功能

导入外部模块的.mk文件 ，和 include基本一样。
概念上的区别是include导入的是由我们自己写的.mk。而import-module导入的是外部库、外部模块提供的.mk。
用法上：include的路径是.mk文件的绝对路径。
而import是设置的路径指定到模块的.mk所在目录，是相对于NDK_MODULE_PATH中的路径列表的相对路径。

import-module的使用

	$(call import-module,相对路径)		// 是相对于NDK_MODULE_PATH中的路径列表的相对路径。


## NDK_MODULE_PATH的配置

NDK_MODULE_PATH的设置与格式   
>http://blog.sina.com.cn/s/blog_4057ab62010197z8.html


