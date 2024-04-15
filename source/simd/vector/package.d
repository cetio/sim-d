module simd.vector;

public import simd.vector.long2;
public import simd.vector.long4;

public import simd.vector.int4;
public import simd.vector.int8;

public import simd.vector.short8;
public import simd.vector.short16;

public import simd.vector.byte16;
public import simd.vector.byte32;

/// Boilerplate mixin for all vector types.
package template vboilerplate(string MASK_TITLE)
{
    enum vboilerplate = q{
    alias T = typeof(this);
    alias U = typeof(data);
    alias E = typeof(data[0]);
    alias M = }~MASK_TITLE~q{;
    alias Z = z}~MASK_TITLE~q{;

    this(E hi, E lo) pure
    {
        data[0] = hi;
        data[1] = lo;
    }

    this(U arr) pure
    {
        data = arr;
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

    ref T opAssign(const scope Z val) pure
    {
        this = val.state;
        return this;
    }

    T opBinary(string op)(const scope U val) const pure
    {
        T ret = this;
        mixin("ret[] "~op~"= val[];");
        return ret;
    }

    T opBinary(string op)(const scope E val) const pure
    {
        T ret = this;
        mixin("ret[] "~op~"= val;");
        return ret;
    }

    T opBinary(string op)(const scope M val) const pure
    {
        return opBinary!(op, M)(val);
    }

    T opBinary(string op)(const scope Z val) const pure
    {
        return opBinary!(op, Z)(val);
    }

    T opOpAssign(string op)(const scope U val)
    {
        mixin("data[] "~op~"= val[];");
        return this;
    }

    T opOpAssign(string op)(const scope E val)
    {
        mixin("data[] "~op~"= val;");
        return this;
    }

    T opUnary(string op)() const pure
    {
        T ret = this;
        ret = mixin(op~"ret[]");
        return ret;
    }

    // These next 3 operators only exist for parity
    ref U opSlice() const pure
    {
        return data;
    }

    ref auto opSliceOpAssign(string op)(const scope U val) 
    {
        mixin("data[] "~op~"= val[];");
        return data;
    }

    auto opSliceUnary(string op)() 
    {
        U ret = data;
        ret = mixin(op~"data[]");
        return ret;
    }

    pragma(inline, true):
    M opSlice(size_t start, size_t end) const pure
    {
        ubyte mask = (ubyte.max << start) & (ubyte.max >> ((M.pack.sizeof * 8) - end));
        return M(this, mask);
    }

    M opSliceAssign(const scope U val, size_t start = 0, size_t end = 2) 
    {
        ubyte mask = (ubyte.max << start) & (ubyte.max >> ((M.pack.sizeof * 8) - end));
        M ret = M(this, mask);
        data = ret;
        return ret;
    }
    };

    // TODO: opSliceOpAssign, opSliceUnary, etc.
}