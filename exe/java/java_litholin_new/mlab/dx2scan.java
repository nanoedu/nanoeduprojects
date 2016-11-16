package mlab; //06.11.12

public class dx2scan
{
	static final int PORT_COS_X = ( 3 );
	static final int PORT_COS_Y = ( 4 );
	static final int PORT_COS_Z = ( 5 );

	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

	static final int PORT_H = ( 0 );

	static final int PORT_CNTR = ( 5 );

	public static void main(String[] args)
	{
	int i;
	int n;
	int dac      = 0x00000000;
	int dac_step = 0x01000000;
	int[] res;

	int uVector;

		Dxchg dxchg = new Dxchg();

		dxchg.SetScanPorts( new int[] {PORT_X,PORT_COS_X, 0,
		                               PORT_Y,PORT_COS_Y, 0,
		                               -1,-1,-1} );

		for(i=0; i<16; i++)
		{
			dxchg.Goto( dac, 0, 0 );
			dxchg.GetI( PORT_CNTR );
			dxchg.Wait( 100 );
			dxchg.GetI( PORT_CNTR );
			dac = dac + dac_step;
		}

		for(i=0; i<16; i++)
		{
			dac = dac - dac_step;
			dxchg.Goto( dac, 0, 0 );
			dxchg.GetI( PORT_CNTR );
			dxchg.Wait( 100 );
			dxchg.GetI( PORT_CNTR );
		}

		dxchg.ExecuteScan();
		dxchg.WaitScanComplete( 1000 );
		res = dxchg.GetResults();

		Simple.DumpInt(res.length);
		if ( res.length > 3 )
		{
			Simple.DumpInt(res[0]);
			Simple.DumpInt(res[1]);
			Simple.DumpInt(res[2]);
			Simple.DumpInt(res[3]);
			Simple.DumpInt(res[4]);
		}
	}

}
