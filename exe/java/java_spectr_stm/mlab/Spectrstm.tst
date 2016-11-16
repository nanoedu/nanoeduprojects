package mlab;      //110312

public class Spectrstm
{
	static final int DAC_STEP = 65536*1;

        public static  int M_I;
        public static  int M_U;
      	public static  int M_SELOPORA;


	static final int PORT_I = ( Port.IN | 4 );
      	static final int PORT_U = ( Port.OUT | 6 );



        // chanels ID

	public static void main(String[] arg)
	{

		int i,j;
              	int[] arr;
		int src_i;
		int dst_i;

		int[] datain;
		Port[] port;
		Span[] span_u; 	Span[] span_i;
		Scene scene;
                boolean flg;
                int  off;
		int  handle;
		int  point;
	        int  ubackup;
                int  s,wr,rd;
                int  Z;
		int  dt;
                int  VertMin;
                int  UPoints;
                int  UCurves;
                int  UStep;
                int  UStart;
                int  flgSTM;
                int  dacU;

		UPoints         = 200;// datain[0];
                UCurves         = 2;//  datain[1];
		UStart		= -16000*DAC_STEP; // datain[2];    //integer  shl
		UStep		=160*DAC_STEP; // datain[3];    //step shl
      		dt              =30;//   datain[4];
                flgSTM          =0;//   datain[5];

                Simple.DumpInt(0xAAAAAAA0);
                Simple.DumpInt(UPoints);
                Simple.DumpInt(UCurves);
                Simple.DumpInt(UStart);
                Simple.DumpInt(UStep);

              M_I = Simple.bramID("m_ADC_I");
              M_U = Simple.bramID("m_DAC_I");
       M_SELOPORA = Simple.bramID("m_sel_Uopora");



    	i=0;
        int k;
        k=0;
        off=0;

//start

    Simple.fcupBypass(0,true); //turn off   FB     false???

    Simple.Sleep(100);


    ubackup=Simple.bramRead(M_U);

     span_u = new Span[] {new Span(2),new Span(1),new Span(dt)};

     port   = new Port[] {   new Port(PORT_U,       span_u),
                             new Port(PORT_I,       span_u) };
     scene  = new Scene( port );


    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }



      	 scene.startLoad( handle, PORT_U, 0 );
       	 scene.load( handle, ubackup );
         scene.load( handle, ubackup );
         scene.load( handle, ubackup );

         scene.run( handle );
         scene.wait( handle, -1 );
         scene.releaseScene( handle );

    Simple.bramWrite( M_SELOPORA, 0X80000000);     //use dchange for U


     span_u = new Span[] {new Span(2),new Span(1),new Span(dt)};

     port   = new Port[] {   new Port(PORT_U,       span_u),
                             new Port(PORT_I,       span_u) };
     scene  = new Scene( port );

    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), UPoints);
	if ( 0 == handle ) scene.releaseScene(0);
    }

    dacU=UStart;


  for(i=0; i<UPoints; i++)
  {
       	 scene.startLoad( handle, PORT_U, i );
       	 scene.load( handle, dacU );
         scene.load( handle, dacU );
         scene.load( handle, dacU );
         dacU+=UStep;
  }


    scene.run( handle );

    scene.wait( handle, -1 );


   scene.releaseScene( handle );


 //move to start point

    //move to start point

     span_u = new Span[] {new Span(2),new Span(1),new Span(dt)};

     port   = new Port[] {   new Port(PORT_U,       span_u),
                             new Port(PORT_I,       span_u) };
     scene  = new Scene( port );


    for(handle=0;handle==0;)
    {
	handle = scene.createScene( scene.getTemplate(), 1);
	if ( 0 == handle ) scene.releaseScene(0);
    }

      	 scene.startLoad( handle, PORT_U, 0 );
       	 scene.load( handle, ubackup);
    	 scene.load( handle, ubackup);
      	 scene.load( handle, ubackup);
         scene.run( handle );
         scene.wait( handle, -1 );
         scene.releaseScene( handle );

         Simple.bramWrite(M_U,ubackup);

         Simple.bramWrite( M_SELOPORA, 0X00000000); //use bram for U

         Simple.fcupBypass(0,false); //turn on  FB

         Simple.Sleep(1000);

	}

}

















