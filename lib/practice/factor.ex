defmodule Practice.Factor do

 def factor(x) do
  x
  |> factor_recursive(2, [])
  |> Enum.reverse  # this is needed to pass the tests
  end


  def factor_recursive(x, n, acc) do
    cond do
      x <= 1 -> acc
      Integer.mod(x,n) == 0 -> factor_recursive(trunc(x/n), 2, [n | acc])
      true -> factor_recursive(x, n + 1, acc)
    end
  end


 def factor_odd(x, i, acc) do
   cond do
      i > trunc(:math.sqrt(x)) -> check_large_prime(x, acc)
      Integer.mod(x, i) == 0 -> factor_odd(trunc(x/i), i + 1, [i | acc])
      true -> factor_odd(x, i + 1, acc)
   end
 end


 def check_large_prime(x, acc) do
    cond do
      x > 2 ->  [x | acc]
      true -> acc
    end
 end
end

