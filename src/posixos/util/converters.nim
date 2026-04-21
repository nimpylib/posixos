
import std/posix

proc Py_Uid_Converter*(
    obj: auto,
    res: var Uid
): bool =
  let index = when compiles(index(obj)):
    index(obj)
  else:
    int(obj)
  when index is_not int:
    {.error: "TypeError: uid should be integer, not " & $typeof(index).}
  #[ Handling uid_t is complicated for two reasons:
   * Although uid_t is (always?) unsigned, it still
     accepts -1.
   * We don't know its size in advance--it may be
     bigger than an int, or it may be smaller than
     a long.

  So a bit of defensive programming is in order.
  Start with interpreting the value passed
  in as a signed long and see if it works.]#
  template underflow =
    raise newException(OverflowError, "uid is less than minimum")
  template overflow =
    raise newException(OverflowError, "uid is greater than maximum")
  template success =
    res = uid
    result = true
    return
  if index == -1:
    success
  # Any other negative number is disallowed.
  if index < 0:
    underflow
  # Ensure the value wasn't truncated.
  elif index > high(Uid):
    overflow
  success
  res = Uid(index)
  result = true
