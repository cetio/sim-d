module simd.mask.mask16x16;

import simd;

align (64) public struct mask16x16
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = short;

    short16 data;
    short16 mask;
}