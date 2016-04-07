
Android 开发 之 JNI入门 - NDK从入门到精通 -[写的太详细了啊]
>http://blog.csdn.net/shulianghan/article/details/18964835

## 调用 static 函数，并且传递数组

	// C++ 层
	void BbgBigData::customEvent(const char* functionName, const char* moduleDetail, const char* triggerValue, const char* jsonStr, DataAttr* dataAttr)
	{	
	#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
		JniMethodInfo methodInfo;
		if (JniHelper::getStaticMethodInfo(methodInfo, "org/cocos2dx/lib/BbgBigData", "JNICustomEvent", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)V")) {
			// char2jstring
			jstring stringFun = char2jstring(methodInfo.env, functionName);
			jstring stringModu = char2jstring(methodInfo.env, moduleDetail);
			jstring stringTrigV = char2jstring(methodInfo.env, triggerValue);
			jstring stringJsonS = char2jstring(methodInfo.env, jsonStr);
			
			// struct2array
			jobjectArray stringArr = struct2array(methodInfo.env, dataAttr, Enum_Max_Num);
	
			// Call
			methodInfo.env->CallStaticVoidMethod(methodInfo.classID, methodInfo.methodID, stringFun, stringModu, stringTrigV, stringJsonS, stringArr);
			
			// Release memory
			methodInfo.env->DeleteLocalRef(stringFun);
			methodInfo.env->DeleteLocalRef(stringModu);
			methodInfo.env->DeleteLocalRef(stringTrigV);
			methodInfo.env->DeleteLocalRef(stringJsonS);
			methodInfo.env->DeleteLocalRef(stringArr);
			methodInfo.env->DeleteLocalRef(methodInfo.classID);
		}
	#endif
	}


	// JAVA 层
	/**
     * 自定义事件
     * functionName：触发本次动作的功能点名，不能为空，可作为一级分类
     * moduleDetail：触发本次动作的附加明细说明，可为空，可作为二级分类
     * triggerValue：触发值:"123"
     * Json:json格式字符串，可为空
     */
    public static void JNICustomEvent(String functionName, String moduleDetail, String triggerValue, String Json, String[] stringData) {
    	// 传输数据
    	CustomEvent customEvent 	= 	new CustomEvent ();
    	customEvent.activity 		= 	XtcOkiiRank.getMainActivityName();
    	customEvent.functionName 	= 	functionName;
    	customEvent.trigValue		=	triggerValue;	
    	customEvent.dataAttr		=	new DataAttr()	.setDataId(stringData[DataEnum.BBK_Data_Id.ordinal()])
    													.setDataTitle(stringData[DataEnum.BBK_Data_Title.ordinal()])
    													.setDataEdition(stringData[DataEnum.BBK_Data_Edition.ordinal()])
    													.setDataType(stringData[DataEnum.BBK_Data_Type.ordinal()])
    													.setDataGrade(stringData[DataEnum.BBK_Data_Grade.ordinal()])
    													.setDataSubject(stringData[DataEnum.BBK_Data_Subject.ordinal()])
    													.setDataPublisher(stringData[DataEnum.BBK_Data_Publisher.ordinal()])
    													.setDataExtend(stringData[DataEnum.BBK_Data_Extend.ordinal()]);
    	
    	// 传递 二级分类-可为空;
    	if(!moduleDetail.equals("NULL")) {
    		customEvent.moduleDetail 	= 	moduleDetail;
    		Log.d("BbgBigData", "JNICustomEvent-moduleDetail==" + moduleDetail);
    	}
    
    	// 传递扩展字段【JSON数据格式】-可为空
    	if(!Json.equals("NULL")) {
        	customEvent.extend = Json;
        	Log.d("BbgBigData", "JNICustomEvent-Json==" + Json);
    	}
    	
		BehaviorCollector.getInstance().customEvent(customEvent);
    }





## 调用非static函数

### 方法1

	// C++ 层,先调用 JNIGetActivity(),获得实例对象，再调用 JNIStartRecording() 
	void YzsJNI::startRecording()
	{
	#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	
		JniMethodInfo methodInfo;
		if (JniHelper::getStaticMethodInfo(methodInfo, "com/xtc/speechrecognitiondemo/SpeechActivity", "JNIGetActivity", "()Ljava/lang/Object;")) {
	
			jobject jobj = methodInfo.env->CallStaticObjectMethod(methodInfo.classID, methodInfo.methodID); 
			if (JniHelper::getMethodInfo(methodInfo, "com/xtc/speechrecognitiondemo/SpeechActivity", "JNIStartRecording", "()V")) {
				
				methodInfo.env->CallObjectMethod(jobj, methodInfo.methodID); 
				
				// Release memory
				methodInfo.env->DeleteLocalRef(jobj);
				methodInfo.env->DeleteLocalRef(methodInfo.classID);
			}
		}
	
	#endif
	}

	
	// JAVA 层
	// 初始化
    protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);		
		activity = this;
	}

	//给C++层调用的静态方法，返回单例对象 的引用
    static Object JNIGetActivity()
    {
    	   return activity;		// 这个activity 记得要初始化
    }

	// 用户 点击了 start 按钮。
	public void JNIStartRecording() {
    	.... ....
    }


### 方法2

	// C++ 层 直接调用 JNIStartRecording() =================================================
	void YzsJNI::startRecording(const char* jsonStr)
	{
	#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
		JniMethodInfo methodInfo;
		if (JniHelper::getStaticMethodInfo(methodInfo, "com/xtc/speechrecognitiondemo/SpeechActivity", "JNIStartRecording", "(Ljava/lang/String;)V")) {
	
			// char2jstring
			jstring stringJson = char2jstring(methodInfo.env, jsonStr);
	
			// Call
			methodInfo.env->CallStaticVoidMethod(methodInfo.classID, methodInfo.methodID, stringJson);
	
			// Release memory
			methodInfo.env->DeleteLocalRef(stringJson);
			methodInfo.env->DeleteLocalRef(methodInfo.classID);
		}
	#endif
	}

	#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	static jstring char2jstring(JNIEnv* env, const char* charObject) 
	{
		// at JAVA interface,check"NULL"
		if (charObject	== NULL)	charObject	= "NULL";
	
		// start change 
		std::string strObject(charObject);
		YzsJNI::GBKToUTF8(strObject);
		const char* Object = strObject.c_str();
		jstring	stringObject = env->NewStringUTF(Object);
		return stringObject;
	}
	#endif

	// JAVA 层 =============================================================================
	static public void JNIStartRecording (String jsonStr) {
    	activity.StartRecording(jsonStr);
    }

	// 用户 点击了 start 按钮。
	public void StartRecording(String txt) {
		.... ....
	}




