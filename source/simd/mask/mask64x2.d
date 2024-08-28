module simd.mask.mask64x2;

import simd;

// TODO: Mask boilerplate and make it work like vectors normally.
align (32) public struct mask64x2
{
public:
final:
@nogc:
pragma(inline, true):
    alias K = ubyte;
    enum length = 2;

    long2 data;
    long2 mask;

    this(long[2] arr) pure
    {
        mask = arr;
    }

    this(long hi, long lo) pure
    {
        mask = long2(hi, lo);
    }

    this(long[2] val, long[2] mask) pure
    {
        data = val;
        this.mask = mask;
    }

    this(K mask) pure
    {
        static if (AVX512DQ && AVX512VL)
        {
            auto ret = __asm!(__vector(long[2]))("
                vpmovm2q $1, $0
            ", "=v,k", mask);
            this.mask = *cast(long2*)&ret;
        }
        else
        { 
            static foreach_reverse (i; 0..length)
                this.mask[i] = mask & (cast(K)1 << i);
        }
    }

    this(long[2] val, K mask) pure
    {
        data = val;
        this(mask);
    }

    long2 state()
    {
        return data & mask;
    }
    alias state this;

    typeof(this) opAssign(const scope long[2] val)
    {
        data = (data & mask) | (long2(val) & ~mask);
        return this;
    }

    K movmsk() const pure
    {
        static if (SSE2)
            return cast(ubyte)__builtin_ia32_movmskpd(cast(__vector(double[2]))mask);
        else
        {
            K ret;
            static foreach(i; 0..length)
                ret |= mask[i] & (cast(K)1 << i);
            return ret;
        }    
    }
}