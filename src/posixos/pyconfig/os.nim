
import ./util
import ./have_x_runtime
import pkg/pyosstat/private/pyconfig/os_consts as lib
export lib
const
  HAVE_OPENAT* = true
  HAVE_FTRUNCATE* = true

AC_CHECK_FUNCS(
  uname,
  unlinkat,
  fdopendir,
  getpwnam_r,
  # get{pw{nam,uid},gr{nam,gid}}_r share the same Feature Test Macro Requirements
)

check_func_runtime unlinkat, 10.10, 8.0
check_func_runtime fdopendir, 10.10, 8.0

when HAVE_UNLINKAT_RUNTIME and not declared(unlinkat):
  proc unlinkat*(dir_fd: cint, path: cstring, flag: cint): cint{.importc,
    header: "<unistd.h>".}
  let AT_REMOVEDIR*{.importc, header: "<fcntl.h>".}: cint


