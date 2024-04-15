module simd.mask.mask8x16;

import simd;

public alias mask8x16 = _mask8x16!false;
public alias zmask8x16 = _mask8x16!true;

align (32) private struct _mask8x16(bool ZEROED)
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = short;

    byte16 data;
    byte16 mask;
}