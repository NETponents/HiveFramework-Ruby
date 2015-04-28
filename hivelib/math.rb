def add(one, two)
  return one + two
end
def subtract(one, two)
  return one - two
end
def multiply(one, two)
  return one * two
end
def divide(one, two)
  if two == 0
    require './hivelib/warning'
    declare_warning("MATH:DIVIDE:DIVIDEBYZERO", false)
    return 0
  end
  return one / two
end
