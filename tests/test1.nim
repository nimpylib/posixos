## main test is in pylib/Lib/test/test_os
import std/unittest

import posixos as os
from std/os as std_os import parentDir

suite "os":
  test "listdir":
    let d = currentSourcePath().parentDir()
    let ls = os.listdir(d)
    check "test1.nim" in ls

  test "open":
    expect FileExistsError:
      let _ = os.open(currentSourcePath(), os.O_EXCL or os.O_CREAT)

