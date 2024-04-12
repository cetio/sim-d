module simd.vector.mask32x8;

import simd.features;
import simd.vector;

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