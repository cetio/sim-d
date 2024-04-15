module simd.vector.short8;

import simd;

align (16) public struct short8
{
    short[8] data;
    alias data this;

public:
final:
@nogc:
    enum length = 8;
}