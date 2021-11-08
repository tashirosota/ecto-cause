defmodule Ecto.Cause do
  @moduledoc """
  Documentation for `Ecto.Cause`.
  """

  defmacro __using__(_) do
    quote do
      defoverridable all: 3

      def all(name, queryable, opts) when is_list(opts) do
        origin_response = super(name, queryable, opts)
        get_location_element = &elem(&1, 3)

        get_match_pach_location =
          &(Enum.at(&1, 0) |> elem(1) |> to_string() |> String.match?(~r/lib\//))

        Process.info(self(), :current_stacktrace)
        |> elem(1)
        |> Enum.map(get_location_element)
        |> Enum.find(get_match_pach_location)
        |> IO.inspect()

        origin_response
      end
    end
  end
end
