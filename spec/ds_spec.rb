require 'asm/ds'

describe StringTable do
  
  it "should work as linked list" do
    str_table = StringTable.instance
    str_table.<<("mov a,b").should == 0
    str_table.<<("mov a,b").should == 0
    str_table[0].should == "mov a,b"
  end
end

