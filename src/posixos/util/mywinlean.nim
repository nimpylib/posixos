

import pkg/pystat/private/mywinlean as pystat_mywinlean
export pystat_mywinlean

proc Py_get_osfhandle_noraise*(fd: int): HANDLE =
  cast[HANDLE](Py_get_osfhandle_noraise(cint fd))
