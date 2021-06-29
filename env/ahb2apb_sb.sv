//CREATING A SCOREBOARD

class ahb2apb_sb;

//CREATING TRANSACTION HANDLES

        ahb_trans ahb_mon_data, ahb_mon_data1, q[$];
        apb_trans apb_mon_data;

//CREATING MAILBOXES

        mailbox#(ahb_trans) ahb_mon2sb;
        mailbox#(apb_trans) apb_mon2sb;


        int data_verified;
        //event e;
//CREATING CONSTRUCTOR

        function new(mailbox#(ahb_trans) ahb_mon2sb,
                     mailbox#(apb_trans) apb_mon2sb);
                begin
                        this.ahb_mon2sb=ahb_mon2sb;
                        this.apb_mon2sb=apb_mon2sb;
                end
        endfunction


//DEFINING A START TASK

        task start();
                fork
                forever
                begin
                        ahb_mon2sb.get(ahb_mon_data1);
                        ahb_mon_data1.display("DATA FROM SB");
                        q.push_back(ahb_mon_data1); //PUSHING THE DATA INTO A QUEUE
                        $display("The size of the queue is %d", q.size);
                end
		
				 forever
                begin
                        apb_mon2sb.get(apb_mon_data);
                        apb_mon_data.display("DATA FROM SB");
                        check();
                end
                join_none
        endtask


//DEFINING THE CHECK TASK

        task check();

//POPPING THE DATA FROM THE QUEUE

        ahb_mon_data=q.pop_front();

//NOW CHECKING FOR HWRITE. IF HWRITE==1, WE HAVE TO CHECK HWDATA, PWDATA, HADDR, PADDR. IF HWRITE==0; CHECK HRDATA, PRDATA, HADDR, PADDR

        if(ahb_mon_data.Hwrite)
                begin
                case(ahb_mon_data.Hsize)

                2'b00: begin
                         if(ahb_mon_data.Haddr[1:0]==2'b00)
                                compare(ahb_mon_data.Hwdata[7:0], apb_mon_data.Pwdata[7:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);

                        if(ahb_mon_data.Haddr[1:0]==2'b01)
                                compare(ahb_mon_data.Hwdata[15:8], apb_mon_data.Pwdata[7:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);

                        if(ahb_mon_data.Haddr[1:0]==2'b10)
                                compare(ahb_mon_data.Hwdata[23:16], apb_mon_data.Pwdata[7:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);


                        if(ahb_mon_data.Haddr[1:0]==2'b11)
                                compare(ahb_mon_data.Hwdata[31:24], apb_mon_data.Pwdata[7:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);

                        end
						
				2'b01: begin
                        if(ahb_mon_data.Haddr[1:0]==2'b00)
                                compare(ahb_mon_data.Hwdata[15:0], apb_mon_data.Pwdata[15:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);


                        if(ahb_mon_data.Haddr[1:0]==2'b10)
                                compare(ahb_mon_data.Hwdata[31:16], apb_mon_data.Pwdata[15:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);
                        end

                2'b10: compare(ahb_mon_data.Hwdata, apb_mon_data.Pwdata, ahb_mon_data.Haddr, apb_mon_data.Paddr);

                endcase
                end



                else
                begin
                case(ahb_mon_data.Hsize)


                2'b00: begin
                           if(ahb_mon_data.Haddr[1:0]==2'b00)
                                  compare(ahb_mon_data.Hrdata[7:0], apb_mon_data.Pwdata[7:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);

                          if(ahb_mon_data.Haddr[1:0]==2'b01)
                                  compare(ahb_mon_data.Hrdata[7:0], apb_mon_data.Pwdata[15:8], ahb_mon_data.Haddr, apb_mon_data.Paddr);

                         if(ahb_mon_data.Haddr[1:0]==2'b10)
                                 compare(ahb_mon_data.Hwdata[7:0], apb_mon_data.Pwdata[23:16], ahb_mon_data.Haddr, apb_mon_data.Paddr);


                         if(ahb_mon_data.Haddr[1:0]==2'b11)
                                  compare(ahb_mon_data.Hwdata[7:0], apb_mon_data.Pwdata[31:24], ahb_mon_data.Haddr, apb_mon_data.Paddr);

                         end


                  2'b01: begin
                          if(ahb_mon_data.Haddr[1:0]==2'b00)
								 compare(ahb_mon_data.Hwdata[15:0], apb_mon_data.Pwdata[15:0], ahb_mon_data.Haddr, apb_mon_data.Paddr);


                          if(ahb_mon_data.Haddr[1:0]==2'b10)
                                  compare(ahb_mon_data.Hwdata[15:0], apb_mon_data.Pwdata[31:16], ahb_mon_data.Haddr, apb_mon_data.Paddr);
                         end

                  2'b10: compare(ahb_mon_data.Hwdata, apb_mon_data.Pwdata, ahb_mon_data.Haddr, apb_mon_data.Paddr);


                endcase
                end

        endtask


//CREATING THE COMPARE TASK

        task compare(int Hdata, Pdata, Haddr, Paddr);

        if(Haddr==Paddr)
                $display("ADDRESS COMPARED SUCCESSFUL");

        else
        begin
                $display("ADDRESS NOT COMPARED SUCCESSFUL");
                $finish;
        end

        if(Hdata==Pdata)
                $display("DATA COMPARED SUCCESSFUL");

        else
        begin
                $display("HWDATA=%h, PWDATA=%h", Hdata, Pdata);
                $finish;
        end

        //data_verified++;
		//$display("TOTAL DATA VERIFIED = %d", data_verified);



        //if(data_verified==no_of_data_to_be_compared)
        //->e;
        endtask

        //function void report();
        //$display("TOTAL DATA VERIFIED = %d", data_verified);
        //endfunction

endclass


