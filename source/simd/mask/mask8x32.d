module simd.mask.mask8x32;

import simd;

public alias mask8x32 = _mask8x32!false;
public alias zmask8x32 = _mask8x32!true;

align (64) private struct _mask8x32(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = int;

    byte32 data;
    byte32 mask;
}