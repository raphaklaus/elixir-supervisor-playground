defmodule SupervisorPlaygroundTest do
  use ExUnit.Case
  doctest SupervisorPlayground

  test "greets the world" do
    assert SupervisorPlayground.hello() == :world
  end
end
