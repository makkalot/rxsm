require 'asm/instr'

describe XSM::InstructionTable do
  
  it "should check if instructions there" do
    XSM::init_instr_table
    instr_table = XSM::InstructionTable.instance
    instruction = instr_table.get_by_mnemonic("mov")
    instruction.should_not == nil
    instruction.mnemonic.should == "mov"
    instruction.opcode.should == XSM::Constants::OPCODE_INSTR_MOV
    instruction.opcount.should ==   2
    instruction.optypes[0].should == XSM::Constants::OP_FLAG_TYPE_MEM_REF |
                                     XSM::Constants::OP_FLAG_TYPE_REG
                                     
    instruction.optypes[1].should == XSM::Constants::OP_FLAG_TYPE_INT |
                                     XSM::Constants::OP_FLAG_TYPE_FLOAT |
                                     XSM::Constants::OP_FLAG_TYPE_STRING |
                                     XSM::Constants::OP_FLAG_TYPE_MEM_REF |
                                     XSM::Constants::OP_FLAG_TYPE_REG
  end
end

