module simd.vector.byte32;

import simd.features;
import simd.vector;

align (32) public struct byte32
{
    byte16[2] data;
    alias data this;

public:
final:
@nogc:
    enum length = 32;
}