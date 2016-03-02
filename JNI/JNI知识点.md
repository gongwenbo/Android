

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


Part3.JNI类型映射和参数传递    
>http://cdn.verydemo.com/demo_c316_i164261.html


jni中的本地引用和全局引用 --- 资源释放的问题 --- 
>http://m.blog.csdn.net/article/details?id=7397052

	JNI支持三种类型的java对象引用：局部引用(local reference)、全局引用(global reference)以及弱全局引用(weak global reference)。三种类型的引用具有不同的生命周期，另外垃圾回收器对这三种对象引用的管理方式也不同。创建局部引用的本地方法返回后(注意：这里是指返回到java方法)，局部引用将变成无效。而全局引用以及弱全局引用在本地方法返回后，仍然有效。垃圾回收器无法回收本地方法创建的局部引用和全局引用，但可以回收本地方法创建的弱全局引用。为了编写正确而且内存安全的java本地方法，很有必要对这三种类型的对象引用做些总结。

