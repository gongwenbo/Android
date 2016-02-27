

Android上多个运用不能同时调用AudioRecord - Android


原问题网址：
> http://stackoverflow.com/questions/6646313/android-test-if-audio-record-focus-is-available

Android: test if Audio-Record-Focus is available?

I am using AudioRecord to record audio for further proccessing. It seems that only one AudioRecord at a time can have access to the audio hardware. How can i check if the audio hardware is accessible, so that i can start recording? One possibility is to instantiate a AudioRecord instance and then check its state with AudioRecord.getState(). This will return, wether the AudioRecord-Instance was initialized properly. Is this the only way to do so? But there is another problem, which you have to address when doing audiorecording. What happens when another application wants to record? Is there any possibility to be notified if another application wants to record?

Thanks in advance! Tobias

PS: is there any possibility to check which sampling rates are supported on an android device?


回答：
该问题居然没有人回答？ 是太简单了么？等着我来回答的么。

