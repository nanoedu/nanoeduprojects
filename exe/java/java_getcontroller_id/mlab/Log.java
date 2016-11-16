package mlab;

public class Log
{
	protected byte b[];
	protected int indx;

	protected int d2a(int dec)
	{
		dec = dec & 0xF;
		return dec>9 ? 'A'-10+dec : '0'+dec;
	}

	public Log( int sz )
	{
		b = new byte[sz*4];
		indx = 0;
	}
	public void str(String s)
	{
	int i;
	char ca[] = s.toCharArray();
		for(i=0; i<ca.length; i++) b[indx++] = (byte)ca[i];
	}
	public void B4(int b1, int b2, int b3, int b4)
	{
		b[indx++] = (byte)b1;
		b[indx++] = (byte)b2;
		b[indx++] = (byte)b3;
		b[indx++] = (byte)b4;
	}
	public void xByte(byte val)
	{
		b[indx++] = '0'; b[indx++] = 'x';
		b[indx++] = (byte)d2a(val>>4); 
		b[indx++] = (byte)d2a(val);
	}
	public void xInt(int val)
	{
		b[indx++] = '0'; b[indx++] = 'x';
		b[indx++] = (byte)d2a(val>>28); 
		b[indx++] = (byte)d2a(val>>24); 
		b[indx++] = (byte)d2a(val>>20); 
		b[indx++] = (byte)d2a(val>>16); 
		b[indx++] = (byte)d2a(val>>12); 
		b[indx++] = (byte)d2a(val>>8); 
		b[indx++] = (byte)d2a(val>>4); 
		b[indx++] = (byte)d2a(val);
	}
	
	public void barr(byte[] arr, int off, int sz)
	{
	int i;
		for(i=0; i<sz; i++) b[indx++] = arr[off++];
	}

	int[] getArray()
	{
		int i;
		int val;
		int pos;
		int r[] = new int[b.length/4];

		for(i=indx; i<b.length; i++) b[i] = ' ';

		for(i=0,pos=0; i<r.length; i++)
		{
			val  = ( b[pos++] << 24 ) & 0xFF000000;
			val |= ( b[pos++] << 16 ) & 0x00FF0000;
			val |= ( b[pos++] <<  8 ) & 0x0000FF00;
			val |= ( b[pos++] )       & 0x000000FF;	

			r[i] = val;
		}
		return r;
	}
}
