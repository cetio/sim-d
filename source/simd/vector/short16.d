module simd.vector.short16;

import simd;

align (32) public struct short16
{
    short8[2] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 16;
}