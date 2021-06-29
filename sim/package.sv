//INCLUDING THE PACKAGE AND ALL FILES IN IT

package ahb2apb_bridge_pkg;

        int no_of_data_to_be_compared, no_of_transactions=1;
        `include "ahb_trans.sv"
        `include "apb_trans.sv"
        `include "ahb_gen.sv"
        `include "ahb_dr.sv"
        `include "apb_dr.sv"
        `include "ahb_mon.sv"
        `include "apb_mon.sv"
        `include "ahb2apb_sb.sv"
        `include "env.sv"
        `include "test.sv"

endpackage
