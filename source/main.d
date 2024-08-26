module main;

import std.stdio;
import std.datetime;
import simd;

void main()
{
    long2 vec = [1, 2];
    writeln(vec[1..2] ^ vec);
    writeln(vec + [1, 2]);
    writeln(long2(2));
}
