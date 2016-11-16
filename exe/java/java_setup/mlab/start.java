package mlab;

public class start
{
	public static void main(String[] args)
	{
	int[] block = new int[64];
	int i;

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
