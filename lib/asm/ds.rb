#Some internal data structures that represents the code
require 'singleton'
require File.join(File.dirname(__FILE__), 'error')

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

=begin
  Symbol table keeps the symbols used in functions as well as
  global ones. The only difference is that global data is put
  at the end of the stack.
=end

class SymbolTable
  
  include Singleton
  
  def initialize
    # That data structure is like : 
    # function_index : identifier_data
    # identifer_data : sym_name : symbol_data
    # {func_index : {sym_name : {SymbolNode}}}
    @symbols = {}
  end
  
  def reset
    @symbols = {}
  end
  
  def add_symbol(sym_name, size, stack_index, func_index)
    if !@symbols.has_key?(func_index)
      @symbols[func_index] = {}
    end
    
    if @symbols[func_index].has_key?(sym_name)
      raise AsmSymbolError, "SymbolName : #{sym_name} already defined in function : #{func_index}"
    end
    
    symbol = SymbolNode.new(0, func_index, size, sym_name, stack_index)
    @symbols[func_index] = {}
    @symbols[func_index][sym_name] = symbol
    
  end
  
  def get_sym_by_name(sym_name, func_index)
    
    if @symbols.has_key?(func_index) && @symbols[func_index].has_key?(sym_name)
      return @symbols[func_index][sym_name]
    end
    
    nil
    
  end
  
  def get_stack_index(sym_name, func_index)
    symbol = self.get_sym_by_name(sym_name, func_index)
    if symbol.nil?
      return nil
    end
    
    return symbol.stack_index
  end
  
  def get_ident_size(sym_name, func_index)
    symbol = self.get_sym_by_name(sym_name, func_index)
    if symbol.nil?
      return nil
    end
    
    return symbol.size
  end
  
end


class SymbolNode
  
  attr_accessor :index, :func_index, :size, :ident_name, :stack_index
  
  def initialize(index, func_index, size, ident_name, stack_index)
    
    @index = index
    @func_index = func_index
    @size = size
    @ident_name = ident_name
    @stack_index = stack_index
    
    
  end
  
end