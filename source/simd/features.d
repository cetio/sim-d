module simd.features;

//version (GNU) public import gcc.builtins;
version (LDC) public import ldc.simd;
version (LDC) public import ldc.intrinsics;
// https://github.com/etcimon/libwasm/blob/9513ad4ba0a9f7631c73650d4dd99bb4a21863bc/druntime/ldc/gccbuiltins_x86.di
version (LDC) public import ldc.gccbuiltins_x86;
version (LDC) public import ldc.llvmasm;

version (LDC)
{
    pragma(LDC_inline_ir)
    R inlineIR(string s, R, P...)(P) @nogc pure;

    public enum _3DNOW = __traits(targetHasFeature, "3dnow");
    public enum _3DNOWA = __traits(targetHasFeature, "3dnowa");
    public enum MMX = __traits(targetHasFeature, "mmx");

    public enum AES = __traits(targetHasFeature, "aes");
    public enum SHA = __traits(targetHasFeature, "sha");
    public enum SHA512 = __traits(targetHasFeature, "sha512");
    public enum KL = __traits(targetHasFeature, "kl");
    public enum WIDEKL = __traits(targetHasFeature, "widekl");

    public enum SSE = __traits(targetHasFeature, "sse");
    public enum SSE2 = __traits(targetHasFeature, "sse2");
    public enum SSE3 = __traits(targetHasFeature, "sse3");
    public enum SSSE3 = __traits(targetHasFeature, "ssse3");
    public enum SSE41 = __traits(targetHasFeature, "sse4.1");
    public enum SSE42 = __traits(targetHasFeature, "sse4.2");
    public enum SSE4A = __traits(targetHasFeature, "sse4a");

    public enum AVX = __traits(targetHasFeature, "avx");
    public enum AVX2 = __traits(targetHasFeature, "avx2");
    public enum AVXNECONVERT = __traits(targetHasFeature, "avxneconvert");
    public enum AVXVNNI = __traits(targetHasFeature, "avxvnni");
    public enum AVXIFMA = __traits(targetHasFeature, "avxifma");
    public enum AVXVNNIINT16 = __traits(targetHasFeature, "avxvnniint16");
    public enum AVXVNNIINT8 = __traits(targetHasFeature, "avxvnniint8");

    public enum AVX512F = __traits(targetHasFeature, "avx512f");
    public enum AVX512CD = __traits(targetHasFeature, "avx512cd");
    public enum AVX512ER = __traits(targetHasFeature, "avx512er");
    public enum AVX512PF = __traits(targetHasFeature, "avx512pf");
    public enum AVX512BW = __traits(targetHasFeature, "avx512bw");
    public enum AVX512DQ = __traits(targetHasFeature, "avx512dq");
    public enum AVX512VL = __traits(targetHasFeature, "avx512vl");
    public enum AVX512IFMA = __traits(targetHasFeature, "avx512ifma");
    public enum AVX512VBMI = __traits(targetHasFeature, "avx512vbmi");
    public enum AVX512VBMI2 = __traits(targetHasFeature, "avx512vbmi2");

    public enum AVX512FP16 = __traits(targetHasFeature, "avx512fp16");
    public enum AVX512BF16 = __traits(targetHasFeature, "avx512bf16");
    public enum AVX512VNNI = __traits(targetHasFeature, "avx512vnni");
    public enum AVX512BITALG = __traits(targetHasFeature, "avx512bitalg");

    public enum AVX512VP2INTERSECT = __traits(targetHasFeature, "avx512vp2intersect");
    public enum AVX512VPOPCNTDQ = __traits(targetHasFeature, "avx512vpopcntdq");

    public enum VAES = __traits(targetHasFeature, "vaes");
    public enum VPCLMULQDQ = __traits(targetHasFeature, "vpclmulqdq");
    public enum VZEROUPPER = __traits(targetHasFeature, "vzeroupper");
    public enum XOP = __traits(targetHasFeature, "xop");

    public enum AMX_BF16 = __traits(targetHasFeature, "amx-bf16");
    public enum AMX_COMPLEX = __traits(targetHasFeature, "amx-complex");
    public enum AMX_FP16 = __traits(targetHasFeature, "amx-fp16");
    public enum AMX_INT8 = __traits(targetHasFeature, "amx-int8");
    public enum AMX_TILE = __traits(targetHasFeature, "amx-tile");

    public enum F16C = __traits(targetHasFeature, "f16c");
    public enum FMA = __traits(targetHasFeature, "fma");
    public enum FMA4 = __traits(targetHasFeature, "fma4");

    public enum PREFETCHI = __traits(targetHasFeature, "prefetchi");
    public enum PREFETCHWT1 = __traits(targetHasFeature, "prefetchwt1");

    public enum ADX = __traits(targetHasFeature, "adx");
    public enum BMI = __traits(targetHasFeature, "bmi");
    public enum BMI2 = __traits(targetHasFeature, "bmi2");
    public enum CLDEMOTE = __traits(targetHasFeature, "cldemote");
    public enum CLFLUSHOPT = __traits(targetHasFeature, "clflushopt");
    public enum CLWB = __traits(targetHasFeature, "clwb");
    public enum CLZERO = __traits(targetHasFeature, "clzero");
    public enum CMPCCXADD = __traits(targetHasFeature, "cmpccxadd");
    public enum CRC32 = __traits(targetHasFeature, "crc32");
    public enum CX16 = __traits(targetHasFeature, "cx16");
    public enum ENQCMD = __traits(targetHasFeature, "enqcmd");
    public enum FSGSBASE = __traits(targetHasFeature, "fsgsbase");
    public enum FXSR = __traits(targetHasFeature, "fxsr");
    public enum GFNI = __traits(targetHasFeature, "gfni");
    public enum HRESET = __traits(targetHasFeature, "hreset");
    public enum INVPCID = __traits(targetHasFeature, "invpcid");
    public enum LWP = __traits(targetHasFeature, "lwp");
    public enum LZCNT = __traits(targetHasFeature, "lzcnt");
    public enum MOVBE = __traits(targetHasFeature, "movbe");
    public enum MOVDIR64B = __traits(targetHasFeature, "movdir64b");
    public enum MOVDIRI = __traits(targetHasFeature, "movdiri");
    public enum MWAITX = __traits(targetHasFeature, "mwaitx");
    public enum PCLMUL = __traits(targetHasFeature, "pclmul");
    public enum PCONFIG = __traits(targetHasFeature, "pconfig");
    public enum PKU = __traits(targetHasFeature, "pku");
    public enum POPCNT = __traits(targetHasFeature, "popcnt");
    public enum PRFCHW = __traits(targetHasFeature, "prfchw");
    public enum PTWRITE = __traits(targetHasFeature, "ptwrite");
    public enum RAOINT = __traits(targetHasFeature, "raoint");
    public enum RDPID = __traits(targetHasFeature, "rdpid");
    public enum RDRND = __traits(targetHasFeature, "rdrnd");
    public enum RDSEED = __traits(targetHasFeature, "rdseed");
    public enum RETPOLINE_EXTERNAL_THUNK = __traits(targetHasFeature, "retpoline-external-thunk");
    public enum RTM = __traits(targetHasFeature, "rtm");
    public enum SAHF = __traits(targetHasFeature, "sahf");
    public enum SERIALIZE = __traits(targetHasFeature, "serialize");
    public enum SGX = __traits(targetHasFeature, "sgx");
    public enum SHSTK = __traits(targetHasFeature, "shstk");
    public enum SM3 = __traits(targetHasFeature, "sm3");
    public enum SM4 = __traits(targetHasFeature, "sm4");
    public enum TBM = __traits(targetHasFeature, "tbm");
    public enum TSXLDTRK = __traits(targetHasFeature, "tsxldtrk");
    public enum UINTR = __traits(targetHasFeature, "uintr");
    public enum WAITPKG = __traits(targetHasFeature, "waitpkg");
    public enum WBNOINVD = __traits(targetHasFeature, "wbnoinvd");
    public enum X87 = __traits(targetHasFeature, "x87");
    public enum XSAVE = __traits(targetHasFeature, "xsave");
    public enum XSAVEC = __traits(targetHasFeature, "xsavec");
    public enum XSAVEOPT = __traits(targetHasFeature, "xsaveopt");
    public enum XSAVES = __traits(targetHasFeature, "xsaves");
}
else
{
    public enum _3DNOW = false;
    public enum _3DNOWA = false;
    public enum MMX = false;

    public enum AES = false;
    public enum SHA = false;
    public enum SHA512 = false;
    public enum KL = false;
    public enum WIDEKL = false;

    public enum SSE = false;
    public enum SSE2 = false;
    public enum SSE3 = false;
    public enum SSSE3 = false;
    public enum SSE41 = false;
    public enum SSE42 = false;
    public enum SSE4A = false;

    public enum AVX = false;
    public enum AVX2 = false;
    public enum AVXNECONVERT = false;
    public enum AVXVNNI = false;
    public enum AVXIFMA = false;
    public enum AVXVNNIINT16 = false;
    public enum AVXVNNIINT8 = false;

    public enum AVX512F = false;
    public enum AVX512CD = false;
    public enum AVX512ER = false;
    public enum AVX512PF = false;
    public enum AVX512BW = false;
    public enum AVX512DQ = false;
    public enum AVX512VL = false;
    public enum AVX512IFMA = false;
    public enum AVX512VBMI = false;
    public enum AVX512VBMI2 = false;

    public enum AVX512FP16 = false;
    public enum AVX512BF16 = false;
    public enum AVX512VNNI = false;
    public enum AVX512BITALG = false;

    public enum AVX512VP2INTERSECT = false;
    public enum AVX512VPOPCNTDQ = false;

    public enum VAES = false;
    public enum VPCLMULQDQ = false;
    public enum VZEROUPPER = false;
    public enum XOP = false;

    public enum AMX_BF16 = false;
    public enum AMX_COMPLEX = false;
    public enum AMX_FP16 = false;
    public enum AMX_INT8 = false;
    public enum AMX_TILE = false;

    public enum F16C = false;
    public enum FMA = false;
    public enum FMA4 = false;

    public enum PREFETCHI = false;
    public enum PREFETCHWT1 = false;

    public enum ADX = false;
    public enum BMI = false;
    public enum BMI2 = false;
    public enum CLDEMOTE = false;
    public enum CLFLUSHOPT = false;
    public enum CLWB = false;
    public enum CLZERO = false;
    public enum CMPCCXADD = false;
    public enum CRC32 = false;
    public enum CX16 = false;
    public enum ENQCMD = false;
    public enum FSGSBASE = false;
    public enum FXSR = false;
    public enum GFNI = false;
    public enum HRESET = false;
    public enum INVPCID = false;
    public enum LWP = false;
    public enum LZCNT = false;
    public enum MOVBE = false;
    public enum MOVDIR64B = false;
    public enum MOVDIRI = false;
    public enum MWAITX = false;
    public enum PCLMUL = false;
    public enum PCONFIG = false;
    public enum PKU = false;
    public enum POPCNT = false;
    public enum PRFCHW = false;
    public enum PTWRITE = false;
    public enum RAOINT = false;
    public enum RDPID = false;
    public enum RDRND = false;
    public enum RDSEED = false;
    public enum RETPOLINE_EXTERNAL_THUNK = false;
    public enum RTM = false;
    public enum SAHF = false;
    public enum SERIALIZE = false;
    public enum SGX = false;
    public enum SHSTK = false;
    public enum SM3 = false;
    public enum SM4 = false;
    public enum TBM = false;
    public enum TSXLDTRK = false;
    public enum UINTR = false;
    public enum WAITPKG = false;
    public enum WBNOINVD = false;
    public enum X87 = false;
    public enum XSAVE = false;
    public enum XSAVEC = false;
    public enum XSAVEOPT = false;
    public enum XSAVES = false;
}