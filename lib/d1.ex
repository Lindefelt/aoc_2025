defmodule D1 do
  def main() do

  {microseconds,_} = :timer.tc(fn ->

  file = File.read!("data/01/input.txt")
  #IO.puts(file)

  inputs = String.split(file)

  #Enum.each(inputs, fn x -> IO.puts(x) end)
  startval = 50;

  {_final_val,final_zeros,extra_zeros} = Enum.reduce(inputs, {startval,0,0}, fn line, {acc,zeros,extra_zeros} ->
    {command,step} = String.split_at(line,1)
    stepval = String.to_integer(step)

    {new_val,new_passes} = case(command) do
      "R"-> val = Integer.mod(acc + stepval, 100)
            passes =  div(acc + stepval, 100)
      {val,passes}

      "L"-> val = Integer.mod(acc - stepval, 100)
                    passes =
              cond do
                stepval < acc ->
                  0

                acc == 0 ->
                  div(stepval, 100)
                true ->
                  1 + div(stepval - acc, 100)

              end

            {val, passes}
      {val,passes}
    end
  #Count stops at zero
  new_zeros = if new_val == 0, do: zeros + 1, else: zeros

  #Count each time we pass zero
  extra_zeros = extra_zeros+new_passes


  #IO.puts("Zeros: #{new_zeros}")
  #IO.puts(new_val)
  {new_val,new_zeros,extra_zeros}
  end)

  #IO.puts("val: #{final_val}")
  IO.puts("P1: #{final_zeros}")
  IO.puts("P2: #{extra_zeros}")
  #IO.puts("Total Zero: #{final_zeros+extra_zeros}")
  end)
  IO.puts("Time in microseconds:#{microseconds}")
  end
end
