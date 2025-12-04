defmodule D4 do
  defp parse_input() do
    "data/04/input.txt"
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.graphemes/1)
  end




  defp remove_rolls(matrix,condition) do
    h = length(matrix)
    w = matrix |> hd() |> length()

    new_matrix = for r <- 0..(h-1) do
      for c <- 0..(w-1) do
        val = matrix |> Enum.at(r) |> Enum.at(c)
        adj = adjacent(matrix, r, c, h, w) |> Enum.count(&(&1 == "@"))

        if val == "@" and adj < condition do
          "x"
        else
          val
        end
      end
    end
  end

  #Returns adjacent nodes
  defp adjacent(matrix, r, c, h, w) do
        offsets = [
      {-1, -1}, {-1, 0}, {-1, 1},
      { 0, -1},          { 0, 1},
      { 1, -1}, { 1, 0}, { 1, 1}
    ]

    for {ro, co} <- offsets,
        x = r + ro,
        y = c + co,
        x >= 0 and x < h and y >= 0 and y < w do
      matrix |> Enum.at(x) |> Enum.at(y)
    end
  end

  defp solve_p1(matrix) do
    new_matrix = remove_rolls(matrix,4)
    new_matrix |> List.flatten() |> Enum.count(&(&1 == "x"))
  end


  def main() do
    matrix = parse_input()
    #val = solve_p1(matrix)

   {time_p1, val1} = :timer.tc(fn -> solve_p1(matrix) end)
   IO.puts("P1 removed: #{val1}")
   IO.puts("µs P1: #{time_p1}")

   #{time_p2, val2} = :timer.tc(fn -> solve_p2(matrix) end)
   #IO.puts("P1 removed: #{val2}")
   #IO.puts("µs P1: #{time_p2}")
  end
end
