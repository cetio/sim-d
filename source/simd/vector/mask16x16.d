module simd.vector.mask16x16;

import simd.features;
import simd.vector;

public alias mask16x16 = _mask16x16!false;
public alias zmask16x16 = _mask16x16!true;

align (64) private struct _mask16x16(bool ZEROED)
{
public:
final:
@nogc:
    alias pack = short;

    short16 data;
    short16 mask;
}