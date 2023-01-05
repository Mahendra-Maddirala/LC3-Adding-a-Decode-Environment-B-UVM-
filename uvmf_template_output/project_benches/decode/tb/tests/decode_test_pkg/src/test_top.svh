//test_top
class test_top extends uvm_test;
`uvm_component_utils(test_top)

decode_env_configuration env_cnfg;
decode_environment env;
decode_in_random_sequence dec_in_ran_seq;
decode_out_random_sequence dec_out_ran_seq;

function new(string name = "test_top", uvm_component parent = null);
	super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);  
	env_cnfg = decode_env_configuration::type_id::create("env_cnfg");
	env = decode_environment::type_id::create("env", this);
	dec_in_ran_seq = decode_in_random_sequence::type_id::create("dec_in_ran_seq", this);
	dec_out_ran_seq = decode_out_random_sequence::type_id::create("dec_out_ran_seq",this);
	env_cnfg.initialize(BLOCK,"test_top.env",{"decode_in_if","decode_out_if"},null,{ACTIVE,PASSIVE});
	env.set_config(env_cnfg);
endfunction: build_phase

virtual function void end_of_elaboration_phase (uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology ();
endfunction: end_of_elaboration_phase
	 
virtual function void start_of_simulation_phase (uvm_phase phase);
	`uvm_info(get_type_name(), env_cnfg.dec_in_agn_config.convert2string(), UVM_NONE);
endfunction:start_of_simulation_phase
	
task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	env_cnfg.dec_in_agn_config.wait_for_reset();
	fork   
	begin
	repeat(25)
	begin
		if(env_cnfg.dec_in_agn_config.active_passive == ACTIVE)
	begin
		dec_in_ran_seq.start(env_cnfg.dec_in_agn_config.sequencer);
	end
        end
        end
        
	begin
	repeat(25)
	begin
	if(env_cnfg.dec_out_agn_config.active_passive == ACTIVE)
	begin
	dec_out_ran_seq.start(env_cnfg.dec_out_agn_config.sequencer);
	end
	end
	end
	join
	env_cnfg.dec_in_agn_config.wait_for_num_clocks(2);
	phase.drop_objection(this);
endtask: run_phase

endclass
