#It is the place where we put the lexer(scanner) logic
require 'singleton'

module XSM
  
  class Lexer
    
    attr_reader :src_lines 
    
    include Singleton
    
    def init_lexer(io_src)
      @io_src = io_src
      #get all of the lines here in internal structure
      @src_lines = io_src.readlines
    end
    
=begin
Stripping comments from the source is kind of straightfoward
but the problem here is "" strings, we should ignore the ;
comments that are in the strings ...
=end
    def strip_comments
      in_str = false
      @src_lines.each do |line|
        pos = line.each_char.with_index do |ch,i|
          if ch == '"'
            if in_str
              in_str = false
            else
              in_str = true
            end
          end
          
          if ch == ";" && !in_str
            break i
          end
          
        end
        
        if pos.class == Fixnum
          #strip them to the end of the file
          line.slice!(pos..-1)
        end
        
      end
    end
    
    def rm_white_space
      @src_lines.each do |line|
        line.strip!
      end
    end
    
    def next_token
      
    end
    
    def cur_lexeme
      
    end
    
    def look_ahead_char
      
    end
    
    def skip_next_line
      
    end
    
    
    def reset_lexer
      @io_src.rewind
      @src_lines.clear
    end
    
    def inited?
      #check if there is some source file supplied
      if self.instance_variable_defined?(:@io_src)
        return !@io_src.nil?
      end
      return false
    end

  end
  
end