
import pkg/errno
import pkg/pysignal/c_api
from pkg/errno/errnoUtils import getErrno
from ../common import raiseErrno

template initVal_with_handle_signal*[R](res: var R; resExpr){.dirty.} =
  bind isErr, EINTR, PyErr_CheckSignals, raiseErrno, getErrno
  var async_err: int

  while true:
    res = resExpr
    if res >= 0 or not isErr(EINTR):
      break
    async_err = PyErr_CheckSignals()
    if async_err == 0:
      break
  if res < 0:
    raiseErrno getErrno()
