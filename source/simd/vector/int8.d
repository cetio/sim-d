module simd.vector.int8;

import simd;

align (32) public struct int8
{
    int4[2] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 8;
}