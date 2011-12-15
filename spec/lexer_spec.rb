require 'asm/lex'

describe XSM::Lexer do
  before(:each) do
    str_list = [
      " ;mov a,b ",
      " mov a,b ;hello ",
      ' mov a,"hello ;moto;" ',
      "mov a,b"
    ]
    @src = StringIO.new(str_list.join("\n"))
    @lexer = XSM::Lexer.instance
    if !@lexer.inited?
      @lexer.init_lexer(@src)
    else
      @lexer.reset_lexer
    end
  end

  it "should strip comments" do
    @lexer.strip_comments
    @lexer.rm_white_space
    @lexer.src_lines[0].should == ""
    @lexer.src_lines[1].should == "mov a,b"
    @lexer.src_lines[2].should == 'mov a,"hello ;moto;"'
    @lexer.src_lines[3].should == 'mov a,b'
  end
end

