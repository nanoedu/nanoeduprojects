package mlab;

public class Bram
{
	protected int id;

	public Bram( String name )
	{
		this.id = Simple.bramID( name );
	}
	public Bram( int id )
	{
		this.id = id;
	}
	int Read()
	{
		return Simple.bramRead( this.id );
	}
	void Write( int value )
	{
		Simple.bramWrite( this.id, value );
	}
}

