package mlab;

public class SetupDiag
{
	static final int DIAG_CODE_FPGA_LOAD   = 0;
	static final int DIAG_CODE_SHEMA_LOAD  = 1;
	static final int DIAG_CODE_JAVA_EXIT   = 2;
	static final int DIAG_CODE_LINK        = 3;
	static final int DIAG_CODE_SYS_STATUS  = 4;
	static final int DIAG_CODE_ADPT_STATUS = 5;

	static final int ADPT_NE2     = 1;
	static final int ADPT_NEA_REN = 2;
	static final int ADPT_NEA_HVC = 3;

	/***
	  Определение версии прошивки ПЛИС АГ и типа АГ.
	  getAdaptorVerId - {id[4],ver_hi[8],ver_lo[4]},
	  GetAdaptorType  - тип АГ (ADPT_NE2, ADPT_NEA_REN, ...).
	***/
	public static native int getAdaptorVerId( );
	public int GetAdaptorType( )
	{	
		return ((getAdaptorVerId() >> 12) & 0x0F);
	}

	/*** 
          Доступ к энергонезависимой памяти для хранения настроек. 
	  Запись/чтение энергонезависимой памяти осуществляется блоками
	  по 64 int (256 байт). Кол-во блоков можно определить через вызов 
	  GetBlockCount(). Индексация блоков начинается с 0.
	  В случае успешного завершения функции возвращают 0.
	***/
	public static native int ReadBlock(int indx, int[] block_64);
	public static native int WriteBlock(int indx, int[] block_64);
	public static native int GetBlockCount( );

	/***
	  Получение диагностической информации о приборе.
	  Идентификатор диагностического кода (DIAG_CODE_) задается в параметре.
	***/
	public static native int GetDiagCode( int id );

	public static native void NeaUpdate(char[] name);
	public static void NeaUpdate(String name)
	{
		NeaUpdate(name.toCharArray());
	}


	public static native int m_EERead(int addr, byte[] buf);
	public static native int m_EEWrite(int addr, byte[] buf);

	public static native int m_flRead(int indx, int[] arr);
	public static native int m_flWrite(int indx, int[] arr);
	public static native int m_flErase();
}
