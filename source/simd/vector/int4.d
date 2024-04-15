module simd.vector.int4;

import simd;

align (16) public struct int4
{
    int[4] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 4;
}