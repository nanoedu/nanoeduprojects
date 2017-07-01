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

		code = new int[49];
//----- ��������� -- "2D point" --------------------
		code[0]  = Dxchg.CODE_SIGNATURE;
		code[1]  = 0x00030002;  //2->1 ��� ��������
		code[2]  = code.length;
//----- ��� ----------------------------------------
//repeat
                code[3]= 0x80000000 + (5<<16) + P;   
                code[4]= 0x80000000 + (3<<16) + P; 
// ������ ����������� � ������� �����
                code[5]  = 0x00000000 + (29<<16) + (0<<0);
		code[6]  = 0x20000000;
		// �������� �����������
                code[7]  = 0x00000000;
		code[8]  = 0x10000008;    //?????
// ����������� �� z dz 
                code[9]  = 0x00000000 + (34<16) + (0<<0);
		code[10]  = 0x20000000;
		// �������� �����������
                code[11]   = 0x00000000;
		code[12]  = 0x10000008;
 // ����� ����� ����������� �� z dz  �������� �� dataout
          
                code[13]  = 0x00008000 + (47<<16) + (0<<0);  //pause from dataout
		code[14]  = 0x00000000;


// ������ ����������� � �� z -dz
                code[15]  = 0x00000000 + (42<<16) + (0<<0);
		code[16]  = 0x20000000;
		// �������� �����������
                code[17]  = 0x00000000;
		code[18]  = 0x10000008;

	 	// ���������� ����� �����
                code[19]  = 0x00000000 + (0<<16) + (41<0);
                code[20]  = 0x40000000 + pause - 1;
		// �������
                code[21]  = 0x80000000 + (5<<16) + 0;  //N ��������
//  �������� ��� �� ������� ����������
               / ������ ����������� � ������� �����
                code[22]  = 0x00000000 + (33<<16) + (0<<0);
		code[23]  = 0x20000000;
		// �������� �����������
                code[24]  = 0x00000000;
		code[25]  = 0x10000008;    //?????

	 	// ���������� ����� �����
                code[26]  = 0x00000000 + (0<<16) + (45<0);
                code[27]  = 0x40000000 + pause - 1;
		// �������
                code[28]  = 0x80000000 + (22<<16) + 0;  //P ��������
 //�������� ������� � ����� 0,0
                code[29]  = 0x00000000 + (33<<16) + (0<<0);
		code[30]  = 0x20000000;
		// �������� �����������
                code[31]  = 0x00000000;
		code[32]  = 0x10000008;    //?????

//----- ������ ������ ����������� � ����� ---------
		code[33] = 4;
		code[34] = PORT_DIR_Y;
		code[35] = PORT_DIR_X;
		code[36] = PORT_Y;
		code[37] = PORT_X;

//----- ������ ������ ����������� � ����� z  dz-------
		code[38] = 3;
		code[39] = PORT_DIR_Z;
		code[40] = PORT_Z;
		code[41] = -1;


//----- ������ ������ ����������� � ����� z  -dz-------
		code[42] = 2;
		code[43] = PORT_DIR_Z;
		code[44] = PORT_Z;


//----- ������ ������ ����������� ------------------
		code[45] = 1;
		code[46] = PORT_H;

//
/----- ������ ������ ����������� -----pau se ----from dataout---------
		code[47] = 1;
		code[48] = -1;

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

