
## 配置 编译设置

打开 Esclipse ,

1. 右键点击工程，点击 属性【properties】
2. 点击 【Builders】
3. 把CDT Builder 的对勾点掉。		// 以前编译 C++ 的时候 应该就是用的 CDT Builder
4. 点击 New...
5. 选择 Program,点击OK
6. 在 Main，Location ，那里 选择 Variables, 选择 edit Variables,选择 New, name 填 modifyBuild, value 填 F:\environmentPath\android-ndk-r10c\ndk-build.cmd
7. 点击确定， 在 Location 那里填 ${modifyBuild}。其实刚选择的时候就 已经 填进去了。
8. 在 Main-Working Directory 里面选择上要 这样编译的工程
9. 在 Environment 里面 点击 New，在弹出的 新窗口中 name 选项里面输入 NDK_MOUDL_PATH
10. 在弹出的 新窗口中 点击 Variables
11. 在弹出的新窗口点击 Edit Variables
12. 在弹出的新窗口中 点击 New，Name 输入 NDK_MOUDL_PATH， Value 中输入 引擎的路径 + prebuilt 的路径
13. 如下 F:\cocos2d-x-2.2.3_bbg-dashuju;F:\cocos2d-x-2.2.3_bbg-dashuju\cocos2dx\platform\third_party\android\prebuilt
14. 一路点确认
15. 点击 C/C++ Build， 点击 Builder Settings 在 Build command 框里面 填： ${modifyBuild} 


## 然后 build

右键点击工程， 选择 Build Project

在 Console 控制台 窗口处 就可以看到输出的 LOG 了。




