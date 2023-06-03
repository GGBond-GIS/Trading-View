struct Float64Vec4 {
    x: Float64,
    y: Float64,
    z: Float64,
    w: Float64
}

fn Float64Vec4_Build(x: Float64, y: Float64, z: Float64, w: Float64) -> Float64Vec4{
    var result: Float64Vec4;
    result.x = x;
    result.y = y;
    result.z = z;
    result.w = w;
    return result;
}

fn Float64Vec4_BuildFromFloat32Vec4(v: vec4<f32>) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_BuildFromFloat32(v.x);
    result.y = Float64_BuildFromFloat32(v.y);
    result.z = Float64_BuildFromFloat32(v.z);
    result.w = Float64_BuildFromFloat32(v.w);
    return result;
}

fn Float64Vec4_BuildFromFloat32(x: f32, y: f32, z: f32, w: f32) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_BuildFromFloat32(x);
    result.y = Float64_BuildFromFloat32(y);
    result.z = Float64_BuildFromFloat32(z);
    result.w = Float64_BuildFromFloat32(w);
    return result;
}

fn Float64Vec4_ToFloat32Vec4(v: Float64Vec4) -> vec4<f32> {
    return vec4<f32>(
        Float64_ToFloat32(v.x),
        Float64_ToFloat32(v.y),
        Float64_ToFloat32(v.z),
        Float64_ToFloat32(v.w),
    );
}

fn Float64Vec4_Add(a: Float64Vec4, b: Float64Vec4) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Add(a.x, b.x);
    result.y = Float64_Add(a.y, b.y);
    result.z = Float64_Add(a.z, b.z);
    result.w = Float64_Add(a.w, b.w);
    return result;
}

fn Float64Vec4_Subtract(a: Float64Vec4, b: Float64Vec4) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Subtract(a.x, b.x);
    result.y = Float64_Subtract(a.y, b.y);
    result.z = Float64_Subtract(a.z, b.z);
    result.w = Float64_Subtract(a.w, b.w);
    return result;
}

fn Float64Vec4_Multiply(a: Float64Vec4, b: Float64Vec4) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Multiply(a.x, b.x);
    result.y = Float64_Multiply(a.y, b.y);
    result.z = Float64_Multiply(a.z, b.z);
    result.w = Float64_Multiply(a.w, b.w);
    return result;
}

fn Float64Vec4_Divide(a: Float64Vec4, b: Float64Vec4) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Divide(a.x, b.x);
    result.y = Float64_Divide(a.y, b.y);
    result.z = Float64_Divide(a.z, b.z);
    result.w = Float64_Divide(a.w, b.w);
    return result;
}

fn Float64Vec4_AddScalar(a: Float64Vec4, v: Float64) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Add(a.x, v);
    result.y = Float64_Add(a.y, v);
    result.z = Float64_Add(a.z, v);
    result.w = Float64_Add(a.w, v);
    return result;
}

fn Float64Vec4_SubtractScalar(a: Float64Vec4, v: Float64) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Subtract(a.x, v);
    result.y = Float64_Subtract(a.y, v);
    result.z = Float64_Subtract(a.z, v);
    result.w = Float64_Subtract(a.w, v);
    return result;
}

fn Float64Vec4_MultiplyScalar(a: Float64Vec4, v: Float64) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Multiply(a.x, v);
    result.y = Float64_Multiply(a.y, v);
    result.z = Float64_Multiply(a.z, v);
    result.w = Float64_Multiply(a.w, v);
    return result;
}

fn Float64Vec4_DivideScalar(a: Float64Vec4, v: Float64) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Divide(a.x, v);
    result.y = Float64_Divide(a.y, v);
    result.z = Float64_Divide(a.z, v);
    result.w = Float64_Divide(a.w, v);
    return result;
}

fn Float64Vec4_Dot(a: Float64Vec4, b: Float64Vec4) -> Float64 {
    var result: Float64;
    result = Float64_Add(result, Float64_Multiply(a.x, b.x));
    result = Float64_Add(result, Float64_Multiply(a.y, b.y));
    result = Float64_Add(result, Float64_Multiply(a.z, b.z));
    result = Float64_Add(result, Float64_Multiply(a.w, b.w));
    return result;
}
