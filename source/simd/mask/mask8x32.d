module simd.mask.mask8x32;

import simd;

align (64) public struct mask8x32
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = int;

    byte32 data;
    byte32 mask;
}