defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> convert_to_postfix
 #   |> IO.puts
 #  |> hd
 #  |> parse_float
 #  |> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end


  def convert_to_postfix(arr) do
    val = List.foldl(arr, {[], []}, fn x, acc -> val = postfix_char(x, acc);
                                 IO.inspect(val); IO.inspect(val); val   end)
     IO.puts("stored OPS")
     IO.inspect(val)
     elem(val, 0) ++ elem(val, 1) 
     end

 def postfix_char(char, accumulator) do
    IO.puts("new char")
    IO.inspect(char)
    acc = elem(accumulator, 0)
    storedOps = elem(accumulator, 1)
    cond do 
      length(storedOps) == 0 -> {acc, [char]}
      true -> 
        case char do
          {:num, x} -> { acc ++ [char], storedOps} 
          {:add, x} -> { acc ++ Enum.reverse(storedOps), [char] } 
          {:div, x} -> postfix_mul_div(char, acc, storedOps)
          {:sub, x} -> { acc ++ Enum.reverse(storedOps), [char] }
          {:mul, x} -> postfix_mul_div(char, acc, storedOps)
        end   
   end
end

   def postfix_mul_div(char, acc, storedOps) do
    case hd(storedOps) do
      {:add, x} -> { acc, storedOps ++ [char] }
      {:sub, x} -> { acc, storedOps ++ [char] }
      {:mul, x} -> { acc ++ Enum.reverse(storedOps), [char]}
      {:div, x} -> { acc ++ Enum.reverse(storedOps), [char]}
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
