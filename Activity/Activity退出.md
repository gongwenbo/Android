

Android Activity类中的finish()、onDestory()和System.exit(0) 三者的区别  
>http://blog.csdn.net/yelangjueqi/article/details/9466347

 Activity类中的finish()、onDestory()和System.exit(0) 三者的区别：
finish是Activity的类，仅仅针对Activity，当调用finish()时，只是将活动推向后台，并没有立即释放内存，活动的资源并没有被清理；当调用System.exit(0)时，杀死了整个进程，这时候活动所占的资源也会被释放。

**Activity.finish()**
Call this when your activity is done and should be closed. 
在你的activity动作完成的时候，或者Activity需要关闭的时候，调用此方法。
当你调用此方法的时候，系统只是将最上面的Activity移出了栈，并没有及时的调用onDestory（）方法，其占用的资源也没有被及时释放。因为移出了栈，所以当你点击手机上面的“back”按键的时候，也不会找到这个Activity。

**Activity.onDestory()**
the system is temporarily destroying this instance of the activity to save space.
系统销毁了这个Activity的实例在内存中占据的空间。
在Activity的生命周期中，onDestory()方法是他生命的最后一步，资源空间什么的都没有咯~~。当重新进入此Activity的时候，必须重新创建，执行onCreate()方法。

**System.exit(0)**
这玩意是退出整个应用程序的，是针对整个Application的。将整个进程直接KO掉。
使用时，可以写在onDestory()方法内，亦可直接在想退出的地方直接调用：
如：System.exit(0); 或 android.os.Process.killProcess(android.os.Process.myPid());

**KillProcess**

	android.os.Process.killProcess(android.os.Process.myPid());

这样就可以从操作系统中结束掉当前程序的进程。

注意：android中所有的activity都在主进程中，在Androidmanifest.xml中可以设置成启动不同进程，Service不是一个单独的进程也不是一个线程。
当你Kill掉当前程序的进程时也就是说整个程序的所有线程都会结束，Service也会停止，整个程序完全退出。


Android退出应用最优雅的方式(改进版)   
建立一个全局容器，把所有的Activity存储起来，退出时循环遍历finish所有Activity   
> http://blog.csdn.net/soul_code/article/details/50453934   


android程序退出当前activity的方法
Intent中直接加入标志Intent.FLAG_ACTIVITY_CLEAR_TOP 来退出

	Intent intent = newIntent();
	intent.setClass(Android123.this,CWJ.class);
	intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);//注意本行的FLAG设置
	startActivity(intent);