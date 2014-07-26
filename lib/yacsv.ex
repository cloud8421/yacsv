defmodule Yacsv do
  @moduledoc "Parses a csv string and returns a list of words"

  defmodule State do
    defstruct current_word: [], all_words: [], quoted: false
  end

  @doc """
  Parses a binary string and returns a list with included words.
  iex> Yacsv.parse("OSI, Office of Strategic Influence, 2003")
  ["OSI", "Office of Strategic Influence", "2003"]

  It supports two optional parameters:

  - separator (char)
  iex> Yacsv.parse("OSI-Office of Strategic Influence-2003", '-')
  ["OSI", "Office of Strategic Influence", "2003"]

  - quote_char (char)
  Yacsv.parse("OSI, Office of Strategic Influence, 'Hello, Helicopter!', 2003", ',', '\'')
  ["OSI", "Office of Strategic Influence", "Hello, Helicopter!", "2004"]
  """
  def parse(string, separator \\ ',', kuote \\ '"') do
    [ separator_char ] = separator
    [ quote_char ] = kuote
    parse(string |> to_char_list, separator_char, quote_char, %State{})
      |> strip_spaces
  end
  defp parse([], _separator, _quote_char, state) do
    state = add_current_word_to_all_words(state)
    put_in state.all_words, (state.all_words |> Enum.reverse)
  end
  defp parse([head | tail], separator, quote_char, state) do
    state = parse_char(head, separator, quote_char, state, state.quoted)
    parse(tail, separator, quote_char, state)
  end

  defp parse_char(char, _separator, quote_char, state, _quoted) when char == quote_char do
    put_in state.quoted, !state.quoted
  end
  defp parse_char(char, separator, _quote_char, state, false) when char == separator do
    add_current_word_to_all_words(state)
  end
  defp parse_char(char, _separator, _quote_char, state, _quoted) do
    put_in state.current_word, [ char | state.current_word ]
  end

  defp add_current_word_to_all_words(state) do
    state = put_in state.current_word, (state.current_word |> Enum.reverse)
    state = put_in state.all_words, [ state.current_word | state.all_words ]
    put_in state.current_word, []
  end

  defp strip_spaces(state) do
    Enum.map state.all_words, fn(charlist) ->
      to_string(charlist) |> String.strip
    end
  end

end
