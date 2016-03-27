defmodule CloseEnoughTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CloseEnough
  test "List.flatte instead of List.flatten" do
    Process.flag(:error_handler, CloseEnough)
    assert List.flatte([1,2,[3,4]]) == [1, 2, 3, 4]
  end
 
  test "Map.delte instead of Map.delete" do
    Process.flag(:error_handler, CloseEnough) 
    assert Map.delte(%{a: 1, b: 2}, :a) == %{b: 2}
  end
 
  test "Integer.to_strign instead of Integer.to_string" do
    Process.flag(:error_handler, CloseEnough)
    assert Integer.to_strign(123) == "123"
  end
   
  test "Integer.to_st instead of Integer.to_string should not guess" do
    Process.flag(:error_handler, CloseEnough)
    assert_raise UndefinedFunctionError, fn ->
      Integer.to_st(123)
    end
  end
end
