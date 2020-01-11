require "./must/errors"
require "./must/**"

class Object
  include Must::ObjectExtensions
end
