#Some internal data structures that represents the code
require 'singleton'

class StringTable
  
  include Singleton
  
  def initialize
    
    @str_table = []
    
  end
  
  #lets just proxy it to the under structure
  def method_missing(method_name, *args)
    @str_table.send(method_name, *args)
  end
  
  def <<(elem)

    index = @str_table.index(elem)
    if index == nil
      @str_table << elem
      return @str_table.length - 1
    end
    
    return index
    
  end
  
end


class FunctionNode
  
  def initialize
    
    @index = 0
    @name = ""
    @entry_point = 0  
    @paramCount = 0
    @local_data_size = 0
    
  end
  
end


class FunctionTable
  
  include Singleton
  
  def initialize
    
    #includes FunctionNodes
    @functions = {}
    
  end
  
  #lets just proxy it to the under structure
  def method_missing(method_name, *args)
    @functions.send(method_name, *args)
  end
  
end


class SymbolTable
  
  include Singleton
  
  def initialize
    @symbols = []
  end
  
  def add_symbol(sym_name, size, stack_index, func_index)
    
  end
  
  def get_sym_by_name(sym_name, func_index)
    
  end
  
end


class SymbolNode
  
  def initialize
    
    @index = 0 #what is that ?
    @func_index = 0
    @size = 0
    @ident_name = ""
    @stack_index = 0
    
    
  end
  
end