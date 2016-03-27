# CloseEnough

Forget typos in function names now, CloseEnough takes care of them. 

## Example
Process.flag(:error_handler, CloseEnough)

and 

Integer.to_strign(123) gets converted to as Integer.to_string(123)  

## Installation

1. Add close_enough to your list of dependencies in mix.exs:

def deps do
  [{:close_enough, "~> 0.0.1"}]
end

2. Ensure close_enough is started before your application:

def application do
  [applications: [:close_enough]]
end
