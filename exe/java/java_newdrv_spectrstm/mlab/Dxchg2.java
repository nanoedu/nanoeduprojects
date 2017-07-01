package mlab;

public class Dxchg2
{
	public static final int CODE_SIGNATURE = 0xDDDD0001;
	public static final int PORT_X = 0;
	public static final int PORT_Y = 1;
	public static final int PORT_Z = 2;
	public static final int PORT_DIRX = 3;
	public static final int PORT_DIRY = 4;
	public static final int PORT_DIRZ = 5;
        public static final int PORT_H   = ( 2 );      //Z
        public static final int PORT_PH  = ( 0 );
        public static final int PORT_ERR = ( 1 );
        public static final int PORT_I   = ( 4 );
	public static final int PORT_CNTR = ( 5 );    //   timer
	public static native void ExecuteScan( int[] data_out, int[] data_in, int[] code, int count );
}
