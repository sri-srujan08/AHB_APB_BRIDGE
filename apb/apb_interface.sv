//APB INTERFACE

interface apb_if(input bit Pclk);
        logic [3:0] Pselx;
        logic [31:0] Paddr;
        logic [31:0] Pwdata;
        logic [31:0] Prdata;
        logic Penable;
        logic Pwrite;

//CLOCKING BLOCK FOR APB DRIVER

        clocking apb_dr_cb@(posedge Pclk);
                default input #1 output #1;
                input Penable;
                input Pwrite;
                input Pwdata;
                input Paddr;
                input Pselx;
                output Prdata;
        endclocking

//CLOCKING BLOCK FOR APB MONITOR

        clocking apb_mon_cb@(posedge Pclk);
                default input #1 output #1;
                input Penable;
                input Pwrite;
                input Pwdata;
                input Paddr;
                input Pselx;
                input Prdata;
        endclocking

//MODPORT FOR APB DRIVER

        modport apb_DRV(clocking apb_dr_cb);

//MODPORT FOR APB MONITOR

		clocking apb_mon_cb@(posedge Pclk);
                default input #1 output #1;
                input Penable;
                input Pwrite;
                input Pwdata;
                input Paddr;
                input Pselx;
                input Prdata;
        endclocking

//MODPORT FOR APB DRIVER

        modport apb_DRV(clocking apb_dr_cb);

//MODPORT FOR APB MONITOR

        modport apb_MON(clocking apb_mon_cb);

endinterface
