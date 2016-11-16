package mlab;

public class Port
{
	public static final int IN  = 0;
	public static final int OUT = 0x80000000;

	protected int ID;

	protected Span[] span;

	public Port( int id, Span[] span )
	{
		this.ID = id;
		this.span = span;
	}
	int GetID()
	{
		return this.ID;
	}
	Span[] GetSpan()
	{
		return this.span;
	}
	int GetSpanLength()
	{
	int i;
	int size;
		for(i=0,size=0; i<span.length; i++)

		size += span[i].GetSize();

		return size;
	}
}

