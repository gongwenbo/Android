

我们 以 cocos2dx游戏 加载 so库为例 来看看。 

Step 1. 虚拟机 加载 Activity   
**【cocos2d-x-2.2.3\projects\ProcessResearch\proj.android\src\com\cocos2dx\processresearch.java】**	

	public class ProcessResearch extends Cocos2dxActivity{
		
	    protected void onCreate(Bundle savedInstanceState){
			super.onCreate(savedInstanceState);	
		}
	
	    public Cocos2dxGLSurfaceView onCreateView() {
	    	Cocos2dxGLSurfaceView glSurfaceView = new Cocos2dxGLSurfaceView(this);
	    	// ProcessResearch should create stencil buffer
	    	glSurfaceView.setEGLConfigChooser(5, 6, 5, 0, 16, 8);
	    	
	    	return glSurfaceView;
	    }
	
	    static {
	        System.loadLibrary("cocos2dcpp");
	    }     
	}

System.loadLibrary("cocos2dcpp"); 
放在了 static 代码块里。
	
static代码块也叫静态代码块，是在类中独立于类成员的static语句块，可以有多个，位置可以随便放，它不在任何的方法体内，JVM加载类时会执行这些静态的代码块，如果static代码块有多个，JVM将按照它们在类中出现的先后顺序依次执行它们，每个代码块只会被执行一次。

Step 2. System.loadLibrary   
**Java.lang.System**

	public final class System {
	    ......
	    
	    public static void loadLibrary(String libName) {
	        SecurityManager smngr = System.getSecurityManager();
	        if (smngr != null) {
	            smngr.checkLink(libName);
	        }
	        Runtime.getRuntime().loadLibrary(libName, VMStack.getCallingClassLoader());
	    }
	
	    ......
	}


Step 2. Runtime.loadLibrary  
**libcore/luni/src/main/java/java/lang/Runtime.java**

	public class Runtime {
	    ......
	
	    void loadLibrary(String libraryName, ClassLoader loader) {
	        if (loader != null) {
	            String filename = loader.findLibrary(libraryName);
	            if (filename == null) {
	                throw new UnsatisfiedLinkError("Couldn't load " + libraryName + ": " +
	                        "findLibrary returned null");
	            }
	            String error = nativeLoad(filename, loader);
	            if (error != null) {
	                throw new UnsatisfiedLinkError(error);
	            }
	            return;
	        }
	
	        String filename = System.mapLibraryName(libraryName);
	        List<String> candidates = new ArrayList<String>();
	        String lastError = null;
	        for (String directory : mLibPaths) {
	            String candidate = directory + filename;
	            candidates.add(candidate);
	            if (new File(candidate).exists()) {
	                String error = nativeLoad(candidate, loader);
	                if (error == null) {
	                    return; // We successfully loaded the library. Job done.
	                }
	                lastError = error;
	            }
	        }
	
	        if (lastError != null) {
	            throw new UnsatisfiedLinkError(lastError);
	        }
	        throw new UnsatisfiedLinkError("Library " + libraryName + " not found; tried " + candidates);
	    }
	
	    ......
	}	
