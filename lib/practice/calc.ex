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
    |> IO.puts
 #  |> convert_to_postfix
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


#  def convert_to_postfix(arr) do
#    operators = []
#    foldl(arr, [], fn x, acc -> cond do
#                                  elem(x, 0) == :num -> [acc | x]
#                                  elem(x, 0) == :add -> acc ++ operators
#                                  elem(x, 0) == :sub -> acc ++ operators)
#                                  elem(x, 0) == :mul -> acc ++ 
#  end

#  def parse_postfix(x, acc, operators) do
#     cond do
#       elem(x, 0) == :num -> acc += elem(x, 1)
#       
#  end
  

  def tag_tokens(arr) do
   List.foldl(arr, [], fn x, acc -> acc ++ [acc | tokenize_char(x)] end)
  end

  def tokenize_char(char) do
    cond do
      Float.parse(char) -> {:num, Float.parse(char)}
      char == "+" -> {:add, char}
      char == "/" -> {:div, char}
      char == "-" -> {:sub, char}
      char == "*" -> {:mul, char}
    end 
  end
end
