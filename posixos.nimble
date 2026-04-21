# Package

version       = "0.1.0"
author        = "litlighilit"
description   = "posix-like API for os module, supporting JS backend"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim > 2.0.8"

var pylibPre = "https://github.com/nimpylib"
let envVal = getEnv("NIMPYLIB_PKGS_BARE_PREFIX")
if envVal != "": pylibPre = ""
#if pylibPre == Def: pylibPre = ""
elif pylibPre[^1] != '/':
  pylibPre.add '/'
template pylib(x, ver) =
  requires if pylibPre == "": x & ver
           else: pylibPre & x

pylib "handy_sugars", " ^= 0.1.0"
when defined(windows):
  pylib "py_private_utils", " ^= 0.1.0"

pylib "auditfunc", " ^= 0.1.0"
pylib "py_private_utils", " ^= 0.1.0"
pylib "pystrbytes_decl", " ^= 0.1.0"
pylib "pyerrors", " ^= 0.1.0"
pylib "pyio_abc", " ^= 0.1.0"
pylib "pyio_open", " ^= 0.1.0"
pylib "autoconf_sugars", " ^= 0.1.0"
pylib "pysignal", " ^= 0.1.0"
pylib "errno", " ^= 0.1.0"
pylib "pystat", " ^= 0.1.0"
pylib "pyresource", " ^= 0.1.0"
