package mlab;

public class Simple
{
	public static native int  bramRead(int id);
	public static native void bramWrite(int id, int value);

	private static native void xchgCreate(char[] name, int[] data);
	public static void xchgCreate(String name, int[] data)
	{
		xchgCreate(name.toCharArray(), data);
	}

	private static native int[] xchgGet(char[] name);
	public static int[] xchgGet(String name)
	{
		return xchgGet(name.toCharArray());
	}

	public static native void xchgConnect();

	public static native void DumpInt(int i);

	public static native void Sleep(int ms);

	public static native int GetOpCodeCnt(int rst);
        public static native void  jvioCreate(byte ID, short W, short N, short Type, short HiLvl, short LoLvl);
	public static native short jvioWrite (byte ID, short W, int[] arr, int off, short N);
	public static native short jvioRead  (byte ID, short W, int[] arr, int off, short N);
	public static native void  jvioClose (byte ID);
	public static native void  jvioWait  (byte ID, short N, boolean bRead, int timeout);
	public static native void  jvioFireEvent (byte ID);

	public static native void    timerSet(int tout);
	public static native boolean timerCheck();
	public static native int     timerGetTimeout();

//	public static int fcupID(String name)
//	{
//		return lfbID(name.toCharArray());
//	}
	public static native void fcupBypass(int ID, boolean bBypassOn);

}

