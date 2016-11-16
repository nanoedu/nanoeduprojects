package mlab;

public class Dxchg
{
	public Dxchg( )
	{
		CreateNewScan();
	}
	public static native void  CreateNewScan( );
	public static native void  SetO( int port, int val );
	public static native void  GetI( int port );
	public static native void  Wait( int tout );
	public static native void  Goto( int x, int y, int z );
	public static native void  SetScanPorts( int[] ports );
	public static native  int  ExecuteScan( );
	public static native  int  WaitScanComplete( int tout );
	public static native int[] GetResults( );
}
