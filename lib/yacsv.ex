defmodule Yacsv do

  defrecord YacsvState, current_word: [], all_words: [], quoted: false

  def parse(string, separator // ',') do
    [ separator_char ] = separator
    state = do_parse(string |> bitstring_to_list, separator_char, YacsvState.new)
    Enum.map state.all_words, fn(charlist) ->
      list_to_bitstring(charlist) |> String.strip
    end
  end

  defp do_parse([], _separator, state) do
    state = add_current_word_to_all_words(state)
    state = state.all_words(state.all_words |> Enum.reverse)
  end
  defp do_parse([head | tail], separator, state) do
    state = parse_char(head, separator, state)
    do_parse(tail, separator, state)
  end

  defp parse_char(char, separator, state) when char == separator do
    add_current_word_to_all_words(state)
  end
  defp parse_char(char, separator, state) do
    state = state.current_word [ char | state.current_word ]
  end

  defp add_current_word_to_all_words(state) do
    state = state.current_word(state.current_word |> Enum.reverse)
    state = state.all_words [ state.current_word | state.all_words ]
    state = state.current_word []
  end

end
