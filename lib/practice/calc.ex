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
    |> (fn({op_stack, result}) ->
          result ++ Enum.reverse(op_stack) end).()
    |> eval_postfix([])
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
    stack_head = List.last(op_stack)
    IO.puts("--------")
    IO.puts(op)
    IO.puts(op_stack)
    if stack_head != nil do
      IO.puts(op_cmp(op, stack_head))
    end
    IO.puts("--------")
    cond do
      stack_head == nil or  op_cmp(op, stack_head) > 0 ->
        {[], op_stack ++ [op]}
      true ->
        {popped_op, remaining_stack} = List.pop_at(op_stack, length(op_stack) - 1)
        {later_popped_ops, later_remaining_stack} = pop_lower_ops(op, remaining_stack)
        {[popped_op] ++ later_popped_ops, later_remaining_stack}
    end
  end

  def op?(x) do
    x == "+" or x == "*" or x == "/" or x == "-"
  end

  def op_cmp(x, y) do
    op_num(x) - op_num(y)
  end

  def op_num(x) do
    low_ops = MapSet.new(["+", "-"])
    high_ops = MapSet.new(["*", "/"])
    cond do
      MapSet.member?(high_ops, x) ->
        1
      MapSet.member?(low_ops, x) ->
        0
      true ->
        raise "#{x} is not an operator"
    end
  end

  def eval_postfix(l, stack) do
    {next, rest} = List.pop_at(l, 0)
    IO.puts("STACK: #{stack}")
    cond do
      next == nil ->
        {head, _} = List.pop_at(stack, length(stack) - 1)
        head
      op?(next) ->
        {r1, rem_stack} = List.pop_at(stack, length(stack) - 1)
        {r2, rem_stack} = List.pop_at(rem_stack, length(rem_stack) - 1)
        eval_postfix(rest, rem_stack ++ [eval_op(r2, r1, next)])
      true ->
        eval_postfix(rest, stack ++ [next])
    end
  end

  def eval_op(r1, r2, op) do
    {rand1, _} = Float.parse(r1)
    {rand2, _} = Float.parse(r2)
    IO.puts("#{r1} #{op} #{r2}")
    cond do
      op == "+" ->
        Float.to_string(rand1 + rand2)
      op == "-" ->
        Float.to_string(rand1 - rand2)
      op == "*" ->
        Float.to_string(rand1 * rand2)
      op == "/" ->
        Float.to_string(rand1 / rand2)
    end
  end
    
end
