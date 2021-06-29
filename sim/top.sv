`include "test.sv"
module top();

        //parameter cycle=10;

        bit clock;

        //INSTANTIATE THE INTERFACES

        ahb_if ahb_DUV_IF(clock);
        apb_if apb_DUV_IF(clock);

        //CREATING TEST HANDLE

        test test_h;



        rtl_top top( .Hclk(clock),
                     .Hresetn(ahb_DUV_IF.Hresetn),
                     .Htrans(ahb_DUV_IF.Htrans),
                     .Hsize(ahb_DUV_IF.Hsize),
                     .Hreadyin(ahb_DUV_IF.Hreadyin),
                     .Hwdata(ahb_DUV_IF.Hwdata),
                     .Haddr(ahb_DUV_IF.Haddr),
                     .Hwrite(ahb_DUV_IF.Hwrite),
                     .Prdata(apb_DUV_IF.Prdata),
                     .Hrdata(ahb_DUV_IF.Hrdata),
                     .Hresp(ahb_DUV_IF.Hresp),
                     .Hreadyout(ahb_DUV_IF.Hreadyout),
                     .Pselx(apb_DUV_IF.Pselx),
                     .Pwrite(apb_DUV_IF.Pwrite),
                     .Penable(apb_DUV_IF.Penable),
                     .Paddr(apb_DUV_IF.Paddr),
                     .Pwdata(apb_DUV_IF.Pwdata));
		
		 always

        #10 clock=~clock;

        initial
        begin

                test_h=new(ahb_DUV_IF, ahb_DUV_IF, apb_DUV_IF,  apb_DUV_IF);
                $display("In top module");
                test_h.build_and_run();
                $finish;
        end

endmodule
