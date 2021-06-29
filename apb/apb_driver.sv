//CREATING AN APB DRIVER

class apb_driver;
        virtual apb_if.apb_DRV apb_dr_if;


//CONSTRUCTOR

        function new(virtual apb_if.apb_DRV apb_dr_if);
                this.apb_dr_if=apb_dr_if;

        endfunction

//CREATING START TASK

        task start();
                fork
                        forever
                        begin
                        send_to_dut();
                        end
                join_none
        endtask

//CREATING SEND_TO_DUT TASK

        task send_to_dut();
        wait(apb_dr_if.apb_dr_cb.Pselx!=0);

                if(apb_dr_if.apb_dr_cb.Pwrite==0)
                        apb_dr_if.apb_dr_cb.Prdata<=$random;

        repeat(2)
         @(apb_dr_if.apb_dr_cb);

        endtask

endclass
