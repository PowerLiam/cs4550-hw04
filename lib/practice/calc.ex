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
    |> Enum.reduce(
      {[], []}, 
      fn(ele, {op_stack, result}) -> 
        cond do
          op?(ele) ->
            {popped, remaining_stack} = pop_lower_ops(ele, op_stack)
            {remaining_stack, result ++ popped}
          true ->
            {op_stack, result ++ [ele]}
        end
      end
      )
    |> IO.puts()

    # Hint:
    # 5 + 7 * 9 - 4 / 2
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  # {popped, remaining_stack}
  def pop_lower_ops(op, op_stack) do
    cond do
      op_cmp(op, last(op_stack)) >= 0 ->
        {popped_op, remaining_stack} = pop_at(op_stack, length(op_stack) - 1)
        {later_popped_ops, later_remaining_stack} = pop_lower_ops(op, remaining_stack)
        {[popped_op] ++ later_popped_ops, later_remaining_stack}
      true ->
        {[], op_stack}
    end
  end

  def op?(x) do
    x == "+" or x == "x" or x == "/" or x == "-"
  end

  def op_cmp(x, y) do
    low_ops = MapSet.new(["+", "-"])
    high_ops = MapSet.new(["x", "/"])
    op_num(x) - op_num(y)
  end

  def op_num(x) do
    cond do
      MapSet.member?(low_ops, x) ->
        1
      MapSet.member?(low_ops, x) ->
        0
      true ->
        raise x + " is not an operator"
    end
  end
    
end
