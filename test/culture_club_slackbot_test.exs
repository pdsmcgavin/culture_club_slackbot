defmodule CultureClubSlackbotTest do
  use ExUnit.Case
  doctest CultureClubSlackbot

  test "greets the world" do
    assert CultureClubSlackbot.hello() == :world
  end
end
