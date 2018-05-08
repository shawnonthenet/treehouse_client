defmodule TreehouseClientTest do
  use ExUnit.Case
  doctest TreehouseClient

  test "greets the world" do
    assert TreehouseClient.hello() == :world
  end
end
