//CREATING AN APB MONITOR

class apb_monitor;

        virtual apb_if.apb_MON apb_mon_if;

//TRANSACTION

        apb_trans data2sb;

//MAILBOX

        mailbox#(apb_trans) apb_mon2sb;

//CONSTRUCTOR

        function new(virtual apb_if.apb_MON apb_mon_if,
                     mailbox#(apb_trans) apb_mon2sb);
                begin
                this.apb_mon_if=apb_mon_if;
                this.apb_mon2sb=apb_mon2sb;
                data2sb=new();
                end
        endfunction


//CREATING A START TASK

        task start();
                @(apb_mon_if.apb_mon_cb);
                fork
                        forever
                        begin
                monitor();
                apb_mon2sb.put(data2sb);
                        end
                join_none
        endtask

//CREATING THE MONITOR TASK

        task monitor();
        wait(apb_mon_if.apb_mon_cb.Penable);
        begin
                data2sb.Paddr=apb_mon_if.apb_mon_cb.Paddr;
                data2sb.Pselx=apb_mon_if.apb_mon_cb.Pselx;
                data2sb.Pwdata=apb_mon_if.apb_mon_cb.Pwdata;
        end

        if(apb_mon_if.apb_mon_cb.Pwrite)

                data2sb.Pwdata=apb_mon_if.apb_mon_cb.Pwdata;
        else
                data2sb.Prdata=apb_mon_if.apb_mon_cb.Prdata;



        @(apb_mon_if.apb_mon_cb);

        endtask

endclass

                         