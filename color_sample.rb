class SomeClass < SomeOtherClass
  SOME_CONSTANT = 'blah' # constants are blue/std lib constants are mauve

  attr_accessor :arse, :arse_2 # keywords are mid brown
  # a comment

  def initialize(*args, &block) # args are blue
    @instance_var = args.first
    "a string" # strings are green
    "another string #{ with interpolation }" # with yellow interpolation
    1245 # ints are red
  end

  def iteration # method names are darker brown
    collection.each { |pipe| puts pipe  }
  end
end
