Code.load_file("day_01_inverse_captcha.exs", __DIR__)

ExUnit.start

defmodule InverseCaptchaTest do
  use ExUnit.Case

  test "part one adds the next integer if it matches" do
    assert InverseCaptchaOne.calculate("1122") == 3
    assert InverseCaptchaOne.calculate("1111") == 4
    assert InverseCaptchaOne.calculate("1234") == 0
    assert InverseCaptchaOne.calculate("91212129") == 9
  end

  test "part two adds the halway around integer if it matches" do
    assert InverseCaptchaTwo.calculate("1212") == 6
    assert InverseCaptchaTwo.calculate("1221") == 0
    assert InverseCaptchaTwo.calculate("123425") == 4
    assert InverseCaptchaTwo.calculate("123123") == 12
    assert InverseCaptchaTwo.calculate("12131415") == 4
  end

end
