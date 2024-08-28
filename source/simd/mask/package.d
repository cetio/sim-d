module simd.mask;

import simd;

public import simd.mask.mask64x2;
public import simd.mask.mask64x4;

public import simd.mask.mask32x4;
public import simd.mask.mask32x8;

public import simd.mask.mask16x8;
public import simd.mask.mask16x16;

public import simd.mask.mask8x16;
public import simd.mask.mask8x32;

/// Boilerplate mixin for all mask types.
public template mboilerplate(string M)
{
    enum mboilerplate = q{
    import tern.traits : isVector;

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

    T opBinary(string op)(const scope U val) const pure
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

    T opBinary(string op)(const scope M val) const pure
    {
        return opBinary!(op, M)(val);
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