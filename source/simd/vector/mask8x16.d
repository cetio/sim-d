module simd.vector.mask8x16;

import simd.features;
import simd.vector;

public alias mask8x16 = _mask8x16!false;
public alias zmask8x16 = _mask8x16!true;

align (32) private struct _mask8x16(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = short;

    byte16 data;
    byte16 mask;
}