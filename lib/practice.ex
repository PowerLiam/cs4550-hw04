defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    factor_helper(Integer.parse(x), [], 2)
  end

  def factor_helper(x, acc, cand) do
    cond do
      cand >= :math.sqrt(x) ->
        acc ++ [cand]
      rem(x, cand) == 0 ->
        factor_helper(div(x, cand), acc ++ [cand], 2)
      true ->
        factor_helper(x, acc, cand + 1)
    end
  end

  def palindrome?(x) do
    # x
    # |> codepoints()
    # |> Enum.with_index
    # |> Enum.reduce_while(true, fn({letter, index}, acc) -> if letter ==  )
    String.reverse(x) == x
  end
end
