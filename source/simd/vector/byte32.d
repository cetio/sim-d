module simd.vector.byte32;

import simd;

align (32) public struct byte32
{
    byte16[2] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 32;
}