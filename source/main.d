module main;

import std.stdio;
import std.datetime;
import simd;

void main()
{
    long2 vec = [1, 2];
    writeln(vec[1..2] ^ vec);
    writeln(vec + [1, 2]);

    /* int4 ctrl = int4(3, 2, 1, 0);
    writeln(long2(1, 2).shuffle32x4(ctrl));
    writeln(cast(int4)long2(1, 2).shuffle32x4(ctrl)); */
    writeln(mask64x2(0, 0).movmsk);
    writeln(mask64x2(-1, 0).movmsk);
    writeln(mask64x2(0, -1).movmsk);
    writeln(mask64x2(-1, -1).movmsk);
}