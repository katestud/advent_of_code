Code.load_file("memory_allocator.exs", __DIR__)

ExUnit.start

defmodule MemoryAllocatorTest do
  use ExUnit.Case

  test "part one finds count of iterations before duplicated state" do
    initial = {0, 2, 7, 0}
    assert MemoryAllocator.redistribute(initial) == 5

    input = {10, 3, 15, 10, 5, 15, 5, 15, 9, 2, 5, 8, 5, 2, 3, 6}
    assert MemoryAllocator.redistribute(input) == 14029
  end

end
