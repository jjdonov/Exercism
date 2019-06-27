defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn _, acc -> 1 + acc end)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], fn next, acc -> [next | acc] end)

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    reduce_right(l, [], fn next, acc -> [f.(next) | acc] end)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reduce_right(l, [], fn next, acc -> 
      if f.(next) do
        [next | acc]
      else 
        acc
      end
    end)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([l | ls], acc, f) do
    acc = f.(l, acc)
    reduce(ls, acc, f)
  end

  def reduce([], acc, _), do: acc

  def reduce_right(l, acc, f), do: reverse(l) |> reduce(acc, f)

  @spec append(list, list) :: list
  def append(ls, ks) do
    reduce_right(ls, ks, fn next, acc -> [next | acc ] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(lists) do
    reduce_right(lists, [], &append/2)
  end
end
