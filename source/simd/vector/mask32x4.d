module simd.vector.mask32x4;

import simd.features;
import simd.vector;

public alias mask32x4 = _mask32x4!false;
public alias zmask32x4 = _mask32x4!true;

align (32) private struct _mask32x4(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = ubyte;

    int4 data;
    int4 mask;
}