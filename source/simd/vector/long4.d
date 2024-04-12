module simd.vector.long4;

import simd.features;
import simd.vector;

align (32) public struct long4
{
    long2[2] data;
    alias data this;

public:
final:
@nogc:
    enum length = 4;
}