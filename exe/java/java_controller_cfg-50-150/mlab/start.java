package mlab;

public class start
{
	static int b2i(int i1,int i2,int i3,int i4)
	{
		return (i1<<24)|(i2<<16)|(i3<<8)|(i4);
	}
	static int d2a(int dec)
	{
		dec = dec & 0xF;
		return dec>9 ? 'A'-10+dec : '0'+dec;
	}

	public static void main(String[] args)
	{
	int i;
	int p;
	int[] r;

		/*
			Запись конфигурации.
		*/
		XYZCFG_V1 cfg = new XYZCFG_V1( );

		cfg.DAC( 0, 0x40000000, XYZCFG_V1.NOINV );
		cfg.OSC( 0, 0x00001643, 0x000048C2, "DAC_X" );
 
		cfg.DAC( 1, 0x40000000, XYZCFG_V1.NOINV );
		cfg.OSC( 1, 0x00001643, 0x000048C2, "DAC_Y" );

		cfg.DAC( 2, 0x40000000, XYZCFG_V1.NOINV );
		cfg.OSC( 2, 0x00001643, 0x000048C2, "DAC_Z" );

		if ( 0 != SetupDiag.m_EEWrite( 32, cfg.getImage() ) )
			throw new Error();

		/*
			Чтение всего образа eeprom.
		*/
		byte[] at24buf = new byte[128];

		if ( 0 != SetupDiag.m_EERead( 0, at24buf ) )
			throw new Error();

		r = new int[at24buf.length/4];
		for(p=0,i=0; i<r.length; i++) 
			r[i] = b2i(at24buf[p++],at24buf[p++],at24buf[p++],at24buf[p++]);
		Simple.xchgCreate("eeimage.bin",r);

		r = new int[2*at24buf.length+16];
		for(p=0,i=0; i<at24buf.length; i++)
		{
		byte symb;
			r[p++] = b2i('0','x',d2a(at24buf[i]>>4),d2a(at24buf[i]));
			symb = at24buf[i];
			if ( symb < (byte)0x20 || symb > (byte)0x7A )
				r[p++] = b2i(' ',' ',' ',' ');
			else
				r[p++] = b2i('(',symb,')',' ');

			if ((i&7)==7)
				r[p++] = b2i(' ',' ',13,10);
		}
		Simple.xchgCreate("eeimage.txt",r);
	}

}
