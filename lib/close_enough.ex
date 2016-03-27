require Logger
defmodule Elixir.CloseEnough do
  def undefined_function(module, fun, args) do
    ensure_loaded(module)
    case guess(module, fun) do
      {:error, _} -> 
        :error_handler.undefined_function(module, fun, args)
      {:ok, guessed_fun} when fun != guessed_fun-> 
        warn(fun, guessed_fun)
        apply(module, guessed_fun, args)
      {:ok, guessed_fun} ->
        apply(module, guessed_fun, args)
    end
  end

  def warn(a, b) do
    Elixir.Logger.warn "Could not find :#{a}, using function :#{b} instead"
  end

  def guess(module, fun) do
    exported_functions = module.module_info[:exports]
    nearest_function =  exported_functions
    |> Enum.map(fn {x, _} ->  {Levenshtein.distance('#{fun}', '#{x}'), x} end)
    |> Enum.min_by(fn {x, _} -> x end)
    case nearest_function do
      {distance, function} when distance <= 3  -> {:ok, function}
      {distance, _} when distance > 3 -> {:error, "No function found"}
    end
  end

  def undefined_lambda(module, fun, args) do
    ensure_loaded(module)
    :error_handler.undefined_lambda(module, fun, args)
  end

  defp ensure_loaded(module) do
    case Code.ensure_loaded(module) do
      { :module, _ } ->
        []
      { :error, _ } ->
        parent = Process.get(:elixir_parent_compiler)
        send parent, { :waiting, Process.self, module }
        receive do
          { :release, ^parent } -> ensure_loaded(module)
        end
    end
  end
end
