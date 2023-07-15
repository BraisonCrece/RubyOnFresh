# def self.const_missing(c):
# We're overwriting const_missing.
# 'c' is the name of the constant that is being accessed and is not defined.
#
# return nil if @calling_const_missing:
# Flag to prevent an infinite loop in case the required file does not define the constant.
#
# @calling_const_missing = true:
# Flag definition.
# This indicates that we are in the process of handling an undefined constant.
#
# require Fresh.to_underscore(c.to_s):
# Here we are using the to_underscore function of the Fresh class or module to convert the constant's name
# to a snake_case format. Then, require loads the file with that name.
# For example, if the undefined constant is MyClass, then this could load the file "my_class.rb".
#
# Object.const_get(c):
# After loading the file, we attempt to get the constant again.
# If the file loading defined the constant, then this will return the constant;
# otherwise, const_missing will be called again,
# but since @calling_const_missing is true, it will simply return nil.
#
# @calling_const_missing = false:
# Flag set to false to indicate that we have finished handling the undefined constant.

class Object
  def self.const_missing(c)
    file_name = Fresh.to_underscore(c.to_s)
    require file_name

    unless const_defined?(c)
      raise NameError.new("Uninitialized constant #{c}, not defined in #{file_name}")
    end

    Object.const_get(c)
  rescue LoadError
    raise NameError.new("Uninitialized constant #{c}, unable to load #{file_name}")
  end
end
