module simd.mask.mask64x4;

import simd;

align (64) public struct mask64x4
{
public:
final:
@nogc:
pragma(inline, true):
    alias K = ubyte;
    enum length = 4;

    long4 data;
    long4 mask;
}