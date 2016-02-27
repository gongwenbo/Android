


# 安卓录音说明

 - 简介

 Android提供了两个API用于实现录音功能：android.media.AudioRecord、android.media.MediaRecorder。

现在大致总结下：

**MediaPlayer和AudioTrack播放Audio的区别与联系**
>http://blog.csdn.net/ameyume/article/details/7885744

MediaRecorder和AudioRecord都可以录制音频，区别是MediaRecorder录制的音频文件是经过压缩后的，需要设置编码器。并且录制的音频文件可以用系统自带的Music播放器播放。

而AudioRecord录制的是PCM格式的音频文件，需要用AudioTrack来播放，AudioTrack更接近底层。


## MediaRecorder和MediaPlayer类

如果用户只想录音后写入文件或从文件中取得音频流进行播放，那么直接使用MediaRecorder和MediaPlayer类是首选方案。

录音格式有如下:
acc 格式。

创建MediaRecorder类对象的代码如下：  
 - 功能：开始录音：
	
	private MediaRecorder mMediaRecorder = null;

	mMediaRecorder = new MediaRecorder();
	mMediaRecorder.setAudioSource( MediaRecorder.AudioSource.MIC );			// 音频源：指的是从哪里采集音频。这里我们当然是从麦克风采集音频，所以此参数的值为MIC
	mMediaRecorder.setOutputFormat( MediaRecorder.OutputFormat.AAC_ADTS );	// OutputFormat内部类，定义了音频输出的格式，主要包含MPEG_4、THREE_GPP、RAW_AMR……等。
	mMediaRecorder.setAudioEncoder( MediaRecorder.AudioEncoder.AAC );		// mediaRecorder.setAddioEncoder()方法可以设置音频的编码
	mMediaRecorder.setAudioSamplingRate( 22050 );							// 采样率：音频的采样频率，每秒钟能够采样的次数，采样率越高，音质越高。给出的实例是44100、22050、11025但不限于这几个参数。
	mMediaRecorder.setAudioChannels(1);	        
	mMediaRecorder.setOutputFile(mFileName);								// 设置录音之后，保存音频文件的位置

 - 功能：停止录音：

		mMediaRecorder.stop();

## AudioRecord和AudioTrack类

**参考资料**：  
**Android入门（9）AudioRecord和AudioTrack类的使用**
>http://blog.sina.com.cn/s/blog_6309e1ed0100j1rw.html


**Android 实时录音和回放,边录音边播放 (KTV回音效果)**  
>http://www.cnblogs.com/mythou/p/3241925.html

AudioRecord和AudioTrack类是Android获取和播放音频流的重要类，放置在android.media包中。与该包中的MediaRecorder和MediaPlayer类不同，AudioRecord和AudioTrack类在获取和播放音频数据流时无需通过文件保存和文件读取，可以动态地直接获取和播放音频流，在实时处理音频数据流时非常有用。

当然，如果用户只想录音后写入文件或从文件中取得音频流进行播放，那么直接使用MediaRecorder和MediaPlayer类是首选方案，因为这两个类使用非常方便，而且成功率很高。而AudioRecord和AudioTrack类的使用却比较复杂，我们发现很多人都不能成功地使用这两个类，甚至认为Android的这两个类是不能工作的。
    
其实，AudioRecord和AudioTrack类的使用虽然比较复杂，但是可以工作，我们不仅可以很好地使用了这两个类，而且还通过套接字（Socket）实现了音频数据的网络传输，做到了一端使用AudioRecord获取音频流然后通过套接字传输出去，而另一端通过套接字接收后使用AudioTrack类播放。

下面是我们对AudioRecord和AudioTrack类在使用方面的经验总结：  

（1）创建AudioRecord和AudioTrack类对象：创建这两个类的对象比较复杂，通过对文档的反复和仔细理解，并通过多次失败的尝试，并在北理工的某个Android大牛的网上的文章启发下，我们也最终成功地创建了这两个类的对象。创建AudioRecord和AudioTrack类对象的代码如下：

AudioRecord类：
         m_in_buf_size =AudioRecord.getMinBufferSize(8000,
                        AudioFormat.CHANNEL_CONFIGURATION_MONO,
                        AudioFormat.ENCODING_PCM_16BIT);
   
         m_in_rec = new AudioRecord(MediaRecorder.AudioSource.MIC,
         8000,
         AudioFormat.CHANNEL_CONFIGURATION_MONO,
         AudioFormat.ENCODING_PCM_16BIT,
         m_in_buf_size) ;

AudioTrack类：

		m_out_buf_size = android.media.AudioTrack.getMinBufferSize(8000,
                          AudioFormat.CHANNEL_CONFIGURATION_MONO,
                          AudioFormat.ENCODING_PCM_16BIT);
         m_out_trk = new AudioTrack(AudioManager.STREAM_MUSIC, 8000,
                                       AudioFormat.CHANNEL_CONFIGURATION_MONO,
                                       AudioFormat.ENCODING_PCM_16BIT,
                                       m_out_buf_size,
                                       AudioTrack.MODE_STREAM);

（2）关于AudioRecord和AudioTrack类的监听函数，不用也行。
