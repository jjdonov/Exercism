defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([_ | ls]), do: 1 + count(ls)
  def count([]), do: 0

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l)

  defp do_reverse(l, acc \\ [])
  defp do_reverse([l | ls], acc), do: do_reverse(ls, [l | acc])
  defp do_reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for element <- l do
      f.(element)
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    for element <- l, f.(element) do
      element
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([l | ls], acc, f) do
    acc = f.(l, acc)
    reduce(ls, acc, f)
  end

  def reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append([l | ls], b), do: [l | append(ls, b)]
  def append([], b), do: b

  @spec concat([[any]]) :: [any]
  def concat([l | ls]), do: append(l, concat(ls))
  def concat([]), do: []
end
