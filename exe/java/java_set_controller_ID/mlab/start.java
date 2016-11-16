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
	static int barr2i(byte arr[], int off)
	{
	int ret;
		ret  =  arr[off++] << 24;
		ret |=  arr[off++] << 16;
		ret |=  arr[off++] << 8;
		ret |=  arr[off++];
		return ret;
	}
	static int int2i(int r[], int p, int val )
	{
		return p;
	}

	public static void main(String[] args)
	{
	int i;
	int p;
	int[] r;
	byte[] ci;

		XYZCFG_V1 cfg = new XYZCFG_V1( );

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

////////////////////
		Log log = new Log( 512 );
		log.str("\r\nEEPROM image:\r\n");

		for(p=0,i=0; i<at24buf.length; i++)
		{
		byte symb;
			symb = at24buf[i];
			log.xByte( symb );
			if ( symb < (byte)0x20 || symb > (byte)0x7A )
				log.str("    ");
			else
				log.B4( '(', symb, ')', ' ' );
			if ((i&7)==7)
				log.str("\r\n");
		}

		log.str("\r\n------------------\r\n[");

		// SN
		log.barr(at24buf, 0, 16); log.str("]\r\n[");

		// USER
		log.barr(at24buf, 16, 16); log.str("]\r\n------------------\r\n");

		ci = cfg.getImage();
		for(i=0; i<ci.length; i++) ci[i] = at24buf[32+i];
		if ( 0 != cfg.setImage(ci) )
		{
			log.str("Corrupted!\r\n");
		}
		else
		{
		int id = cfg.getID();
			log.str("ID: "); log.xInt(id);  log.str("\r\n");

			if ( id == 1 )
			{
				for(i=0; i<3; i++)
				{
					log.B4( 'X'+i, ':', 13, 10 );
					log.str("  START: "); log.xInt( cfg.getStartup(i) );
					log.str(", ");
					log.xInt( cfg.getMode(i) );
					log.str("\r\n");

					log.str("    OSC: "); log.xInt( cfg.getOscLoHi(i,0) );
					log.str(", ");
					log.xInt( cfg.getOscLoHi(i,1) );
					log.str(", [");
					log.barr( cfg.getOscName(i), 0, 8 );
					log.str("]\r\n");
				}
			}
		}


		Simple.xchgCreate("log.txt",log.getArray());
		

/*
CFG_SIZE[2],CFG_ID[4],
X/Y/Z: {STARTUP[4], MODE[4]
       OSC_LO[4], OSC_HI[4], OSC_NAME[8]},
CFG_CHECK[2].
*/
	}

}
