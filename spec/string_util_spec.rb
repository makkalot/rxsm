require 'util/str_util'

describe XSM::StringUtil do
  
  it "should test_numeric?" do
    XSM::StringUtil.numeric?('1').should == true
    XSM::StringUtil.numeric?('A').should == false
  end
  
  it "should test_whitespace?" do
    XSM::StringUtil.whitespace?(" ").should == true
    XSM::StringUtil.whitespace?("\t").should == true
    XSM::StringUtil.whitespace?("A").should == false
  end
  
  it "should test_ident?" do
    
    XSM::StringUtil.ident?('b').should == true
    XSM::StringUtil.ident?('B').should == true
    XSM::StringUtil.ident?('0').should == true
    XSM::StringUtil.ident?('_').should == true
    XSM::StringUtil.ident?(' ').should == false
    XSM::StringUtil.ident?('\t').should == false
    XSM::StringUtil.ident?('-').should == false
  
  end
  
  it "should test_delimiter?" do
    
    XSM::StringUtil.delimiter?(']').should == true
    XSM::StringUtil.delimiter?('[').should == true
    XSM::StringUtil.delimiter?('}').should == true
    XSM::StringUtil.delimiter?('{').should == true
    XSM::StringUtil.delimiter?(':').should == true
    XSM::StringUtil.delimiter?(',').should == true
    XSM::StringUtil.delimiter?('"').should == true
    XSM::StringUtil.delimiter?(' ').should == true
    XSM::StringUtil.delimiter?("\t").should == true
    XSM::StringUtil.delimiter?('a').should == false
    XSM::StringUtil.delimiter?('B').should == false
    XSM::StringUtil.delimiter?('_').should == false

  end

  it "should test_str_int?" do
    
    XSM::StringUtil.str_int?("123").should == true
    XSM::StringUtil.str_int?("-123").should == true
    XSM::StringUtil.str_int?("-1-2-3").should == false
    XSM::StringUtil.str_int?(" 123").should == false
    XSM::StringUtil.str_int?("a123").should == false
    XSM::StringUtil.str_int?("123b").should == false
    XSM::StringUtil.str_int?("1b3").should == false
    XSM::StringUtil.str_int?("").should == false
    XSM::StringUtil.str_int?(nil).should == false
  
  end
  
  it "should test_str_float?" do
    
    XSM::StringUtil.str_float?("0.123").should == true
    XSM::StringUtil.str_float?("-0.123").should == true
    XSM::StringUtil.str_float?("12.3").should == true
    XSM::StringUtil.str_float?("-1.23").should == true
    XSM::StringUtil.str_float?("-12.3").should == true
    #the false cases as i can imagine
    XSM::StringUtil.str_float?("01.23").should == false
    XSM::StringUtil.str_float?("-01.23").should == false
    XSM::StringUtil.str_float?("123").should == false
    XSM::StringUtil.str_float?("-123").should == false
    XSM::StringUtil.str_float?("-1.-2-3").should == false
    XSM::StringUtil.str_float?(" 12.3").should == false
    XSM::StringUtil.str_float?("a123").should == false
    XSM::StringUtil.str_float?("1.23b").should == false
    XSM::StringUtil.str_float?("1b3").should == false
    XSM::StringUtil.str_float?("").should == false
    XSM::StringUtil.str_float?(nil).should == false
  
  end
  
  it "should test_str_whitespace?" do
    XSM::StringUtil.str_whitespace?("").should == true
    XSM::StringUtil.str_whitespace?('   ').should == true
    
    #false ones
    XSM::StringUtil.str_whitespace?(nil).should == false
    XSM::StringUtil.str_whitespace?("abc").should == false
  end
  
  it "should test_str_ident?" do
    
    XSM::StringUtil.str_ident("var").should == true
    XSM::StringUtil.str_ident("var123").should == true
    XSM::StringUtil.str_ident("v1a2r3").should == true
    XSM::StringUtil.str_ident("_123var").should == true
    XSM::StringUtil.str_ident("__1var").should == true
    
    XSM::StringUtil.str_ident("123var").should == false
    XSM::StringUtil.str_ident("var?988").should == false
    XSM::StringUtil.str_ident("").should == false
    XSM::StringUtil.str_ident(nil).should == false
  
  end
  
end

