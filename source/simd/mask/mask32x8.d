module simd.mask.mask32x8;

import simd;

public alias mask32x8 = _mask32x8!false;
public alias zmask32x8 = _mask32x8!true;

align (64) private struct _mask32x8(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = ubyte;

    int8 data;
    int8 mask;
}