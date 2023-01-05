class print_component extends uvm_component;
`uvm_analysis_imp_decl(_decode_in_ap);
`uvm_analysis_imp_decl(_decode_out_ap);
`uvm_component_utils( print_component );

uvm_analysis_imp_decode_in_ap #(decode_in_transaction, print_component) decode_in_ap;
uvm_analysis_imp_decode_out_ap #(decode_out_transaction, print_component) decode_out_ap;

function new (string name="", uvm_component parent=null);
	super.new(name,parent);
	decode_in_ap = new("decode_in_ap", this);
	decode_out_ap = new("decode_out_ap", this);
endfunction 


virtual function void write_decode_in_ap(decode_in_transaction trans);
	`uvm_info("PRINT", {"DECODE_IN_TRANSACTION:  ", trans.convert2string()}, UVM_LOW);
endfunction

virtual function void write_decode_out_ap(decode_out_transaction trans);
	`uvm_info("PRINT", {"DECODE_OUT_TRANSACTION: ", trans.convert2string()}, UVM_LOW);
endfunction

endclass
