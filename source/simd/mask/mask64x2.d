module simd.mask.mask64x2;

import simd;

public alias mask64x2 = _mask64x2!false;
public alias zmask64x2 = _mask64x2!true;

align (32) private struct _mask64x2(bool ZEROED)
{
public:
final:
@nogc:
pragma(inline, true):
    alias pack = ubyte;

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

    this(ubyte mask) pure
    {
        // TODO: AVX512 checks should be based on feature
        static if (AVX512DQ && AVX512VL)
        {
            auto ret = __asm!(__vector(long[2]))("
                vpmovm2q $1, $0
            ", "=v,k", mask);
            this.mask = *cast(long2*)&ret;
        }
        else
        { 
            static foreach_reverse (i; 0..2)
            {
                this.mask[i] = (mask & 2) == 0 ? 0 : -1;
                mask <<= 1;
            }
        }
    }

    this(long[2] val, ubyte mask) pure
    {
        data = val;
        this(mask);
    }

    long2 state() const pure
    {
        return data & mask;
    }
    alias state this;

    typeof(this) opAssign(const scope long[2] val)
    {
        data = (data & mask) | (long2(val) & ~mask);
        return this;
    }

    ubyte movmsk() const
    {
        static if (SSE2)
            return cast(ubyte)__builtin_ia32_movmskpd(cast(__vector(double[2]))mask);
        else
            return ((mask[0] == -1) << 0) | ((mask[1] == -1) << 1);
    }
}