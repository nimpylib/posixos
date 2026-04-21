
import pkg/handy_sugars/trans_imp
import std/algorithm
impExpCwd posixos, [
  consts, posix_like, subp, utils, path, walkImpl, listdirx, randoms, waits,
  have_functions, cpus,
]

when not defined(js):
  import ./posixos/[
    term, inheritable]
  export term, set_inheritable, get_inheritable

when defined(posix):
  import ./posixos/only_posix
  export only_posix

genUname string
gen_walk seq, add, newSeq
gen_listdir seq, add
import ./posixos/posix_like/sched
when HAVE_SCHED_SETAFFINITY:
  proc sched_setaffinity*(pid: int, mask: openArray[int]) =
    sched_setaffinityImpl(pid, mask)
  proc sched_getaffinity*(pid: int): seq[int] =
    sched_getaffinityImpl(pid) do (x: cint):
      result.add int x

