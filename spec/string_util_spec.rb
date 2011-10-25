require 'util/str_util'

describe StringUtil do
  
  it "should test_numeric?" do
    StringUtil.numeric?('1').should == true
    StringUtil.numeric?('A').should == false
  end
  
  it "should test_whitespace?" do
    StringUtil.whitespace?(" ").should == true
    StringUtil.whitespace?("\t").should == true
    StringUtil.whitespace?("A").should == false
  end
  
  it "should test_ident?" do
    
    StringUtil.ident?('b').should == true
    StringUtil.ident?('B').should == true
    StringUtil.ident?('0').should == true
    StringUtil.ident?('_').should == true
    StringUtil.ident?(' ').should == false
    StringUtil.ident?('\t').should == false
    StringUtil.ident?('-').should == false
  
  end
  
  it "should test_delimiter?" do
    
    StringUtil.delimiter?(']').should == true
    StringUtil.delimiter?('[').should == true
    StringUtil.delimiter?('}').should == true
    StringUtil.delimiter?('{').should == true
    StringUtil.delimiter?(':').should == true
    StringUtil.delimiter?(',').should == true
    StringUtil.delimiter?('"').should == true
    StringUtil.delimiter?(' ').should == true
    StringUtil.delimiter?("\t").should == true
    StringUtil.delimiter?('a').should == false
    StringUtil.delimiter?('B').should == false
    StringUtil.delimiter?('_').should == false

  end

  it "should test_str_int?" do
    
    StringUtil.str_int?("123").should == true
    StringUtil.str_int?("-123").should == true
    StringUtil.str_int?("-1-2-3").should == false
    StringUtil.str_int?(" 123").should == false
    StringUtil.str_int?("a123").should == false
    StringUtil.str_int?("123b").should == false
    StringUtil.str_int?("1b3").should == false
    StringUtil.str_int?("").should == false
    StringUtil.str_int?(nil).should == false
  
  end
  
  it "should test_str_float?" do
    
    StringUtil.str_float?("0.123").should == true
    StringUtil.str_float?("-0.123").should == true
    StringUtil.str_float?("12.3").should == true
    StringUtil.str_float?("-1.23").should == true
    StringUtil.str_float?("-12.3").should == true
    #the false cases as i can imagine
    StringUtil.str_float?("01.23").should == false
    StringUtil.str_float?("-01.23").should == false
    StringUtil.str_float?("123").should == false
    StringUtil.str_float?("-123").should == false
    StringUtil.str_float?("-1.-2-3").should == false
    StringUtil.str_float?(" 12.3").should == false
    StringUtil.str_float?("a123").should == false
    StringUtil.str_float?("1.23b").should == false
    StringUtil.str_float?("1b3").should == false
    StringUtil.str_float?("").should == false
    StringUtil.str_float?(nil).should == false
  
  end
  
  it "should test_str_whitespace?" do
    StringUtil.str_whitespace?("").should == true
    StringUtil.str_whitespace?('   ').should == true
    
    #false ones
    StringUtil.str_whitespace?(nil).should == false
    StringUtil.str_whitespace?("abc").should == false
  end
  
  it "should test_str_ident?" do
    
    StringUtil.str_ident("var").should == true
    StringUtil.str_ident("var123").should == true
    StringUtil.str_ident("v1a2r3").should == true
    StringUtil.str_ident("_123var").should == true
    StringUtil.str_ident("__1var").should == true
    
    StringUtil.str_ident("123var").should == false
    StringUtil.str_ident("var?988").should == false
    StringUtil.str_ident("").should == false
    StringUtil.str_ident(nil).should == false
  
  end
  
end

