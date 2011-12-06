# Here you can find classes that represents the instructions
module XSM
  module Constants
    
    #OPCODES OF MNEMONICS
    OPCODE_INSTR_MOV = 0
    OPCODE_INSTR_ADD = 1
    OPCODE_INSTR_SUB = 2
    OPCODE_INSTR_MUL = 3
    OPCODE_INSTR_DIV = 4
    OPCODE_INSTR_MOD = 5
    OPCODE_INSTR_EXP = 6
    OPCODE_INSTR_NEG = 7
    OPCODE_INSTR_INC = 8
    OPCODE_INSTR_DEC = 9

    OPCODE_INSTR_AND = 10
    OPCODE_INSTR_OR  = 11
    OPCODE_INSTR_XOR = 12
    OPCODE_INSTR_NOT = 13
    OPCODE_INSTR_SHL = 14
    OPCODE_INSTR_SHR = 15

    OPCODE_INSTR_CONCAT = 16
    OPCODE_INSTR_GETCHAR = 17
    OPCODE_INSTR_SETCHAR = 18

    OPCODE_INSTR_JMP = 19
    OPCODE_INSTR_JE  = 20
    OPCODE_INSTR_JNE = 21
    OPCODE_INSTR_JG  = 22
    OPCODE_INSTR_JL  = 23
    OPCODE_INSTR_JGE = 24
    OPCODE_INSTR_JLE = 25

    OPCODE_INSTR_PUSH = 26
    OPCODE_INSTR_POP  = 27

    OPCODE_INSTR_CALL = 28
    OPCODE_INSTR_RET  = 29
    OPCODE_INSTR_CALLHOST = 30

    OPCODE_INSTR_PAUSE = 31
    OPCODE_INSTR_EXIT  = 32
    
    #flags for operand types
    OP_FLAG_TYPE_INT = 1    
    OP_FLAG_TYPE_FLOAT = 2
    OP_FLAG_TYPE_STRING = 4 
    OP_FLAG_TYPE_MEM_REF = 8
    OP_FLAG_TYPE_LINE_LABEL = 16
    OP_FLAG_TYPE_FUNC_NAME = 32
    OP_FLAG_TYPE_HOST_API_CALL = 64
    OP_FLAG_TYPE_REG = 128

    #operand types for assembled instructions
    OP_TYPE_INT = 0             
    OP_TYPE_FLOAT = 1          
    OP_TYPE_STRING_INDEX = 2    
    OP_TYPE_ABS_STACK_INDEX = 3 
    OP_TYPE_REL_STACK_INDEX = 4 
    OP_TYPE_INSTR_INDEX = 5
    OP_TYPE_FUNC_INDEX = 6    
    OP_TYPE_HOST_API_CALL_INDEX = 7
    OP_TYPE_REG = 8
    
    #operant

  end
end

module XSM
  
  class Instruction
    attr_accessor :mnemonic, :opcode, :opcount, :optypes 
    
    def initialize(mnemonic, opcode, opcount)
      @mnemonic = mnemonic
      @opcode = opcode
      @opcount = opcount
      #it is a list of Flag objects
      @optypes = []
    end

  end


  class Operand

    def initialize(optype, value)
      @optype = optype
      @value = value
      @index_offset = 0
    end

  end
  
  class InstructionTable
    
    include Singleton
    
    def initialize
      #i think to make keyed by mnemonics
      @instructions = {}
    end
    
    def add_instruction(mnemonic, opcode, opcount)
      
      #lets first check if we have that mnemonic
      if @instructions.has_key?(mnemonic)
        return nil
      end
      
      inst = Instruction.new(mnemonic, opcode, opcount)
      @instructions[mnemonic] = inst
      
      return inst
      
    end
    
    def add_optype(mnemonic, optype)
      #lets first check if we have that mnemonic
      if !@instructions.has_key?(mnemonic)
        return nil
      end
      
      inst = @instructions[mnemonic]
      inst.optypes << optype
      
    end
    
    
    def get_by_mnemonic(mnemonic)
      @instructions[mnemonic]
    end
    
  end


  #The extra info provided with script
  class ScriptHeader

    def initialize
      @stack_size = 0
      @global_data_size = 0
      @main_present = false
      @main_index
    end

  end

  def self.init_instr_table
  
    inst_table = XSM::InstructionTable.instance

    #mov operation defined here
    inst_table.add_instruction("mov", XSM::Constants::OPCODE_INSTR_MOV, 2)
    inst_table.add_optype("mov", XSM::Constants::OP_FLAG_TYPE_MEM_REF |
                                 XSM::Constants::OP_FLAG_TYPE_REG )

    inst_table.add_optype("mov", XSM::Constants::OP_FLAG_TYPE_INT |
                                 XSM::Constants::OP_FLAG_TYPE_FLOAT |
                                 XSM::Constants::OP_FLAG_TYPE_STRING |
                                 XSM::Constants::OP_FLAG_TYPE_MEM_REF |
                                 XSM::Constants::OP_FLAG_TYPE_REG )

  end
  
end


