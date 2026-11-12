
import pkg/pyosstat/private/defined_macros as lib
export lib
when not defined(js):
  const ms_windows* = MS_WINDOWS
else:
  import ./genplatform
  let ms_windows* = getPlatform() == "win32"
