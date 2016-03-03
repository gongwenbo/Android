LOCAL_PATH := $(call my-dir)

# delcaring the prebuilt library module of libcocos2dxtc
include $(CLEAR_VARS)
LOCAL_MODULE    := libcocos2dxtc
LOCAL_SRC_FILES := ../../../../LibXtc/libcocos2dxtc.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dcpp_shared

LOCAL_MODULE_FILENAME := libcocos2dcpp

# 遍历Classes目录-------------------------------
define walk
  $(wildcard $(1)) $(foreach e, $(wildcard $(1)/*), $(call walk, $(e)))
endef

ALLFILES = $(call walk, $(LOCAL_PATH)/../../Classes)
           
FILE_LIST := hellocpp/main.cpp
# 从所有文件中提取出所有.cpp文件
FILE_LIST += $(filter %.cpp, $(ALLFILES))
# 遍历Classes目录-------------------------------


LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes \
      $(LOCAL_PATH)../../../../../external/sqlite3/include \
			$(LOCAL_PATH)../../../../../cocos2dx/platform/android \
			$(LOCAL_PATH)../../../../../cocos2dx/platform/android/jni \
			$(LOCAL_PATH)../../../../../cocos2dx \
			$(LOCAL_PATH)../../../../../cocos2dx/actions \
			$(LOCAL_PATH)../../../../../cocos2dx/base_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/cocoa \
			$(LOCAL_PATH)../../../../../cocos2dx/draw_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/effects \
			$(LOCAL_PATH)../../../../../cocos2dx/include \
			$(LOCAL_PATH)../../../../../cocos2dx/kazmath/include \
			$(LOCAL_PATH)../../../../../cocos2dx/keypad_dispatcher \
			$(LOCAL_PATH)../../../../../cocos2dx/label_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/layers_scenes_transitions_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/menu_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/misc_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/particle_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/platform \
			$(LOCAL_PATH)../../../../../cocos2dx/platform/android \
			$(LOCAL_PATH)../../../../../cocos2dx/script_support \
			$(LOCAL_PATH)../../../../../cocos2dx/shaders \
			$(LOCAL_PATH)../../../../../cocos2dx/sprite_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/support \
			$(LOCAL_PATH)../../../../../cocos2dx/text_input_node \
			$(LOCAL_PATH)../../../../../cocos2dx/textures \
			$(LOCAL_PATH)../../../../../cocos2dx/tilemap_parallax_nodes \
			$(LOCAL_PATH)../../../../../cocos2dx/touch_dispatcher \
			$(LOCAL_PATH)../../../../../CocosDenshion \
			$(LOCAL_PATH)../../../../../CocosDenshion/android \
			$(LOCAL_PATH)../../../../../CocosDenshion/blackberry \
			$(LOCAL_PATH)../../../../../CocosDenshion/emscripten \
			$(LOCAL_PATH)../../../../../CocosDenshion/include \
			$(LOCAL_PATH)../../../../../CocosDenshion/marmalade \
			$(LOCAL_PATH)../../../../../CocosDenshion/third_party \
			$(LOCAL_PATH)../../../../../CocosDenshion/tizen \
			$(LOCAL_PATH)../../../../../extensions \
			$(LOCAL_PATH)../../../../../extensions/AssetsManager \
			$(LOCAL_PATH)../../../../../extensions/CCBReader \
			$(LOCAL_PATH)../../../../../extensions/CocoStudio \
			$(LOCAL_PATH)../../../../../extensions/GUI \
			$(LOCAL_PATH)../../../../../extensions/LocalStorage \
			$(LOCAL_PATH)../../../../../extensions/network \
			$(LOCAL_PATH)../../../../../extensions/physics_nodes \
			$(LOCAL_PATH)../../../../../extensions/spine \
			$(LOCAL_PATH)../../../../../CocosDenshion/ \
			$(LOCAL_PATH)../../../../../external \
			$(LOCAL_PATH)../../../../../external/Box2D \
			$(LOCAL_PATH)../../../../../external/Box2D/Collision \
			$(LOCAL_PATH)../../../../../external/Box2D/Collision/Shapes \
			$(LOCAL_PATH)../../../../../external/Box2D/Common \
			$(LOCAL_PATH)../../../../../external/Box2D/Dynamics \
			$(LOCAL_PATH)../../../../../external/Box2D/Rope \
			$(LOCAL_PATH)../../../../../external/emscripten/system/include/GL \
			$(LOCAL_PATH)../../../../../external/emscripten/system/include/SDL \
			$(LOCAL_PATH)../../../../../external/emscripten/system/include/GLES2 \
			$(LOCAL_PATH)../../../../../external/emscripten/system/include/GLES \
			$(LOCAL_PATH)../../../../../external/libwebsockets \
			$(LOCAL_PATH)../../../../../external/sqlite3 \
			$(LOCAL_PATH)../../../../../external/libiconv/libcharset \
			$(LOCAL_PATH)../../../../../external/libiconv/lib \
			$(LOCAL_PATH)../../../../../external/libiconv/libcharset/include \
			$(LOCAL_PATH)../../../../../external/libiconv/include \
			$(LOCAL_PATH)../../../../../external/libiconv/srclib \
			$(LOCAL_PATH)../../../../../external/chipmunk/include/chipmunk \
			$(LOCAL_PATH)../../../../../XtcUtils
			
					 
LOCAL_SHARED_LIBRARIES:= libcocos2dxtc
					 
LOCAL_LDLIBS:=-llog -lGLESv2 

include $(BUILD_SHARED_LIBRARY)
