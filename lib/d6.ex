defmodule D6 do
  require Integer

  defp parse_input() do
    lines = "data/06/input.txt"
    |> File.read!()
    |> String.split("\n")

    lines |> Enum.map(fn line -> line |> String.split()end )

  end

  defp transpose(list) do
    list |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  defp solve_p1(data) do
    transposed = data |> transpose()

    transposed |> Enum.reduce(0,fn row,acc ->
       {_,op} = row |> Enum.fetch(length(row)-1)

      operands = row |> Enum.drop(-1) |> Enum.map(&String.to_integer/1)

      res = cond do
        op == "+" -> Enum.reduce(operands,&+/2)
        op == "*" -> Enum.reduce(operands,&*/2)
      end
      acc+res
      end )


  end


  defp parse_input2() do
    lines = "data/06/input.txt"
    |> File.read!()
    |> String.split("\n")
    lines
  end
  defp split_operands_and_ops(tokens) do
  tokens
  |> Enum.reduce({[], []}, fn tok, {acc, current_nums} ->
    t = String.trim(tok)

    cond do
      t == "" ->
        {acc, current_nums}

      String.ends_with?(t, "+") or String.ends_with?(t, "*") ->
        op = String.last(t)
        num_str = String.trim_trailing(t, op) |> String.trim()
        num = String.to_integer(num_str)

        nums = current_nums ++ [num]
        {acc ++ [{nums, op}], []}

      true ->
        {acc, current_nums ++ [String.to_integer(t)]}
    end
  end)
  |> elem(0)
end

defp solve_p2(data) do
  reversed = data |> Enum.map(&(&1 |> String.reverse() |> String.graphemes()))
  reversed |> Enum.each(&IO.inspect/1)

  #IO.inspect(transpose(reversed))

  transposed = transpose(reversed)


 cleaned = transposed
  |> Enum.map(fn row -> IO.inspect(row)
    row |> List.to_string() |> String.trim()
  end)
#IO.inspect(cleaned)

result =  split_operands_and_ops(cleaned)
  |> Enum.reduce(0, fn {operands,op},acc ->
         res = cond do
        op == "+" -> Enum.reduce(operands,&+/2)
        op == "*" -> Enum.reduce(operands,&*/2)
      end
      acc+res
  end )
result
  end


  def main() do
    data = parse_input()
    data2 = parse_input2()

    {time_p1, result_p1} = :timer.tc(fn -> solve_p1(data) end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    {time_p2, result_p2} = :timer.tc(fn -> solve_p2(data2) end)
    IO.puts("P2: #{result_p2}")
    IO.puts("µs P2: #{time_p2}")
  end
end
