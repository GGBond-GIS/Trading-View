struct Float64 {
    hBit: f32,
    lBit: f32
};

fn Float64_Build(hBit: f32, lBit: f32) -> Float64 {
    var result: Float64;
    result.hBit = hBit;
    result.lBit = lBit;
    return result;
}

fn Float64_QuickBuild(a: f32, b: f32) -> Float64 {
    let s = a + b;
    let e = b - (s - a);
    var result: Float64;
    result.hBit = s;
    result.lBit = e;
    return result;
}

fn Float64_PrecisionBuild(a: f32, b: f32) -> Float64 {
    let s = a + b;
    let v = s - a;
    let e = (a - (s - v)) + (b - v);
    var result: Float64;
    result.hBit = s;
    result.lBit = e;
    return result;
}

fn Float64_BuildFromSplitFloat32(v: f32) -> Float64 {
    // var result: Float64;
    // result.hBit = floor(v);
    // result.lBit = v - result.hBit;
    // return result;

    let p = 4097.0 * v;
    let hBit = p - ( p - v);
    let lBit = v - hBit;
    return Float64_Build(hBit, lBit);
}

fn Float64_BuildFromFloat32(v: f32) -> Float64 {
    return Float64_BuildFromSplitFloat32(v);
}

fn Float64_BuildFromFloat32Array(v: array<f32, 2>) -> Float64 {
    var result: Float64;
    result.hBit = v[0];
    result.lBit = v[1];
    return result;
}

fn Float64_ToFloat32(v: Float64) -> f32 {
    return v.hBit + v.lBit;
}

fn Float64_ToFloat32Array(v: Float64) -> array<f32, 2> {
    return array<f32, 2>(v.hBit, v.lBit);
}

fn Float64_Add(a: Float64, b: Float64) -> Float64 {
    // var result: Float64;
    // result.lBit = a.lBit + b.lBit;
    // let carry: f32 = result.lBit - a.lBit;
    // result.hBit = a.hBit + b.hBit + carry;
    // return result;

    var s = Float64_PrecisionBuild(a.hBit, b.hBit);
    let t = Float64_PrecisionBuild(a.lBit, b.lBit);
    s.lBit += t.lBit;
    s = Float64_QuickBuild(s.hBit, s.lBit);
    s.lBit += t.lBit;
    return Float64_QuickBuild(s.hBit, s.lBit);
}

fn Float64_Subtract(a: Float64, b: Float64) -> Float64 {
    return Float64_Add(a, Float64_Negation(b));
}

fn Float64_Product(a: f32, b: f32) -> Float64 {
    let p = a * b;
    let float64_a = Float64_BuildFromSplitFloat32(a);
    let float64_b = Float64_BuildFromSplitFloat32(b);
    let e = ((float64_a.hBit * float64_b.hBit - p) + float64_a.hBit * float64_b.lBit + float64_a.lBit * float64_b.hBit) + float64_a.lBit * float64_b.lBit;
    return Float64_Build(p, e);
}

fn Float64_Multiply(a: Float64, b: Float64) -> Float64 {
    var p = Float64_Product(a.hBit, b.hBit);
    p.lBit += a.hBit * b.lBit;
    p.lBit += a.lBit * b.hBit;
    return Float64_QuickBuild(p.hBit, p.lBit);
}

fn Float64_Divide(a: Float64, b: Float64) -> Float64 {
    var result: Float64;
    result.hBit = a.hBit / b.hBit;
    result.lBit = (a.hBit * b.lBit - a.lBit * b.hBit) / (b.hBit * b.hBit);
    return result;
}

fn Float64_AddFloat32(a: Float64, b: f32) -> Float64 {
    var s = Float64_PrecisionBuild(a.hBit, b);
    s.lBit += a.lBit;
    return Float64_QuickBuild(s.hBit, s.lBit);
}

fn Float64_SubtractFloat32(a: Float64, b: f32) -> Float64 {
    return Float64_AddFloat32(a, -b);
}

fn Float64_MultiplyFloat32(a: Float64, b: f32) -> Float64 {
    var p = Float64_Product(a.hBit, b);
    p.lBit += a.lBit * b;
    return Float64_QuickBuild(p.hBit, p.lBit);
}

fn Float64_Negation(a: Float64) -> Float64 {
    var result: Float64;
    result.hBit = -a.hBit;
    result.lBit = -a.lBit;
    return result;
}

fn Float64_Equal(a: Float64, b: Float64) -> bool {
    return a.hBit == b.hBit && a.lBit == b.lBit;
}

fn Float64_Greater(a: Float64, b: Float64) -> bool {
    return a.hBit > b.hBit || (a.hBit == b.hBit && a.lBit > b.lBit);
}

fn Float64_GreaterEqual(a: Float64, b: Float64) -> bool {
    return a.hBit >= b.hBit || (a.hBit == b.hBit && a.lBit >= b.lBit);
}

fn Float64_Less(a: Float64, b: Float64) -> bool {
    return a.hBit < b.hBit || (a.hBit == b.hBit && a.lBit < b.lBit);
}

fn Float64_LessEqual(a: Float64, b: Float64) -> bool {
    return a.hBit <= b.hBit || (a.hBit == b.hBit && a.lBit <= b.lBit);
}
