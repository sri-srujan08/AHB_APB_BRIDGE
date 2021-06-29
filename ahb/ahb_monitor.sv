//CREATING AN AHB MONITOR

class ahb_monitor;
        virtual ahb_if.ahb_MON ahb_mon_if;

//TRANSACTIONS

        ahb_trans data2sb;

//MAILBOX

        mailbox#(ahb_trans) ahb_mon2sb;

//CREATING CONSTRUCTOR

        function new(mailbox#(ahb_trans) ahb_mon2sb,
                     virtual ahb_if.ahb_MON ahb_mon_if);

        begin
                this.ahb_mon2sb=ahb_mon2sb;
                this.ahb_mon_if=ahb_mon_if;
        end

        endfunction

//CREATING A START TASK

        task start();
                @(ahb_mon_if.ahb_mon_cb);
                wait(ahb_mon_if.ahb_mon_cb.Hreadyout);

        fork
        forever
                begin
                        data2sb=new();
                        monitor();
                        ahb_mon2sb.put(data2sb);
                end
        join_none
        endtask
