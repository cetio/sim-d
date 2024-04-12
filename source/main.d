module main;

import std.stdio;
import simd;
import simd.features;

void main()
{
    auto vec = long2(2, 1);
    writeln(vec[0..1][]);
    vec[1..2] = long2(3, 2);
    writeln(vec[]);
    writeln(mask64x2(2));
    /* size_t _;
    foreach (i; 0..500000000)
    {
        byte[16] bmask = [-1, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, -1, 0, 0, 0];
        //vec.blend8x16(vec, bmask);
        _ += vec[0];
    }
    writeln(_); */
}
