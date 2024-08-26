module simd.mask.mask32x4;

import simd;

align (32) public struct mask32x4
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = ubyte;

    int4 data;
    int4 mask;
}