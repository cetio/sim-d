module simd;

public import simd.features;
public import simd.vector;
public import simd.mask;

package:
enum isM128(T) = is(T == mask8x16) || is(T == mask16x8) || is(T == mask32x4) || is(T == mask64x2);
enum isM256(T) = is(T == mask8x32) || is(T == mask16x16) || is(T == mask32x8) || is(T == mask64x4);