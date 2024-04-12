module simd.vector.byte16;

import simd.features;
import simd.vector;

align (16) public struct byte16
{
    byte[16] data;
    alias data this;

public:
final:
@nogc:
    enum length = 16;
}