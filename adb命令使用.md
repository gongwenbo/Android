

## 如何启动adb

进入你的sdk安装目录下，其中cd是进入的意思。进入到platform-tools下

然后在该路径下 进入【安装shift + 右键 =》在此处进入命令窗口】

## 重启adb

	adb kill-server
	
	adb start-server

出现 successful 就重启成功了。// 好吧，我自己实验的时候没有出现。

##　超级权限

对系统app进行操作时会用到。

	adb remount

## 把系统应用装上

	adb push B×××r.apk system/app

## 切换目录

	cd system/app

## 卸载系统应用 - 先切换目录再卸载应用。

	rm -r B×××r.apk

## 卸载普通应用

	adb uninstall B×××r.apk
---

## 01-实践-安装系统应用APK

1. 把 B×××r.apk 放入 F:\ADT\sdk\platform-tools 文件夹。
2. 在 F:\ADT\sdk\platform-tools 路径下 进入 命令窗口
3. 输入 adb remount 获取超级权限
4. 输入 adb push BFCBehavior.apk system/app 把新的系统应用安装到上面
5. 出现了 数据传输的 log 就说明安装成功了。


## 02-实践-删除 data/data 下面的 com.eebbk.bfc.app.bfcbehavior 文件夹 

	adb remount
	adb shell
	cd data/data
	rm -rf com.eebbk.bfc.app.bfcbehavior

## 03-重启机子

---






