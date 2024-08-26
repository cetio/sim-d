module simd.mask.mask16x8;

import simd;

align (32) public struct mask16x8
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = ubyte;

    short8 data;
    short8 mask;
}