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
public template mboilerplate()
{
    enum mboilerplate = q{
    
    };
}