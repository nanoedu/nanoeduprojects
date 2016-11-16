package mlab;

public class start
{
	public static void main(String[] args)
	{
	int[] block = new int[64];
	int i;
	int ts1;
	int ts2;
	int[] r = new int[3];

		i = Simple.checkLinkAdj( 10000 );
		Simple.DumpInt(i);
	
/*
		ts1 = Simple.GetSystemTicks();
		for(i=0; i<1000; i++)
		{
			Simple.bramWrite(14, i);
			//Simple.bramRead(14);
			//Simple.bramRead(14);
			//Simple.bramRead(14);
		}
		ts2 = Simple.GetSystemTicks();

		Simple.DumpInt( ts2-ts1 );
*/
		Simple.DumpInt( SetupDiag.getAdaptorVerId() );

		SetupDiag.ReadBlock(0, block);

		for(i=0; i<64; i++)
		{
			Simple.DumpInt( block[i] );
			//block[i] = 0xA0 + i&0xF;
		}
		//SetupDiag.WriteBlock(0, block);
	}

}
