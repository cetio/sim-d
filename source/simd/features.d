module simd.features;

//version (GNU) package import gcc.builtins;
version (LDC) package import ldc.simd;
version (LDC) package import ldc.intrinsics;
version (LDC) package import ldc.gccbuiltins_x86;
version (LDC) package import ldc.llvmasm;

version (LDC)
{
    pragma(LDC_inline_ir)
    R inlineIR(string s, R, P...)(P) @nogc pure;

    package enum LDC_with_SSE = __traits(targetHasFeature, "sse");
    package enum LDC_with_SSE2 = __traits(targetHasFeature, "sse2");
    package enum LDC_with_SSE3 = __traits(targetHasFeature, "sse3");
    package enum LDC_with_SSSE3 = __traits(targetHasFeature, "ssse3");
    package enum LDC_with_AVX = __traits(targetHasFeature, "avx");
    package enum LDC_with_AVX2 = __traits(targetHasFeature, "avx2");
    package enum LDC_with_AVX512 = __traits(targetHasFeature, "avx512f");
    
    package enum LDC_with_SSE41 = __traits(targetHasFeature, "sse4.1");
    package enum LDC_with_SSE42 = __traits(targetHasFeature, "sse4.2");
}
else
{
    package enum LDC_with_SSE = false;
    package enum LDC_with_SSE2 = false;
    package enum LDC_with_SSE3 = false;
    package enum LDC_with_SSSE3 = false;
    package enum LDC_with_AVX = false;
    package enum LDC_with_AVX2 = false;
    package enum LDC_with_AVX512 = false;
    
    package enum LDC_with_SSE41 = false;
    package enum LDC_with_SSE42 = false;
}