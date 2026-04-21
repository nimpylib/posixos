
import ./private/defined_macros
import pkg/auditfunc as sys
export InJs
import pkg/pyerrors/[oserr, simperr, rterr]
when defined(js):
  import pkg/jscompat/utils/oserr as jsoserr
  export jsoserr

  import pkg/jscompat/utils/denoAttrs
  export denoAttrs
import pkg/pyio_abc as io_abc
import pkg/collections_abc/private/noneType
import pkg/pystrbytes_decl
export sys
export io_abc, oserr, simperr, rterr, pystrbytes_decl
export noneType

