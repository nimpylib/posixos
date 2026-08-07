
import ./common
when not defined(js) and not defined(wasm):
  proc c_system(cmd: cstring): cint{.importc: "system", header: "<stdlib.h>".}

proc system*(command: string): int{.discardable.} =
  ## os.system
  runnableExamples:
    const
      # can use `os.devnull`
      mydevnull = when defined(windows): "nul" else: "/dev/null"
      e2null = "echo 1 >" & mydevnull
    assert system(e2null) == 0

  sys.audit("os.system", command)
  when defined(js):
    let jsStr = command.cstring
    var res: c_int
    asm """
    const {exec} = require('node:child_process');
    let childProcess = exec(`jsStr`);
    `res` = childProcess.exitCode;
    """
    result = res.int
  elif defined(wasm):
    # WASI has no libc system() or process-spawn API.
    result = -1
  else:
    c_system command.cstring
