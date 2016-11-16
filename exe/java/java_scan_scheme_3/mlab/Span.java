package mlab;

public class Span
{
	protected int dT;
	protected int N;

	public Span( int dT )
	{
		this.dT = dT;
		this.N  = 1;
	}
	public Span( int dT, int N )
	{
		this.dT = dT;
		this.N  = N;
	}
	public int GetSize()
	{
		return this.N;
	}
	public int GetDT()
	{
		return this.dT;
	}
}

