package mlab;

public class Scannew
{
public static final int N = 100;
public static final int P = 100;

public static final int pause = 50; // ����� � ����� mks
public static final int steps = 32; // ����� ����������� ����� ������� mks
	static final int PORT_DIR_X = ( 3 );
	static final int PORT_DIR_Y = ( 4 );
	static final int PORT_DIR_Z = ( 5 );

	static final int PORT_X = ( 0 );
	static final int PORT_Y = ( 1 );
	static final int PORT_Z = ( 2 );

	static final int PORT_H = ( 2 );      //Z

	static final int PORT_CNTR = ( 5 );    //   timer

	public static void main(String[] arg)
	{
		int[] data_out;
		int[] data_in;
		int[] code;

		code = new int[43];
//----- ��������� -- "2D point" --------------------
		code[0]  = Dxchg.CODE_SIGNATURE;
		code[1]  = 0x00030001;
		code[2]  = code.length;
//----- ��� ----------------------------------------

// ������ ����������� � ������� �����
                code[3]  = 0x00000000 + (29<<16) + (0<<0);
		code[4]  = 0x20000000;
		// �������� �����������
                code[5]  = 0x00000000;
		code[6]  = 0x10000008;    //?????
// ����� ����� ����������� �� z dz  �������� �� dataout
                code[7]  = 0x00008000 + (34<16) + (0<<0);
		code[8]  = 0x20000000;
		// �������� �����������
                code[9]   = 0x00000000;
		code[10]  = 0x10000008;
// ������ ����������� � �� z -dz
                code[11]  = 0x00000000 + (38<<16) + (0<<0);
		code[12]  = 0x20000000;
		// �������� �����������
                code[13]  = 0x00000000;
		code[14]  = 0x10000008;

	 	// ���������� ����� �����
                code[15]  = 0x00000000 + (0<<16) + (41<0);
                code[16]  = 0x40000000 + pause - 1;
		// �������
                code[17]  = 0x80000000 + (3<<16) + P-1;  //N ��������
//  �������� ��� �� ������� ����������
               / ������ ����������� � ������� �����
                code[18]  = 0x00000000 + (25<<16) + (0<<0);
		code[19]  = 0x20000000;
		// �������� �����������
                code[20]  = 0x00000000;
		code[21]  = 0x10000008;    //?????

	 	// ���������� ����� �����
                code[22]  = 0x00000000 + (0<<16) + (37<0);
                code[23]  = 0x40000000 + pause - 1;
		// �������
                code[24]  = 0x80000000 + (18<<16) + P-1;  //N ��������
 //�������� ������� � ����� 0,0
                code[25]  = 0x00000000 + (29<<16) + (0<<0);
		code[26]  = 0x20000000;
		// �������� �����������
                code[27]  = 0x00000000;
		code[28]  = 0x10000008;    //?????

//----- ������ ������ ����������� � ����� ---------
		code[29] = 4;
		code[30] = PORT_DIR_Y;
		code[31] = PORT_DIR_X;
		code[32] = PORT_Y;
		code[33] = PORT_X;

//----- ������ ������ ����������� � ����� z  dz-------
		code[34] = 3;
		code[35] = PORT_DIR_Z;
		code[36] = PORT_Z;
		code[37] = -1;


//----- ������ ������ ����������� � ����� z  -dz-------
		code[38] = 2;
		code[39] = PORT_DIR_Z;
		code[40] = PORT_Z;


//----- ������ ������ ����������� ------------------
		code[41] = 1;
		code[42] = PORT_H;

//

		int Grid = 0x00800000; // ��� �����
		int Snom = 0x028F5C29; // 1.0/50 - ������ ������� ����� 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, �� 1 ���
		int Vtrvl = Vtrvl_nom / steps;

     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );

		data_in = new int[2*N*P*1]; // ������ #15 � ������ �����

		data_out = new int[N*P*4]; // ������ #18 � ������ �����    ????

		int i = 0;
		for ( int y = 0; y < N; ++y ) // �� Y
		{
			for ( int x = 0; x < P; ++x ) // �� X
			{
				data_out[i++] = 0;                //vy
				data_out[i++] = Vtrvl;            //vx
				data_out[i++] = Grid*y;
				data_out[i++] = Grid*x;
                                data_out[i++] =  dz[x];
                                data_out[i++] =  dt[x];
                                data_out[i++] = -dz[x];
			}
                      	for ( int x = P-1; x >=0 ; --x ) // �� X
			{
				data_out[i++] = 0;
				data_out[i++] = -Vtrvl;
				data_out[i++] = Grid*y;
				data_out[i++] = Grid*x;
  			}

                                data_out[i++] = Vtrvl;
				data_out[i++] = 0;
				data_out[i++] = Grid*(y+1);
				data_out[i++] = Grid*x;

		}

		Dxchg.ExecuteScan( data_out, data_in, code, N );  //P
		Simple.DumpInt( data_in[data_in.length-1]-data_in[0] );
		Simple.xchgCreate( "data", data_in );
   }

}

















