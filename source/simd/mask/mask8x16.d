module simd.mask.mask8x16;

import simd;

align (32) public struct mask8x16
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = short;

    byte16 data;
    byte16 mask;
}