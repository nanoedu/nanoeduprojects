package mlab;

/*
CFG_SIZE[2],CFG_ID[4],
X/Y/Z: {STARTUP[4], MODE[4]
       OSC_LO[4], OSC_HI[4], OSC_NAME[8]},
CFG_CHECK[2].
*/

public class XYZCFG_V1
{
	static final int INV = 1;
	static final int NOINV = 0;
	static final int V1_SIZE = 80;

	protected byte[] img;
	protected int id;

	public XYZCFG_V1( )
	{
		img = new byte[V1_SIZE];
		img[0] = 0;
		img[1] = V1_SIZE;

		img[2] = (byte)(id>>24);
		img[3] = (byte)(id>>16);
		img[4] = (byte)(id>>8);
		img[5] = (byte)(id);
	}
	public void DAC( int n, int startup, int mode )
	{
		int p = 6 + 24*n;
		
		img[p++] = (byte)(startup>>24);
		img[p++] = (byte)(startup>>16);
		img[p++] = (byte)(startup>>8);
		img[p++] = (byte)(startup);

		img[p++] = (byte)(mode>>24);
		img[p++] = (byte)(mode>>16);
		img[p++] = (byte)(mode>>8);
		img[p++] = (byte)(mode);
	}
	public void OSC( int n, int lo, int hi, String descr )
	{
		int i;
		int p = 6 + 24*n + 8;
		char[] s;

		img[p++] = (byte)(lo>>24);
		img[p++] = (byte)(lo>>16);
		img[p++] = (byte)(lo>>8);
		img[p++] = (byte)(lo);

		img[p++] = (byte)(hi>>24);
		img[p++] = (byte)(hi>>16);
		img[p++] = (byte)(hi>>8);
		img[p++] = (byte)(hi);

		for(i=0; i<8; i++) img[p+i] = 0;

		s = descr.toCharArray();
		for(i=0; i<s.length && i<8; i++) img[p++] = (byte)s[i];
	}
	public byte[] getImage( )
	{
		int i;
		byte crc8;

		crc8 = 0;
		for(i=0; i<img.length-2; i++) crc8 = crc8C( crc8, img[i] );

		img[78] = 0;
		img[79] = crc8;

		return img;
	}
	public int setImage( byte[] img )
	{
		int i;
		byte crc8;

		if ( img.length != V1_SIZE ) return -1;
		
		crc8 = 0;
		for(i=0; i<img.length-2; i++) crc8 = crc8C( crc8, img[i] );

		if ( 0 != img[78] && crc8 != img[79] ) return -1;

		for(i=0; i<img.length; i++) this.img[i] = img[i];

		return 0;
	}

	public int getID( )
	{
	int id;
		id  = (img[2] & 0xFF )<< 24;
		id |= (img[3] & 0xFF )<< 16;
		id |= (img[4] & 0xFF )<< 8;
		id |= (img[5] & 0xFF );

		return id;
	}
	public int getStartup( int ch )
	{
		int startup;
		int p = 6 + 24*ch;
		
		startup  = (img[p++] & 0xFF) << 24;
		startup |= (img[p++] & 0xFF) << 16;
		startup |= (img[p++] & 0xFF) << 8;
		startup |= (img[p++] & 0xFF);

		return startup;
	}
	public int getMode( int ch )
	{
		int mode;
		int p = 6 + 24*ch + 4;
		
		mode  = (img[p++] & 0xFF) << 24;
		mode |= (img[p++] & 0xFF) << 16;
		mode |= (img[p++] & 0xFF) << 8;
		mode |= (img[p++] & 0xFF);

		return mode;
	}
	public int getOscLoHi( int ch, int hi )
	{
		int lohi;
		int p = 6 + 24*ch + 8;

		if (hi != 0) p = p + 4;

		lohi  = (img[p++] & 0xFF) << 24;
		lohi |= (img[p++] & 0xFF) << 16;
		lohi |= (img[p++] & 0xFF) << 8;
		lohi |= (img[p++] & 0xFF);

		return lohi;
	}
         public int getOscLoHiMY( int ch, int hi )
	{
		int lohi;
		int p = 6 + 24*ch + 8;

		if (hi != 0) p = p + 4;

		lohi  = (img[p++] & 0xFF) ;
		lohi |= (img[p++] & 0xFF) << 8;
		lohi |= (img[p++] & 0xFF) << 16;
		lohi |= (img[p++] & 0xFF) << 24;

		return lohi;
	}
	public byte[] getOscName( int ch )
	{
		int i;
		byte[] name = new byte[8];
		int p = 6 + 24*ch + 16;
		
		for(i=0; i<name.length; i++) name[i] = img[p+i];
		return name;
	}
        public int getOscNameI( int ch,int delta )
	{
		int name;
		int p = 6 + 24*ch + 16;
		name = (img[p+delta+3]<<24)|img[p+delta+2]<<16|(img[p+delta+1]<<8)|img[p+delta];
		return name;
	} 
	static public byte crc8C(byte crc, byte data)
	{
	int i;
	boolean fb;
		for(i=0; i<8; i++)
		{
			fb = (( crc & (byte)0x01 ) ^ ( data & (byte)0x01 ))==0 ? false : true;
			crc >>= 1;
			crc = (byte)(crc & 0x7F);
			data >>= 1;
			if ( fb ) crc = (byte)(crc ^ (byte)0x8C);
		}
		return crc;
	}
}


