package mlab;

public class Dxchg
{
	public static final int CODE_SIGNATURE = 0xDDDD0001;
	public static final int OUTP_X = 0;
	public static final int OUTP_Y = 1;
	public static final int OUTP_Z = 2;
	public static final int OUTP_DIRX = 3;
	public static final int OUTP_DIRY = 4;
	public static final int OUTP_DIRZ = 5;
	public static native void ExecuteScan( int[] data_out, int[] data_in, int[] code, int count );
}
