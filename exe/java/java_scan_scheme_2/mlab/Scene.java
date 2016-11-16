package mlab;

public class Scene
{
	protected int[] pcfg;
	public int i;
	public Scene( Port[] port )
	{
	int i;
	int k;
	int j;
	int size;
	int indx = 0;

		i =0 ;

		size = 1; // кол-во портов
		for(i=0; i<port.length; i++)
		{
		Span[] span;
			size += 1 + 1; // id, общее кол-во всех интервалов
			span = port[i].GetSpan();
			for(k=0; k<span.length; k++)
			{	
				size += span[k].GetSize(); // число интервалов
			}
		}
		pcfg = new int[size];
		pcfg[indx++] = port.length;
		for(i=0; i<port.length; i++)
		{
			pcfg[indx++] = port[i].GetID();
			pcfg[indx++] = port[i].GetSpanLength();
		}		
		for(i=0; i<port.length; i++)
		{
		Span[] span;
		int dT;
			span = port[i].GetSpan();
			for(k=0; k<span.length; k++)
			{
				dT = span[k].GetDT();
				for(j=0; j<span[k].GetSize(); j++)
					pcfg[indx++] = dT;
			}
		}		
	}

	public int[] getTemplate()
	{
		return pcfg;
	}

	public static native int  createScene( int[] templ, int N );
	public static native void releaseScene( int handle );

	public static native void startLoad( int handle, int id, int n );
	public static native void load( int handle, int val );
	public static native void load( int handle, int val, int dv, int n );

	public static native void run( int handle );
	public static native int  wait( int handle, int ms_timeout );
	public static native int  status( int handle );

	public static native int[] get( int handle, int id );
	public static native int  getPort( int id );
}