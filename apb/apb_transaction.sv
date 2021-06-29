//CREATING APB TRANSACTION CLASS

class apb_trans;
        logic Penable;
        logic Pwrite;
        logic [31:0] Pwdata;
        logic [31:0] Paddr;
        logic Pselx;

//CREATING RANDOM SIGNAL PDRATA
        rand logic [31:0] Prdata;

//ADDING CONSTRAINT FOR PRDATA

//      constraint read_data{}

//DISPLAYING ALL SIGNALS

        virtual function void display(input string s);
                begin
                        $display("PENABLE is %d", Penable);
                        $display("PWRITE is %d", Pwrite);
                        $display("Write data is %d", Pwdata);
                        $display("Address is %d", Paddr);
                        $display("PSELx is %d", Pselx);
                        $display("Read data is %d", Prdata);
                end
        endfunction
endclass
