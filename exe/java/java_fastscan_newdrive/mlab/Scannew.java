package mlab;

public class Scannew
{
public static final int N = 100;
public static final int P = 100;

public static final int pause = 50; // пауза в точке mks
public static final int steps = 32; // время перемещения между точками mks
	public static void main(String[] arg)
	{
		int[] data_out;
		int[] data_in;
		int[] code;

		code = new int[17];
//----- Заголовок -- "2D point" --------------------
		code[0]  = Dxchg.CODE_SIGNATURE;
		code[1]  = 0x00030001;
		code[2]  = code.length;
//----- Код ----------------------------------------
                // Вектор перемещения и позиция точки
                code[3]  = 0x00000000 + (10<<16) + (0<<0);
		code[4]  = 0x20000000;
		// Контроль перемещения
                code[5]  = 0x00000000;
		code[6]  = 0x10000008;
	 	// Считывание после паузы
                code[7] = 0x00000000 + (0<<16) + (15<<0);
                code[8] = 0x40000000 + pause - 1;
		// Возврат 
                code[9] = 0x80000000 + (3<<16) + 0;   
//----- Список портов перемещения в точку ---------
		code[10] = 4;
		code[11] = Dxchg.OUTP_DIRY;
		code[12] = Dxchg.OUTP_DIRX;
		code[13] = Dxchg.OUTP_Y;
		code[14] = Dxchg.OUTP_X;
//----- Список портов результатов ------------------
		code[15] = 1;
		code[16] = 5;
//--------------------------------------------------

		int Grid = 0x00800000; // шаг сетки
		int Snom = 0x028F5C29; // 1.0/50 - просто выбрано число 50
		int Vtrvl_nom = 0x19000000; // Snom*Vtrvl = Grid, за 1 шаг
		int Vtrvl = Vtrvl_nom / steps;

     		Simple.bramWrite( Simple.bramID("m_ustep"), Snom );

		data_in = new int[N*P*1]; // список #15 в каждой точке

		data_out = new int[N*P*4]; // список #10 в каждой точке

		int i = 0;
		for ( int y = 0; y < N; ++y ) // по Y
		{
			for ( int x = 0; x < P; ++x ) // по X
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

















