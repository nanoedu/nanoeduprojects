package mlab;

public class Bram
{
	protected int id;

	public Bram( String name )
	{
		this.id = bramGetIdByName( name.toCharArray() );
	}
	public Bram( int id )
	{
		this.id = id;
	}
	int Read()
	{
		return bramRead( this.id );
	}
	void Write( int value )
	{
		bramWrite( this.id, value );
	}

	public static native int  bramGetIdByName(char[] name);
	public static native int  bramRead(int id);
	public static native void bramWrite(int id, int value);

}

