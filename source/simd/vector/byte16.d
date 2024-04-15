module simd.vector.byte16;

import simd;

align (16) public struct byte16
{
    byte[16] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 16;
}