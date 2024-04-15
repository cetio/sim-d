module simd.mask.mask16x16;

import simd;

public alias mask16x16 = _mask16x16!false;
public alias zmask16x16 = _mask16x16!true;

align (64) private struct _mask16x16(bool ZEROED)
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = short;

    short16 data;
    short16 mask;
}