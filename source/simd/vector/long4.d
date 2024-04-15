module simd.vector.long4;

import simd;

align (32) public struct long4
{
    long2[2] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 4;
}