module simd.vector.int4;

import simd.features;
import simd.vector;

align (16) public struct int4
{
    int[4] data;
    alias data this;

public:
final:
@nogc:
    enum length = 4;
}