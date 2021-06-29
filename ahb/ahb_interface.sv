//AHB INTERFACE

interface ahb_if(input bit Hclk);

        logic Hresetn;
        logic[1:0] Htrans;
        logic Hwrite;
        logic Hreadyin;
        logic Hreadyout;
        logic[1:0] Hresp;
        logic[31:0] Hwdata;
        logic[31:0] Hrdata;
        logic[31:0] Haddr;
        logic[2:0] Hburst;
        logic[2:0] Hsize;

//CLOCKING BLOCK FOR AHB DRIVER

        clocking ahb_dr_cb@(posedge Hclk);
                default input #1 output #1;
                output Hresetn;
                output Htrans;
                output Hwrite;
                output Hreadyin;
                output Haddr;
                output Hburst;
                output Hsize;
                input Hreadyout;
                input Hresp;
                input Hrdata;
                output Hwdata;
        endclocking

//CLOCKING BLOCK FOR AHB MONITOR

        clocking ahb_mon_cb@(posedge Hclk);
                default input #1 output #1;
                input Hresetn;
                input Htrans;
                input Hwrite;
				input Hreadyin;
                input Haddr;
                input Hburst;
                input Hsize;
                input Hreadyout;
                input Hresp;
                input Hrdata;
                input Hwdata;
        endclocking

//MODPORT OF AHB DRIVER
        modport ahb_DRV(clocking ahb_dr_cb);

//MODPORT OF AHB MONITOR
        modport ahb_MON(clocking ahb_mon_cb);


endinterface

