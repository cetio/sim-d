module simd.vector.mask64x4;

import simd.features;
import simd.vector;

public alias mask64x4 = _mask64x4!false;
public alias zmask64x4 = _mask64x4!true;

align (64) private struct _mask64x4(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = ubyte;

    long4 data;
    long4 mask;
}