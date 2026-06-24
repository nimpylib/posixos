
import ../common
import ./expandTilde as lib

proc expanduser*[T](path: PathLike[T]): T =
  path.mapPathLike(expandTilde)

