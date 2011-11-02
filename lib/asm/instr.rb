# Here you can find classes that represents the instructions
class Instruction
  
  def initialize()
    @opcode = 0
    @opcount = 0
    @oplist = []
  end
  
end


class Operand
  
  def initialize
    @optype = nil
    @value = nil
    @index_offset = 0
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