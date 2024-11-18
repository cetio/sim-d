module simd.vector;

public import simd.vector.long2;
public import simd.vector.long4;

public import simd.vector.int4;
public import simd.vector.int8;

public import simd.vector.short8;
public import simd.vector.short16;

public import simd.vector.byte16;
public import simd.vector.byte32;

import std.traits;

template ElementType(T) 
{
    static if (is(T == U[], U) || is(T == U*, U) || is(T U == U[L], size_t L))
        alias ElementType = U;
    else static if (isIndexable!T)
    {
        T _;
        alias ElementType = typeof(_[0]);
    }
    else
        alias ElementType = OriginalType!T;
}

enum isIndexable(T) = isDynamicArray!T || isStaticArray!T || 
    __traits(compiles, { template t(T) { T v; auto t() => v[0]; } auto x = t!T; });
enum isVector(T) = !isDynamicArray!T && isIndexable!T && isNumeric!(ElementType!T);

/// Boilerplate mixin for all vector types.
public template vboilerplate(string M)
{
    enum vboilerplate = q{
    alias T = typeof(this);
    alias U = typeof(data);
    alias E = typeof(data[0]);
    alias M = }~M~q{;

    this(E hi, E lo) pure
    {
        data[0] = hi;
        data[1] = lo;
    }

    this(U arr) pure
    {
        data = arr;
    }

    /// Broadcasts `val` to all elements. Not to be confused with `this(E hi, E lo)`.
    this(E val) pure
    {
        data[] = val;
    }

    this(const scope M val) pure
    {
        this = val;
    }

    /// Casting returns by-ref to make working with vectors easier, but this is a double-edged blade.
    ref T opCast(T)() const pure
    {
        static assert(isVector!T, "May only cast SIM-D vectors to a vector type, not '"~fullIdentifier!T~"!'");
        return *cast(T*)&this;
    }

    ref T opAssign(U arr) pure
    {
        data = arr;
        return this;
    }

    ref T opAssign(T val) pure
    {
        data = val.data;
        return this;
    }

    ref T opAssign(const scope M val) pure
    {
        data = (this & val.mask) | (val.data & ~val.mask);
        return this;
    }

    // This weird generics shenanigans is intentional, meant to set the priority of this function as low as possible.
    T opBinary(string op, D)(const scope D val) const pure
        if (is(D == U))
    {
        T ret = this;
        static foreach (i; 0..U.length)
            mixin("ret[i] "~op~"= val[i];");
        return ret;
    }

    T opBinary(string op)(const scope E val) const pure
    {
        T ret = this;
        static foreach (i; 0..U.length)
            mixin("ret[i] "~op~"= val;");
        return ret;
    }

    ref T opOpAssign(string op)(const scope U val)
    {
        static foreach (i; 0..U.length)
            mixin("data[i] "~op~"= val[i];");
        return this;
    }

    ref T opOpAssign(string op)(const scope E val)
    {
        static foreach (i; 0..U.length)
            mixin("data[i] "~op~"= val;");
        return this;
    }

    ref T opOpAssign(string op)(const scope M val)
    {
        data = mixin("this "~op~" val");
        return this;
    }

    T opUnary(string op)() const pure
    {
        T ret = this;
        static foreach (i; 0..U.length)
            mixin("ret[i] = "~op~"ret[i];");
        return ret;
    }

    ref U opSlice() const pure
    {
        return this;
    }

    M opSlice(size_t start, size_t end) const pure
    {
        ubyte mask = (ubyte.max << start) & (ubyte.max >> ((M.K.sizeof * 8) - end));
        return M(this, mask);
    }

    M opSliceAssign(const scope U val, size_t start, size_t end) 
    {
        ubyte mask = (ubyte.max << start) & (ubyte.max >> ((M.K.sizeof * 8) - end));
        M ret = M(this, mask);
        data = ret;
        return ret;
    }

    M opSliceOpAssign(string op)(const scope U val, size_t start, size_t end)
    {
        ubyte mask = (ubyte.max << start) & (ubyte.max >> ((M.K.sizeof * 8) - end));
        M ret = M(this, mask);
        data = mixin("this "~op~" ret");
        return ret;
    }
    };
}