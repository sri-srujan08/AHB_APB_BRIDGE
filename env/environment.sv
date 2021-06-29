//CREATING ENV CLASS

class env;

//DECLARING THE INTERFACES

        virtual ahb_if.ahb_DRV ahb_dr_if;
        virtual ahb_if.ahb_MON ahb_mon_if;
        virtual apb_if.apb_DRV apb_dr_if;

        virtual apb_if.apb_MON apb_mon_if;



//DECLARING MAILBOXES

        mailbox#(ahb_trans) ahbgen2dr=new();
        mailbox#(ahb_trans) ahb_mon2sb=new();
        mailbox#(apb_trans) apb_mon2sb=new();


// CREATING HANDLES FOR TRANSACTORS

        ahb_gen gen_h;
        ahb_driver ahb_dr_h;
        ahb_monitor ahb_mon_h;
        apb_driver apb_dr_h;
        apb_monitor apb_mon_h;
        ahb2apb_sb sb_h;

//INITIALIZING THE CONSTRUCTOR AND CONNECTING TO VIRTUAL INTERFACE

        function new(virtual ahb_if.ahb_DRV ahb_dr_if,
                     virtual ahb_if.ahb_MON ahb_mon_if,
                     virtual apb_if.apb_DRV apb_dr_if,
                     virtual apb_if.apb_MON apb_mon_if);

                this.ahb_dr_if=ahb_dr_if;
                this.ahb_mon_if=ahb_mon_if;
                this.apb_dr_if=apb_dr_if;
				this.apb_mon_if=apb_mon_if;

        endfunction

//CREATING A BUILD TASK

        task build();

                $display("build task running");
                gen_h=new(ahbgen2dr);
                ahb_dr_h=new(ahb_dr_if, ahbgen2dr);
                ahb_mon_h=new(ahb_mon2sb, ahb_mon_if);
                apb_dr_h=new(apb_dr_if);
                apb_mon_h=new(apb_mon_if, apb_mon2sb);
                sb_h=new(ahb_mon2sb, apb_mon2sb);
        endtask

//CREATING A RESET TASK

        task reset();

                ahb_dr_if.ahb_dr_cb.Hresetn<='0;
                repeat(2) @(ahb_dr_if.ahb_dr_cb);
                ahb_dr_if.ahb_dr_cb.Hresetn<='1;
                @(ahb_dr_if.ahb_dr_cb);
        endtask

//CREATING A STOP TASK

        task stop();
        #1000;
        //wait(sb_h.e.triggered);
        endtask


//CREATING START TASK

        task start();
                gen_h.start();
				ahb_dr_h.start();
                ahb_mon_h.start();
                apb_dr_h.start();
                apb_mon_h.start();
                sb_h.start();
        endtask

//CREATING A RUN TASK

        task run();
        $display("running run task");
        reset();
        start();
        stop();
        //sb_h.report();

        endtask

endclass

                                                