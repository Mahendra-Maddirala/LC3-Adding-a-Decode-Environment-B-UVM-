//hvl_top
module hvl_top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import decode_in_pkg::*;
	import decode_test_pkg::*;

	initial begin
	 run_test();
	end
endmodule: hvl_top
