Code.load_file("passphrase.exs", __DIR__)

ExUnit.start

defmodule PassphraseTest do
  use ExUnit.Case

  test "part one finds count of valid phrases" do
    assert PassphraseOne.count_valid("passphrase_test_inputs.txt") == 2
    assert PassphraseOne.valid_passphrase?("aa bb cc")
    assert PassphraseOne.count_valid("passphrase_inputs.txt") == 337
  end

end
