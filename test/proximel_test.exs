defmodule ProximelTest do
  use ExUnit.Case

  test "expand/2" do
    assert ['apply/2', 'apply/3'] == Proximel.expand("apply")
  end
end
