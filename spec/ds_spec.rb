require 'asm/ds'
require 'asm/error'

describe StringTable do
  
  it "should work as linked list" do
    str_table = StringTable.instance
    str_table.<<("mov a,b").should == 0
    str_table.<<("mov a,b").should == 0
    str_table[0].should == "mov a,b"
  end
end


describe SymbolTable do
  
  before(:each) do
    @sym_table = SymbolTable.instance
  end
  
  after(:each) do
    @sym_table.reset
  end
  
  it "should add a new SymbolNode" do
    @sym_table.add_symbol("val", 1, 10, 2)
  end
  
  it "should not add duplicates" do
    @sym_table.add_symbol("val", 1, 10, 2)
    lambda { @sym_table.add_symbol("val", 1, 10, 2) }.should raise_error(AsmSymbolError)
  end
  
  it "should get an existing SymbolNode" do
    @sym_table.add_symbol("val", 1, 10, 2)
    sym_node = @sym_table.get_sym_by_name("val", 2)
    sym_node.func_index.should == 2
    sym_node.size.should == 1
    sym_node.ident_name.should == "val"
    sym_node.stack_index.should == 10
    
  end
  
  it "should return nil for non existing SymbolNodes" do
    @sym_table.get_sym_by_name("val", 2).should == nil
  end
  
  it "should return stack index" do
    @sym_table.add_symbol("val", 1, 10, 2)
    @sym_table.get_stack_index("val",2).should == 10
  end
  
  it "should return identifier size" do
    @sym_table.add_symbol("val", 1, 10, 2)
    @sym_table.get_ident_size("val",2).should == 1
  end
  
end