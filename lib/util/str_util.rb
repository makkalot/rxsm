module XSM
  class StringUtil

    def self.numeric?(ch)
      ('0'..'9').include? ch
    end

    def self.whitespace?(ch)
      if ch == " " || ch == "\t"
        return true
      end
      return false
    end


    def self.ident?(ch)
      if ('0'..'9').include?(ch) ||
         ('a'..'z').include?(ch) ||
         ('A'..'Z').include?(ch) ||
         ch == '_'
       return true
      end
      return false
    end


    def self.delimiter?(ch)

      if ch == ']' || ch == '[' ||
         ch == '}' || ch == '{' ||
         ch == ':' || ch == ',' ||
         ch == '"' || StringUtil.whitespace?(ch)
       return true
      end
      return false
    end

    def self.str_int?(str)

      if str.nil? || str.length == 0
        return false
      end

      #fisrt check the first char if it is minus
      str_enum = str.each_char
      first_ch = str_enum.next
      if first_ch != '-' && !StringUtil.numeric?(first_ch)
        return false
      end

      loop do
        if !StringUtil.numeric?(str_enum.next)
          return false
        end
      end

      return true
    end

    def self.str_float?(str)
      if str.nil? || str.length < 3
        return false
      end

      #fisrt check the first char if it is minus
      signed = false
      starts_zero = false

      str_enum = str.each_char
      first_ch = str_enum.next
      if first_ch != '-' && !StringUtil.numeric?(first_ch)
        return false
      elsif first_ch == '-'
        signed = true
      elsif first_ch == '0'
        starts_zero = true
      end

      #it can be 
      #0
      #-
      #1..9
      dots = 0

      second_char = str_enum.next
      if starts_zero && second_char != '.'
        return false
      elsif signed && !StringUtil.numeric?(second_char)
        return false
      elsif second_char!= '.' && !StringUtil.numeric?(second_char)
        return false
      end

      if second_char == '.'
        dots = 1
      elsif second_char == '0'
        starts_zero = 1
      end
      #it can be 
      #0.
      #-1
      #-0
      #12
      #1.

      #there is a special case where it is signed and starts with 0
      third_char = str_enum.next
      if starts_zero && signed && third_char != '.'
        return false
      elsif third_char == '.'
        if dots > 0
          return false
        end
        dots += 1
      elsif !StringUtil.numeric?(third_char)
        return false
      end

      loop do
        ch = str_enum.next
        if ch == '.'
          if dots >= 1
            return false
          end
          dots += 1
        elsif !StringUtil.numeric?(ch)
          return false
        end
      end

      if dots == 0
        return false
      end

      return true
    end

    def self.str_whitespace?(str)

      if str == nil 
        return false
      end

      if str.length == 0
        return true
      end

      str.each_char do |ch|
        if !StringUtil.whitespace?(ch)
          return false
        end
      end

      return true

    end

    def self.str_ident(str)

      if str == nil || str.length == 0
        return false
      end

      if StringUtil.numeric?(str[0])
        return false
      end


      str.each_char do |ch| 
        if !StringUtil.ident?(ch)
          return false
        end
      end

      return true

    end
  
  end
end