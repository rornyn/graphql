module Test

  def asdf
    puts 'hello'
  end
  private

  def my_method
    puts "in module"
  end
end

class A
  # include Test

end

# Test.send(:my_method)
obj = A.new
# obj.my_method

# obj.extend Test
# .get_file
# obj.my_method

obj.extend(Test).asdf
# o
