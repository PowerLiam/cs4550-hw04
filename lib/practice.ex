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
    if x == 1 do
      []
    else
      for n <- Range.new(1, ciel(:math.sqrt(x))), do:
        if rem(x, n) == 0 do
          [n | factor(div(x, n))]
        end
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
