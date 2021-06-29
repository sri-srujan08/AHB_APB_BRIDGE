//CREATING A TEST FILE BY IMPORTING PKG

import ahb2apb_bridge_pkg::*;

class test;

        virtual ahb_if.ahb_DRV ahb_dr_if;
        virtual ahb_if.ahb_MON ahb_mon_if;
        virtual apb_if.apb_DRV apb_dr_if;
        virtual apb_if.apb_MON apb_mon_if;

//CREATING AN ENVIRONMENT HANDLE

        env env_h;

//INITIALIZING A CONSTRUCTOR

        function new(virtual ahb_if.ahb_DRV ahb_dr_if,
                     virtual ahb_if.ahb_MON ahb_mon_if,
                     virtual apb_if.apb_DRV apb_dr_if,
                     virtual apb_if.apb_MON apb_mon_if);

                this.ahb_dr_if=ahb_dr_if;
                this.ahb_mon_if=ahb_mon_if;
                this.apb_dr_if=apb_dr_if;
                this.apb_mon_if=apb_mon_if;
                env_h = new(ahb_dr_if, ahb_mon_if, apb_dr_if, apb_mon_if);
        endfunction

//CREATING A BUILD AND RUN TASK

        task build_and_run();

        if($test$plusargs("TEST1"))
        begin
        $display("build and run task");
        no_of_transactions = 2;
        env_h.build();
        env_h.run();
        end
	
	
        if($test$plusargs("TEST2"))
        begin
        $display("build and run task");
        no_of_transactions = 15;
        env_h.build();
        //child_trans child=new();
        env_h.gen_h.rand_data=child;
        env_h.run();
        end


         if($test$plusargs("TEST3"))
        begin
        $display("build and run task");
        no_of_transactions = 15;
        env_h.build();
        //child_trans child=new();
        env_h.gen_h.rand_data=child1;
        env_h.run();
        end

		endtask

endclass
                    
