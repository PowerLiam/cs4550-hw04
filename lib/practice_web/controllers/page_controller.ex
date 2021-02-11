defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    IO.puts("RUNNING CALC")
    try do
      y = Practice.calc(expr)
      IO.puts("Result: #{y}")
      render conn, "calc.html", expr: expr, y: Float.to_string(y)
    rescue e -> IO.puts(e.message) catch e -> IO.puts(e.message) end
    end
  end

  def factor(conn, %{"x" => x}) do
    y = Practice.factor(String.to_integer(x))
    render conn, "factor.html", x: x, y: Enum.join(y, ", ")
  end

  def palindrome(conn, %{"x" => x}) do
    y = Practice.palindrome?(x)
    render conn, "palindrome.html", x: x, y: y
  end
end
