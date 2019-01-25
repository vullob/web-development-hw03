defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.trim
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> convert_to_postfix
    |> calculate
  end


  def calculate(expr) do
    output = List.foldl(expr, [], fn x, acc -> evaluate_postfix(x, acc) end)
    hd(output)
  end


  # acc is {output, [stack])
  # element is the current element being read
  def evaluate_postfix(element, acc) do
    rhs = List.pop_at(acc, 0)
    lhs = List.pop_at(elem(rhs, 1), 0)
    case element do
        {:num, x} -> [x|acc]
        {:add, "+"} -> [elem(lhs, 0) + elem(rhs, 0) | elem(lhs, 1)]
        {:sub, "-"} -> [elem(lhs, 0) - elem(rhs, 0) | elem(lhs, 1)]
        {:mul, "*"} -> [elem(lhs, 0) * elem(rhs, 0) | elem(lhs, 1)]
        {:div, "/"} -> [elem(lhs, 0) / elem(rhs, 0) | elem(lhs, 1)]
    end
  end


  def convert_to_postfix(arr) do
    val = List.foldl(arr, {[], []}, fn x, acc -> postfix_char(x, acc) end)
     elem(val, 0) ++ Enum.reverse(elem(val, 1))
   end

 def postfix_char(char, accumulator) do
    acc = elem(accumulator, 0)
    storedOps = elem(accumulator, 1)
    cond do
      elem(char, 0) != :num && length(storedOps) == 0 -> {acc, [char]}
      true ->
        case char do
          {:num, _} -> { acc ++ [char], storedOps}
          {:add, "+"} -> { acc ++ Enum.reverse(storedOps), [char] }
          {:div, "/"} -> postfix_mul_div(char, acc, storedOps)
          {:sub, "-"} -> { acc ++ Enum.reverse(storedOps), [char] }
          {:mul, "*"} -> postfix_mul_div(char, acc, storedOps)
        end
   end
end

   def postfix_mul_div(char, acc, storedOps) do
    case hd(storedOps) do
      {:add, "+"} -> { acc, storedOps ++ [char] }
      {:sub, "-"} -> { acc, storedOps ++ [char] }
      {:mul, "*"} -> { acc ++ Enum.reverse(storedOps), [char]}
      {:div, "/"} -> { acc ++ Enum.reverse(storedOps), [char]}
    end
   end

  def tag_tokens(arr) do
    Enum.map(arr, fn x -> tokenize_char(x) end)
  end

  def tokenize_char(char) do
   cond do
      char == "+" -> {:add, char}
      char == "/" -> {:div, char}
      char == "-" -> {:sub, char}
      char == "*" -> {:mul, char}
      Float.parse(char) -> {:num, elem(Float.parse(char), 0)}
    end
  end
end
