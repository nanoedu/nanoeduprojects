package mlab;

public class Scannew
{
public static final int N = 100;
public static final int P = 100;

public static final int pause = 50; // ����� � ����� mks
public static final int steps = 32; // ����� ����������� ����� ������� mks
	public static void main(String[] arg)
	{
		int[] data_out;
		int[] data_in;
		int[] code;

		code = new int[34];
//----- ��������� -- "2D point" --------------------
		code[0]  = Dxchg.CODE_SIGNATURE;
		code[1]  = 0x00030001;
		code[2]  = code.length;
//----- ��� ----------------------------------------

// ������ ����������� � ������� �����
                code[3]  = 0x00000000 + (18<<16) + (0<<0);
		code[4]  = 0x20000000;
		// �������� �����������
                code[5]  = 0x00000000;
		code[6]  = 0x10000008;
// ����� ����� ����������� �� z dz  �������� �� dataout
                code[7]  = 0x00008000 + (24<<16) + (0<<0);
		code[8]  = 0x20000000;
		// �������� �����������
                code[9]  = 0x00000000;
		code[10]  = 0x10000008;
// ������ ����������� � �� z -dz
                code[11]  = 0x00000000 + (28<<16) + (0<<0);
		code[12]  = 0x20000000;
		// �������� �����������
                code[13]  = 0x00000000;
		code[14]  = 0x10000008;
                  
	 	// ���������� ����� �����
                code[15]  = 0x00000000 + (0<<16) + (31<<0);
                code[16] = 0x40000000 + pause - 1;
		// ������� 
                code[17] = 0x80000000 + (3<<16) + 0;   
//----- ������ ������ ����������� � ����� ---------
		code[18] = 4;
		code[19] = Dxchg.OUTP_DIRY;
		code[20] = Dxchg.OUTP_DIRX;
		code[21] = Dxchg.OUTP_Y;
		code[22] = Dxchg.OUTP_X;

//----- ������ ������ ����������� � ����� z  dz-------
		code[24] = 3;
		code[25] = Dxchg.OUTP_DIRZ;
		code[26] = Dxchg.OUTP_Z;
		code[27] = -1;


//----- ������ ������ ����������� � ����� z  -dz-------
		code[28] = 2;
		code[29] = Dxchg.OUTP_DIRZ;
		code[30] = Dxchg.OUTP_Z;


//----- ������ ������ ����������� ------------------
		code[31] = 1;
		code[32] = Dxchg.H;

		int Grid = 0x00800000; // ��� �����
		int Snom = 0x028F5C29; // 1.0/50 - ������ ������� ����� 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, �� 1 ���
		int Vtrvl = Vtrvl_nom / steps;

     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );

		data_in = new int[N*P*1]; // ������ #15 � ������ �����

		data_out = new int[N*P*4]; // ������ #10 � ������ �����

		int i = 0;
		for ( int y = 0; y < N; ++y ) // �� Y
		{
			for ( int x = 0; x < P; ++x ) // �� X
			{
				if ( x == 0 )
				{
					if ( y == 0 )
						data_out[i++] = -Vtrvl * 10;
					else
						data_out[i++] = Vtrvl;
					data_out[i++] = -Vtrvl * 10;
				}
				else
				{
					data_out[i++] = 0;
					data_out[i++] = Vtrvl;
				}
				data_out[i++] = Grid*y;
				data_out[i++] = Grid*x;
			}
		}

		Dxchg.ExecuteScan( data_out, data_in, code, N*P );
		Simple.DumpInt( data_in[data_in.length-1]-data_in[0] );
		Simple.xchgCreate( "data", data_in );
   }
	
}

















