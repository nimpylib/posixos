
# reference source: Modules/posixmodule.c

import std/os

import ./common
import ./posix_like/mkrmdir

when InJs:
  import ./osJsPatch
  proc cwd(): cstring{.importDenoOrProcess(cwd).}
  proc getcwd*(): PyStr = str cwd()
  proc getcwdb*(): PyBytes = bytes cwd()
  proc chdir(d: cstring){.importDenoOrProcess(chdir).}
  proc chdirImpl(s: PathLike) = chdir cstring $s

else:
  proc getcwd*(): PyStr = str getCurrentDir()
  proc getcwdb*(): PyBytes = bytes getCurrentDir()
  proc chdirImpl(s: PathLike) = setCurrentDir $s

proc chdir*(path: PathLike) =
  sys.audit("os.chdir", path)
  chdirImpl(path)

proc makedirs*[T](name: PathLike[T], mode=0o777, exist_ok=false) =
  let dir = $name
  if dir == "":
    return
  var omitNext = isAbsolute(dir)
  for p in parentDirs(dir, fromRoot=true):
    if omitNext:
      omitNext = false
    else:
      p.tryOsOp not exist_ok or not dirExists(p):
        mkdir(p, mode)

proc removedirs*(name: PathLike) =
  let dir = $name
  if dir == "":
    return
  # raises OSError if the leaf directory could not be successfully removed.
  rmdir(name)  
  var omitNext = isAbsolute(dir)
  try:
    for p in parentDirs(dir, inclusive=false):
      rmdir(p)
  except OSError:
    discard
