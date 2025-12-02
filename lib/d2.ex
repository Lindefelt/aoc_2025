defmodule D2 do
  require Integer
  defp parse_input() do
    "data/02/input.txt"
    |> File.read!()
    |> String.split(",")

  end
  defp recur(a,b,acc)
    when a > b, do: acc

  defp recur(a,b, acc) do
    #IO.puts(a)
    str = to_string(a)
    acc = if (Integer.is_even(String.length(str))) do
            {p1,p2}  = String.split_at(str,div(String.length(str),2))

      if p1 == p2 do
        #IO.puts("Found #{a}")
        [a|acc]
      else
        acc
      end
    else
      acc
    end
    recur(a + 1,b,acc )
  end

  defp solve_p1(data) do
    Enum.flat_map(data, fn {a,b} -> recur(a,b,[]) end) |> Enum.sum()
  end

  defp find2(a,b,acc)
  when a > b, do: acc

  defp find2(a,b, acc) do
    #IO.puts(a)
    str = to_string(a)
    found = findseq(str,String.length(str),1)

    acc = if(found==str) do
        #IO.puts("Found #{a}")
         [a | acc]
    else
      acc
    end

    find2(a + 1,b,acc )
  end

  defp findseq(_a,length,chunksize)
    when chunksize >= length  , do: nil

  defp findseq(a,length,chunksize) do
    chunk = Enum.chunk_every(String.graphemes(a),chunksize)
    if(length(Enum.dedup(chunk))==1) do
      a
    else findseq(a,length,chunksize + 1)

   end
  end

  defp solve_p2(data) do
    Enum.flat_map(data, fn {a,b} -> find2(a,b,[]) end)|> Enum.sum(
)
  end

  def main() do
    data = parse_input()
    #IO.inspect(data)
    d = Enum.map(data, fn s  -> String.split(s,"-") end) |> Enum.map( fn [a,b] -> {String.to_integer(a), String.to_integer(b)} end)
    #IO.inspect(d)

    {time_p1,result_p1} = :timer.tc( fn -> solve_p1(d)end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

    {time_p2,result_p2} = :timer.tc( fn -> solve_p2(d)end)
    IO.puts("P2: #{result_p2}")
    IO.puts("µs P2: #{time_p2}")

  end
end
