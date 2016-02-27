

## 最终运行代码

	private static Cocos2dxActivity gameActivity = null;
	private static  String mainActivityName = null;		// 保存主ActivityName-【第1个启动的Activity】
	
	/**
	 * 
	 * 获取 主ActivityName
	 * 
	 * @return
	 * @author ???
	 */
	public static String getMainActivityName() {
		if (gameActivity != null && mainActivityName == null) {		// 只赋值1次
			mainActivityName = gameActivity.toString();				// 主Activity名字转字符串 - com.xtc.voicerecognizertest.VoiceRecognizerTest@2342423
			mainActivityName = mainActivityName.substring(0, mainActivityName.lastIndexOf("@"));		// 把 @及以后的字符串 全部都去掉。
			mainActivityName = mainActivityName.replace(".", "/");	//  变换成   com/xtc/voicerecognizertest/VoiceRecognizerTest 的形式
		}
		
		return mainActivityName;
	}		


### 所用到的函数

 - **replace方法**  
replace的参数是char和CharSequence,即可以支持字符的替换,也支持字符串的替换。

 - **lastIndexOf方法**  
返回 String 对象中 子串或者字符 最后出现的位置。

 - **indexOf方法**  
返回 String 对象内第一次出现 子串或者字符 的位置。

 - **substring用法**  
str＝str.substring(int beginIndex);截取掉str从首字母起长度为beginIndex的字符串，将剩余字符串赋值给str；  
str＝str.substring(int beginIndex，int endIndex);截取str中从beginIndex开始至endIndex结束时的字符串，并将其赋值给str;  

示例：  

 	"hamburger".substring(4, 8) returns "urge"
 	"smiles".substring(1, 5) returns "mile"
参数：  

	beginIndex - 开始处的索引（包括）。
	endIndex - 结束处的索引（不包括）。
返回：  

	指定的子字符串。
抛出：

	IndexOutOfBoundsException - 如果 beginIndex 为负，或 endIndex 大于此 String 对象的长度，或 beginIndex 大于 endIndex。



## 网上示范代码

String contextString = gameActivity.toString();
		Log.d("getDownPath", contextString);
	    String activity_name = contextString.substring(contextString.lastIndexOf(".")+1, contextString.indexOf("@"));
	    Log.d("getDownPath", activity_name);

		
		// ActivityInfo activityName1[] = packInfo.activities;


		String contextString = sActivity.toString();
		Log.d("getDownPath", contextString);
	    String activity_name = contextString.substring(contextString.lastIndexOf(".")+1, contextString.indexOf("@"));
	    activity_name = contextString.substring(, contextString.indexOf("@"));
	    Log.d("getDownPath", activity_name);