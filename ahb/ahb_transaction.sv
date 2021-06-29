//CREATING A TRANSACTION CLASS FOR AHB

class ahb_trans;

        logic Hresetn;
        //logic HREADYin;
        //logic HREADYout;
        logic [31:0] Hrdata;

//RAND CONTROL SIGNALS

        rand logic[1:0] Htrans;
        rand logic[2:0] Hburst;
        rand logic[1:0] Hresp; //are we supposed to randomize this or not
        rand logic[2:0] Hsize;
        rand logic[31:0] Hwdata;
        rand logic[31:0] Haddr;
        rand logic Hwrite;
        rand logic [7:0] length;

//THE FOLLOWING ARE NOW CONSTRAINTS FOR RAND SIGNALS

// A. TRANSFER TYPE (HTRANS) CONSTRAINT

        constraint trans{ Htrans!=2'b01;} //REFERENCE PG 25

// B. BURST TRANSFER (HBUSRT) CONSTRAINT

        //constraint burst_oper{;}

// C. VALID LENGTH (LENGTH) CONSTRAINT

        constraint valid_length{ 2^^Hsize*length<=1024;}

// D. SIZE OF TRANSFER (HSIZE) CONSTRAINT

        constraint valid_size{Hsize inside {[0:2]};}

// E. VALID ADDRESS (HADDR) CONSTRAINT
		
		constraint valid_addr{Hsize==1->Haddr%2==0;
                              Hsize==2->Haddr%4==0;}

// F. ADDRESS (HADDR) CONSTRAINT

        constraint addr{Haddr inside {[32'h8000_0000:32'h8000_03ff], [32'h8400_0000:32'h8400_03ff], [32'h8800_0000:32'h8800_03ff], [32'h8400_0000:32'h8400_03ff] ,[32'h8800_0000:32'h8800_03ff], [32'h8c00_0000:32'h8c00_03ff]};}


// DISPLAY FUNCTION

        virtual function void display(string message);
                begin
                        $display("====================================================================");
                        $display($time, "message=%s", message);
                        $display("The reset is = %d", Hresetn);
                        $display("HRDATA is = %h", Hrdata);
                        $display("HTRANS is = %h", Htrans);
                        $display("HBURST is = %h", Hburst);
                        $display("length is = %h", length);
                        $display("HSIZE is = %h", Hsize);
                        $display("HWDATA is = %h", Hwdata);
                        $display("HADDR is = %h", Haddr);
                        $display("HWRITE is = %h", Hwrite);
                        $display("Number of data to be compared =%d", no_of_data_to_be_compared);
                end
        $display("======================================================================================");
        endfunction


         function void post_randomize();
         begin
                if(Hburst==0)
                        no_of_data_to_be_compared=no_of_data_to_be_compared+1;
                if(Hburst==1)
                        no_of_data_to_be_compared=no_of_data_to_be_compared+length;
                if(Hburst==2 || Hburst==3)
                        no_of_data_to_be_compared=no_of_data_to_be_compared+4;
                if(Hburst==4 || Hburst==5)
                        no_of_data_to_be_compared=no_of_data_to_be_compared+8;
				 if(Hburst==6 || Hburst==7)
                        no_of_data_to_be_compared=no_of_data_to_be_compared+16; end
        $display("RANDOMIZED DATA");
        endfunction

endclass

                                                                               