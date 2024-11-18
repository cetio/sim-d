module main;

//import std.stdio;
//import std.datetime;
import simd;
import core.stdc.stdio;
import std.conv;

extern (C) void main()
{
    long2 vec = [1, 2];
    foreach (u; vec[0..2])
        printf("%zu, ", u);

    /* int4 ctrl = int4(3, 2, 1, 0);
    writeln(long2(1, 2).shuffle32x4(ctrl));
    writeln(cast(int4)long2(1, 2).shuffle32x4(ctrl)); */
    
    //writeln(mask64x2(vec, 2).state);
}