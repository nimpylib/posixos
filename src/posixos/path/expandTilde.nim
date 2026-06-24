from std/os import getEnv
import std/strutils


when defined(posix):
  import pkg/grp_pwd

proc getHomeDir*(username: string): string =
  ## Returns the home directory for `username`.
  ##
  ## Raises `KeyError` when the user is not present in the passwd database.
  when defined(posix):
    result = getpwnam(username).pw_dir
  else:
    raise newException(KeyError, "getHomeDir(): username not found: " & username)

proc expandTilde*(path: string): string =
  ## Expands a leading ``~`` or ``~user`` in `path`.
  ##
  ## If the home directory cannot be resolved, `path` is returned unchanged.
  if path.len == 0 or path[0] != '~':
    return path

  let L = path.len
  var sepIdx = L
  for i in 1 ..< L:
    if path[i] in {'/', '\\'}:
      sepIdx = i
      break

  template rstripEnd(s): untyped =
    s.strip(leading = false, trailing = true, chars = {'/', '\\'})
  let tail = path[sepIdx .. ^1]
  if sepIdx == 1:
    when defined(windows):
      var home = getEnv("USERPROFILE")
      if home.len == 0:
        let drive = getEnv("HOMEDRIVE")
        let homePath = getEnv("HOMEPATH")
        if drive.len == 0 or homePath.len == 0:
          return path
        home = drive & homePath
    else:
      let home = getEnv("HOME")

    if home.len == 0:
      return path
    return home.rstripEnd & tail

  when defined(posix):
    try:
      let home = getHomeDir(path[1 ..< sepIdx])
      if home.len == 0:
        return path
      return home.rstripEnd & tail
    except KeyError:
      return path
  else:
    return path


