
template importConfig*(name) =
  import ../pyconfig/name

import ../private/defined_macros
export defined_macros

import pkg/pyosstat/private/pyCfg
export useMS_WINDOWSproc

