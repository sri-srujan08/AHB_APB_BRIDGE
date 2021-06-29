//CREATING AN AHB DRIVER

class ahb_driver;
ahb_trans data2duv;
virtual ahb_if.ahb_DRV ahb_dr_if; //LINKING THE INTERFACE OF DRIVER TO DUT

mailbox #(ahb_trans) ahb_gen2dr;


function new(virtual ahb_if.ahb_DRV ahb_dr_if, mailbox#(ahb_trans) ahb_gen2dr);
        begin
        this.ahb_dr_if = ahb_dr_if;
        this.ahb_gen2dr = ahb_gen2dr;
        end
endfunction

//DEFINING START TASK

task start();
        @(ahb_dr_if.ahb_dr_cb);

fork
        forever
        begin
        ahb_gen2dr.get(data2duv);
        send_to_dut(data2duv);
        end
join_none
endtask

//DEFINING SEND_TO_DUT TASK

task send_to_dut(ahb_trans xtn);
drive(xtn);
calc_addr(xtn);
ahb_dr_if.ahb_dr_cb.Htrans<=0;
endtask

//DEFINING DRIVE TASK

task drive(ahb_trans xtn);
                ahb_dr_if.ahb_dr_cb.Haddr<=xtn.Haddr;
                ahb_dr_if.ahb_dr_cb.Htrans<=xtn.Htrans;
                ahb_dr_if.ahb_dr_cb.Hwrite<=xtn.Hwrite;
                ahb_dr_if.ahb_dr_cb.Hsize<=xtn.Hsize;
                ahb_dr_if.ahb_dr_cb.Hreadyin<=1'b1;

                @(ahb_dr_if.ahb_dr_cb);
                        wait(ahb_dr_if.ahb_dr_cb.Hreadyout);
                        if(xtn.Hwrite)
                        ahb_dr_if.ahb_dr_cb.Hwdata<=$random;
                        else begin
                        ahb_dr_if.ahb_dr_cb.Hwdata<=32'bz;

                        $display($time, "INSIDE DRIVER");
                        end
                $display("Check driver display");
endtask

//CALCULATING THE CAL_ADDR() TASK

task calc_addr(ahb_trans xtn);
$display("Calling calc_addr");

if(xtn.Hburst==0) //FOR HBURST 0
        xtn.Htrans<=2'b00;

//NOW WRITING FOR HBUSRT=1

                if(xtn.Hburst==1)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<xtn.length-1; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+1'b1;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER HADDR = %h", xtn.Haddr);
                                        drive(xtn);

								2'b01 : for(int i=0; i<xtn.length-1; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+2'b10;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER HADDR = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b10 : for(int i=0; i<xtn.length-1; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr + 3'd100;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER HADDR = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
                                endcase
                end

//NOW WRITING FOR HBUSRT=2 (WRAPPING BURST - WRAP 4)

                if(xtn.Hburst==2)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<3; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:2], xtn.Haddr[1:0]+1'b1};
                                        xtn.Htrans = 2'b11;
                                        $display($time,"INSIDE DRIVER HADDR= %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b01 : for(int i=0; i<3; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:3], xtn.Haddr[2:1]+1'b1, xtn.Haddr[0]};
                                        xtn.Htrans = 2'b11;
                                        $display("INSIDE DRIVER HADDR = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
		
								 2'b10 : for(int i=0; i<3; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:4], xtn.Haddr[3:2]+1'b1, xtn.Haddr[1:0]};
                                        xtn.Htrans = 2'b11;
                                        $display("INSIDE DRIVER HADDR = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
                                endcase
                end


//NOW WRITING FOR HBUSRT=3

                if(xtn.Hburst==3)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<3; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+1'b1;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER HADDR=%h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b01 : for(int i=0; i<3; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+2'b10;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b10 : for(int i=0; i<3; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+3'd100;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
										end
								endcase
				end
				
//NOW WRITING FOR HBURST=4 (WRAPPING BURST - WRAP 8)

                if(xtn.Hburst==4)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<7; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:3], xtn.Haddr[2:0]+1'b1};
                                        xtn.Htrans = 2'b11;
                                        $display($time,"INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b01 : for(int i=0; i<7; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:4], xtn.Haddr[3:1]+1'b1, xtn.Haddr[0]};
                                        xtn.Htrans = 2'b11;
                                        $display("INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b10 : for(int i=0; i<7; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:5], xtn.Haddr[4:2]+1'b1, xtn.Haddr[1:0]};
                                        xtn.Htrans = 2'b11;
                                        $display("INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
                                endcase
                end


//NOW WRITING FOR HBURST=5

                if(xtn.Hburst==5)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<7; i++)
										 begin
                                        xtn.Haddr = xtn.Haddr+1'b1;
                                        xtn.Htrans = 2'b10;
                                        $display($time, "INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b01 : for(int i=0; i<7; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+2'b10;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b10 : for(int i=0; i<7; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+3'd100;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
                                endcase
                end


//NOW WRITING FOR HBURST=6 (WRAPPING BURST - WRAP 16)

                if(xtn.Hburst==6)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<15; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:4], xtn.Haddr[3:0]+1'b1};
                                        xtn.Htrans = 2'b11;
                                        $display($time,"INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
								
								 2'b01 : for(int i=0; i<15; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:5], xtn.Haddr[4:1]+1'b1, xtn.Haddr[1:0]};
                                        xtn.Htrans = 2'b11;
                                        $display("INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);end

                                2'b10 : for(int i=0; i<15; i++)
                                        begin
                                        xtn.Haddr = {xtn.Haddr[31:6], xtn.Haddr[5:2]+1'b1, xtn.Haddr[1:0]};
                                        xtn.Htrans = 2'b11;
                                        $display("INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
                                endcase
                end
//NOW WRITING FOR HBURST=7

                if(xtn.Hburst==7)
                begin
                                case(xtn.Hsize)

                                2'b00 : for(int i=0; i<15; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+1'b1;
                                        xtn.Htrans = 2'b11;
                                        $display($time, "DRIVER INSIDE = %h", xtn.Haddr);
                                        drive(xtn);
                                        end

                                2'b01 : for(int i=0; i<15; i++)
                                        begin
                                        xtn.Haddr = xtn.Haddr+1'b1;
                                        xtn.Haddr = 2'b11;
                                        $display($time, "INSIDE DRIVER = %h", xtn.Haddr);
                                        drive(xtn);
                                        end
								  endcase

                end
    endtask


endclass
                                           

                                                                              

                                                                                                        