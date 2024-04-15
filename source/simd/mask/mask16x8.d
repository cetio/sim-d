module simd.mask.mask16x8;

import simd;

public alias mask16x8 = _mask16x8!false;
public alias zmask16x8 = _mask16x8!true;

align (32) private struct _mask16x8(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = ubyte;

    short8 data;
    short8 mask;
}