//CREATING AN AHB GENERATOR CLASS

class ahb_gen;
        ahb_trans rand_data;
        ahb_trans data2send;

//CREATING A MAILBOX

        mailbox#(ahb_trans) ahbgen2dr;

//CREATING A CONSTRUCTOR

        function new(mailbox#(ahb_trans) ahbgen2dr);
                this.ahbgen2dr=ahbgen2dr;

                rand_data=new();
        endfunction

//WRITING THE START TASK

        task start();
                fork
                        for(int i=0; i<no_of_transactions; i++)
                                begin
                                        assert(rand_data.randomize());
                                        data2send= new rand_data;
                                        ahbgen2dr.put(data2send);
                                end
                join_none
        endtask

endclass
