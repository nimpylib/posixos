
const MS_WINDOWS* = defined(windows)
when not defined(js):
  const ms_windows* = MS_WINDOWS
else:
  import ./genplatform
  let ms_windows* = getPlatform() == "win32"
const InJs* = defined(js)
