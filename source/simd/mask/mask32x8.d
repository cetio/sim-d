module simd.mask.mask32x8;

import simd;

align (64) public struct mask32x8
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = ubyte;

    int8 data;
    int8 mask;
}