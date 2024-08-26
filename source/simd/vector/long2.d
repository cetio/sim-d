module simd.vector.long2;

import simd;

align (16) public struct long2
{
    long[2] data;
    alias data this;

public:
final:
@nogc:
pragma(inline, true):
    enum length = 2;

    mixin(vboilerplate!"mask64x2");

    long2 opBinary(string op, T)(scope T val) const pure
        if (isM128!T)
    {
        static if (op == "+" && AVX512F && AVX512VL)
        {
            auto ret = __asm!(__vector(long[2]))("
                vpaddq $1, $2, $1 {%k1} "~(isZ128!T ? "{z}" : "")
            , "=v,v,v,{k1}", data, val.data, val.movmsk);
            return *cast(long2*)&ret;
        }
        else static if (op == "-" && AVX512F && AVX512VL2)
        {
            auto ret = __asm!(__vector(long[2]))("
                vpsubq $1, $2, $1 {%k1} "~(isZ128!T ? "{z}" : "")
            , "=v,v,v,{k1}", data, val.data, val.movmsk);
            return *cast(long2*)&ret;
        }
        else static if (op == "^" && AVX512F && AVX512VL)
        {
            auto ret = __asm!(__vector(long[2]))("
                vpxorq $1, $2, $1 {%k1} "~(isZ128!T ? "{z}" : "")
            , "=v,v,v,{k1}", cast(__vector(long[2]))data, val.data, val.movmsk);
            return *cast(long2*)&ret;
        }
        else static if (op == "|" && AVX512F && AVX512VL)
        {
            auto ret = __asm!(__vector(long[2]))("
                vporq $1, $2, $1 {%k1} "~(isZ128!T ? "{z}" : "")
            , "=v,v,v,{k1}", data, val.data, val.movmsk);
            return *cast(long2*)&ret;
        }
        else static if (op == "&" && AVX512F && AVX512VL)
        {
            auto ret = __asm!(__vector(long[2]))("
                vpandq $1, $2, $1 {%k1} "~(isZ128!T ? "{z}" : "")
            , "=v,v,v,{k1}", data, val.data, val.movmsk);
            return *cast(long2*)&ret;
        }
        else
        {
            long2 ret = this;
            ret = mixin("val "~op~" ret");
            return ret;
        }
    }

    pragma(inline, true):
    auto shuffle64x2(const scope long[2] ctrl) const pure
    {
        long[2] ret = void;
        ret[0] = data[ctrl[0]];
        ret[1] = data[ctrl[1]];
        return cast(long[2])ret;
    }

    pragma(inline, true):
    auto shuffle32x4(const scope int[4] ctrl) const pure @trusted
    {
        static if (AVX2)
        {
            // Defering initialization here has no impact on generation,
            // but it looks better and ensures consistency across versions.
            align (32) const int[8] nctrl = void;
            align (32) const long[2] data = this.data;
            // Output with this is identical to if we did what we're doing with data.
            *cast(int[4]*)&nctrl = ctrl;

            auto ret = __builtin_ia32_permvarsi256(*cast(__vector(int[8])*)&data, cast(__vector(int[8]))nctrl);
            return *cast(long2*)&ret;
        }
        else
        {
            int[4] ret = void;
            const int[4] data = cast(int[4])this.data;
            ret[0] = data[ctrl[0]];
            ret[1] = data[ctrl[1]];
            ret[2] = data[ctrl[2]];
            ret[3] = data[ctrl[3]];
            return cast(long2)ret;
        }
    }

    pragma(inline, true):
    auto shuffle16x8(const scope short[8] ctrl) const pure
    {
        static if (AVX512VL && AVX512BW)
        {
            auto ret = __builtin_ia32_vpermi2varhi128(cast(__vector(short[8]))cast(short[8])data, cast(__vector(short[8]))ctrl, cast(__vector(short[8]))cast(short[8])data);
            return *cast(long2*)&ret;
        }
        else
        {
            short[8] ret = void;
            const short[8] data = cast(short[8])this.data;
            ret[0] = data[ctrl[0]];
            ret[1] = data[ctrl[1]];
            ret[2] = data[ctrl[2]];
            ret[3] = data[ctrl[3]];
            ret[4] = data[ctrl[4]];
            ret[5] = data[ctrl[5]];
            ret[6] = data[ctrl[6]];
            ret[7] = data[ctrl[7]];
            return cast(long2)ret;
        }
    }

    pragma(inline, true):
    auto shuffle8x16(const scope byte[16] ctrl) const pure @trusted
    {
        static if (SSSE3)
        {
            auto ret = __builtin_ia32_pshufb128(cast(__vector(byte[16]))data, cast(__vector(byte[16]))ctrl);
            return *cast(long2*)&ret;
        }
        else
        {
            byte[16] ret = void;
            const byte[16] data = cast(byte[16])data;
            static foreach (i; 0..16)
                ret[i] = data[ctrl[i]];
            return cast(long2)ret;
        }
    }
}
/+ {
    long[2] data;
    alias data this;

public:
final:
@nogc:
    enum length = 2;

    this(long a, long b) pure
    {
        data[0] = a;
        data[1] = b;
    }

    this(long[2] arr) pure
    {
        data = arr;
    }

    /* auto opAssign(T)(T value)
        if (isMask!T)
    {
        
        return this;
    } */

    pragma(inline, true):
    auto opBinary(string op)(const scope long[2] val) const pure
    {
        long2 ret = this;
        mixin("ret[] "~op~"= val[];");
        return ret;
    }

    pragma(inline, true):
    auto shuffle64x2(const scope long[2] ctrl) const pure
    {
        long[2] ret = void;
        ret[0] = data[ctrl[0]];
        ret[1] = data[ctrl[1]];
        return cast(long[2])ret;
    }

    pragma(inline, true):
    auto shuffle32x4(const scope int[4] ctrl) const pure @trusted
    {
        static if (AVX2)
        {
            // Defering initialization here has no impact on generation,
            // but it looks better and ensures consistency across versions.
            align (32) const int[8] nctrl = void;
            align (32) const long[2] data = this.data;
            // Output with this is identical to if we did what we're doing with data.
            *cast(int[4]*)&nctrl = ctrl;

            auto ret = __builtin_ia32_permvarsi256(*cast(__vector(int[8])*)&data, cast(__vector(int[8]))nctrl);
            return *cast(long2*)&ret;
        }
        else
        {
            int[4] ret = void;
            const int[4] data = cast(int[4])this.data;
            ret[0] = data[ctrl[0]];
            ret[1] = data[ctrl[1]];
            ret[2] = data[ctrl[2]];
            ret[3] = data[ctrl[3]];
            return cast(long2)ret;
        }
    }

    pragma(inline, true):
    auto shuffle16x8(const scope short[8] ctrl) const pure
    {
        // Not supported yet on LDC stable
        /* auto ret = inlineIR!(q{
            %tmp = call <8 x i16> @llvm.x86.avx512.vpermi2var.hi.128(<8 x i16> %0, <8 x i16> %1, <8 x i16> %2)
            ret <8 x i16> %tmp
        }, __vector(short[8]), __vector(short[8]), __vector(short[8]), __vector(short[8]))(cast(__vector(short[8]))data, cast(__vector(short[8]))ctrl, cast(__vector(short[8]))data);
        return *cast(long2*)&ret; */
        short[8] ret = void;
        const short[8] data = cast(short[8])this.data;
        ret[0] = data[ctrl[0]];
        ret[1] = data[ctrl[1]];
        ret[2] = data[ctrl[2]];
        ret[3] = data[ctrl[3]];
        ret[4] = data[ctrl[4]];
        ret[5] = data[ctrl[5]];
        ret[6] = data[ctrl[6]];
        ret[7] = data[ctrl[7]];
        return cast(long2)ret;
    }

    pragma(inline, true):
    auto shuffle8x16(const scope byte[16] ctrl) const pure @trusted
    {
        static if (SSSE3)
        {
            auto ret = __builtin_ia32_pshufb128(cast(__vector(byte[16]))data, cast(__vector(byte[16]))ctrl);
            return *cast(long2*)&ret;
        }
        else
        {
            byte[16] ret = void;
            const byte[16] data = cast(byte[16])data;
            static foreach (i; 0..16)
                ret[i] = data[ctrl[i]];
            return cast(long2)ret;
        }
    }

    pragma(inline, true):
    auto opOpAssign(string op)(const scope long[2] val)
    {
        return mixin("data[] "~op~"= val[]");
    }

    pragma(inline, true):
    auto opUnary(string op)() const pure
    {
        long2 ret = void;
        ret = mixin(op~"data[]");
        return ret;
    }

    auto blend8x16(const scope long[2] val, byte[16] ctrl)
    {
        static if (SSE41)
        {
            auto ret = __builtin_ia32_pblendvb128(cast(__vector(byte[16]))data, cast(__vector(byte[16]))val, cast(__vector(byte[16]))ctrl);
            return *cast(long2*)&ret;
        }
        else
        {
            long2 ret = void;
            const byte[16] data1 = cast(byte[16])this.data;
            const byte[16] data2 = cast(byte[16])val;
            static foreach (i; 0..16)
                ret[i] = ctrl == 0 ? data2[i] : data1[i];
            return ret;
        }
    }

    /*
        blend64x2(long[2], long[2])
        blend32x4(long[2], int[4])
        blend16x8(long[2], short[8])

        opAssign -> broadcast
        opAssign -> mask

        mask(long[2])
        mask(int[4])
        mask(short[8])
        mask(byte[16])

        shl128x1(int)
        shl64x2(int)
        shl32x4(int)
        shl16x8(int)
        shl8x16(int)

        shr128x1(int)
        shr64x2(int)
        shr32x4(int)
        shr16x8(int)
        shr8x16(int)

        bshl128x1(int)
        bshl64x2(int)
        bshl32x4(int)
        bshl16x8(int)
        bshl8x16(int)

        bshr128x1(int)
        bshr64x2(int)
        bshr32x4(int)
        bshr16x8(int)
        bshr8x16(int)

        shl64x2(long[2])
        shl32x4(int[4])
        shl16x8(short[8])
        shl8x16(byte[16])

        shr64x2(long[2])
        shr32x4(int[4])
        shr16x8(short[8])
        shr8x16(byte[16])

        bshl64x2(long[2])
        bshl32x4(int[4])
        bshl16x8(short[8])
        bshl8x16(byte[16])

        bshr64x2(long[2])
        bshr32x4(int[4])
        bshr16x8(short[8])
        bshr8x16(byte[16])

        toString()
    */
} +/