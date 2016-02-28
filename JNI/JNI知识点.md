

Dalvik虚拟机JNI方法的注册过程分析[**细致的讲解了 so库加载的过程- 可以仔细的看一下**]
>  http://blog.csdn.net/luoshengyang/article/details/8923483

---

Java中System.loadLibrary() 的执行过程[**写的很好**]
>  https://m.oschina.net/blog/129696

1. 调用dlopen() 打开一个so文件，创建一个handle。
2. 调用dlsym()函数，查找到so文件中的JNI_OnLoad()这个函数的函数指针。
3. 执行上一步找到的那个JNI_OnLoad()函数。

JNI_OnLoad() 里面一般是 把SO库 和 当前的虚拟机 绑定在一起。

	jint JNI_OnLoad(JavaVM *vm, void *reserved)
	{
	    JniHelper::setJavaVM(vm);
	
	    return JNI_VERSION_1_4;
	}


	// 引擎底下： JniHelper.cpp
	JavaVM* JniHelper::m_psJavaVM = NULL;
	void JniHelper::setJavaVM(JavaVM *javaVM)
	{
	    m_psJavaVM = javaVM;
	}



NDK-JNI实战教程（三） 从一个比Hello World稍微复杂一丁点儿的例子说说模板[**写的很好**]  
>  http://yanbober.github.io/2015/02/25/android_studio_jni_3/