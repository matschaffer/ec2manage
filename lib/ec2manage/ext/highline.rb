# Also allow access to the color method, otherwise I don't
# see how we could assign a color to a local variable
module Kernel
  def_delegators :$terminal, :color
end
