package mlab;

public class JVIO
{
	public static final int SHORT_MAX = 32767;

	public static final int FIFO = 0;
	public static final int BUF  = 1;
	
	public static final boolean WAIT_ALL = true;
	public static final boolean WAIT_FRAG = false;

	protected int ID;
	protected int W;
	public JVIO(int ID, int W, int N, int Type, int HiLvl, int LoLvl)
	{
		this.ID = ID;
		this.W  = W;
		if ( HiLvl > N ) HiLvl = N;
		if ( LoLvl < 0 ) LoLvl = 0;
		jvio_create((byte)ID, (short)W, (short)N, (short)Type, (short)HiLvl, (short)LoLvl);
	}
	
	public void Close() 
	{
		Simple.jvioClose((byte)this.ID);
	}
	
	public void Invalidate() 
	{
		Simple.jvioFireEvent((byte)this.ID);
	}

	public short Read(int[] arr, int N, int timeout, boolean bWaitAll) 
	{
		return ReadWrite(true, arr, N, timeout, bWaitAll);
	}
	public short Write(int[] arr, int N, int timeout)
	{	
		return ReadWrite(false, arr, N, timeout, true);
	}
	
	protected short ReadWrite(boolean bRead, int[] arr, int N, int timeout, boolean bWaitAll)
	{
		short off = 0;
		short processed;

		Simple.timerSet(timeout);

		if ( N > SHORT_MAX ) N = SHORT_MAX;

		for(; N != 0 ;)
		{
			if (bRead)
				processed = Simple.jvioRead((byte)this.ID, (short)this.W, arr, off, (short)N);
			else
				processed = Simple.jvioWrite((byte)this.ID, (short)this.W, arr, off, (short)N);
			
			off += processed;
			N -= processed;
			
			if ( false == bWaitAll && 0 != processed ) break;
			
			if ( 0 == processed ) Simple.jvioWait((byte)this.ID, (short)1, bRead, Simple.timerGetTimeout());
			
			if ( Simple.timerCheck() ) break;
		}
		return off;
	}
	
	public short WriteEx(int[] arr, int offset, int N, int timeout)
	{
		short wrsz = 0;
		short processed;

		Simple.timerSet(timeout);

		if ( N > SHORT_MAX ) N = SHORT_MAX;

		for(; N != 0 ;)
		{
			processed = Simple.jvioWrite((byte)this.ID, (short)this.W, arr, offset, (short)N);
			
			offset += processed;
			wrsz += processed;
			N -= processed;
			
			if ( 0 == processed ) Simple.jvioWait((byte)this.ID, (short)1, false, Simple.timerGetTimeout());
			
			if ( Simple.timerCheck() ) break;
		}
		return wrsz;
	}
	
	protected static void jvio_create(byte ID, short W, short N, short Type, short HiLvl, short LoLvl)
	{
		Simple.jvioCreate(ID, W, N, Type, HiLvl, LoLvl);
	}
}

