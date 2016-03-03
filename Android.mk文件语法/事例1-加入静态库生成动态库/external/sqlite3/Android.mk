LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := sqlite3

LOCAL_MODULE_FILENAME := libsqlite3

LOCAL_SRC_FILES :=sqlite/shell.c \
								sqlite/sqlite3.c
															
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include_android

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
            
include $(BUILD_STATIC_LIBRARY)

