
## H文件

	enum XXX_Data_Attr{
		XXX_Data_Id,				//	数据ID
		XXX_Data_Title,				//	数据标题
		XXX_Data_Edition,			//	数据版本
		XXX_Data_Type,				//	数据类型
		XXX_Data_Grade,				//	数据年级
		XXX_Data_Subject,			//	数据科目
		XXX_Data_Publisher,			//	数据出版者
		XXX_Data_Extend,			//	数据扩展
		Enum_Max_Num,				//  枚举体最大个数-不要使用
	};
	
	typedef struct dataAttr {
		char* data[Enum_Max_Num];
	} DataAttr;



	class CC_DLL XXXBigData			// 做DLL文件时
	{
	public:
		/** @brief 自定义事件 */
		/** @param[in]functionName-------功能点名【不可为空】 */
		/** @param[in]moduleDetail-------详细描述,可为空,为空时，请传递"NULL"字符串 */
		/** @param[in]triggerValue-------触发值【不可为空】 */
		/** @param[in]dataAttr-------数据属性，课本会用到，可为空,为空时，请传递NULL指针*/
		/** @param[in]jsonStr-------扩展字段-可为空,为空时，请传递"NULL"字符串 */	
		static void customEvent(char* functionName, char* moduleDetail, char* triggerValue, char* jsonStr, DataAttr* dataAttr);
	};

## CPP 文件
	
	#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	
	static jstring char2jstring(JNIEnv* env, char* charObject) 
	{
		std::string strObject(charObject);
		BbgBigData::GBKToUTF8(strObject);
		const char* Object = strObject.c_str();
		jstring	stringObject = env->NewStringUTF(Object);
		return stringObject;
	}
	
	static jobjectArray struct2array(JNIEnv* env, DataAttr* dataAttr, int arrayLength)
	{
		// creat array
		jobjectArray stringArr = (jobjectArray)env->NewObjectArray(arrayLength, env->FindClass("java/lang/String"), env->NewStringUTF(""));
	
		if (dataAttr != NULL) {
			jstring  stringData[arrayLength];
			for (int i = 0; i < arrayLength; ++i) {
				stringData[i] = char2jstring(env, dataAttr->data[i]);
				env->SetObjectArrayElement(stringArr, i, stringData[i]);	// array Assignment
				env->DeleteLocalRef(stringData[i]);							// Release memory
			}
		}
	
		return stringArr;
	}
	#endif
	
比如我想传递 string[] 数组，就可以写 [+ string 类型对应的 字符   
string 对应的 字符 是	Ljava/lang/String   
所以 string[] 数组 就是 **[Ljava/lang/String;**

	void BbgBigData::customEvent(char* functionName, char* moduleDetail, char* triggerValue, char* jsonStr, DataAttr* dataAttr)
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

## Java 端 代码
	
	private enum DataEnum{
		EEE_Data_Id,				//	数据ID
		EEE_Data_Title,				//	数据标题
		EEE_Data_Edition,			//	数据版本
		EEE_Data_Type,				//	数据类型
		EEE_Data_Grade,				//	数据年级
		EEE_Data_Subject,			//	数据科目
		EEE_Data_Publisher,			//	数据出版者
		EEE_Data_Extend,			//	数据扩展
		Enum_Max_Num,				//  枚举体最大个数-不要使用
	}
								
	public static void JNICustomEvent(String functionName, String moduleDetail, String triggerValue, String Json, String[] stringData) {
	    	// 传输数据
	    	CustomEvent customEvent 	= 	new CustomEvent ();
	    	customEvent.activity 		= 	XXX.getMainActivityName();
	    	customEvent.functionName 	= 	functionName;
	    	customEvent.trigValue		=	triggerValue;	
	    	customEvent.dataAttr		=	new DataAttr()	.setDataId(stringData[DataEnum.EEE_Data_Id.ordinal()])
	    													.setDataTitle(stringData[DataEnum.EEE_Data_Title.ordinal()])
	    													.setDataEdition(stringData[DataEnum.EEE_Data_Edition.ordinal()])
	    													.setDataType(stringData[DataEnum.EEE_Data_Type.ordinal()])
	    													.setDataGrade(stringData[DataEnum.EEE_Data_Grade.ordinal()])
	    													.setDataSubject(stringData[DataEnum.EEE_Data_Subject.ordinal()])
	    													.setDataPublisher(stringData[DataEnum.EEE_Data_Publisher.ordinal()])
	    													.setDataExtend(stringData[DataEnum.EEE_Data_Extend.ordinal()]);
	    	
	    	// 传递 二级分类-可为空;
	    	if(!moduleDetail.equals("NULL")) {
	    		customEvent.moduleDetail 	= 	moduleDetail;
	    		Log.d("XXX", "JNICustomEvent-moduleDetail==" + moduleDetail);
	    	}
	    
	    	// 传递扩展字段【JSON数据格式】-可为空
	    	if(!Json.equals("NULL")) {
	        	customEvent.extend = Json;
	        	Log.d("XXX", "JNICustomEvent-Json==" + Json);
	    	}
	    	
			XXXXX.getInstance().customEvent(customEvent);
	    }						