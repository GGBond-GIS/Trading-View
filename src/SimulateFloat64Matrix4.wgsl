struct Float64Matrix4 {
    m: array<Float64Vec4, 4>
}

fn Float64Matrix4_Build(h: mat4x4<f32>, l: mat4x4<f32>) -> Float64Matrix4 {
    var result: Float64Matrix4;
    for (var i: i32 = 0; i < 4; i += 1) {
        result.m[i] = Float64Vec4_Build(
            Float64_Build(h[i].x, l[i].x),
            Float64_Build(h[i].y, l[i].y),
            Float64_Build(h[i].z, l[i].z),
            Float64_Build(h[i].w, l[i].w),
        );
    }
    return result;
}

fn Float64Matrix4_BuildFromFloat32Array(v: array<f32, 32>) -> Float64Matrix4 {
    var result: Float64Matrix4;
    for (var i: i32 = 0; i < 32; i += 8) {
        let j = i / 8;
        result.m[j].x = Float64_Build(v[i + 0], v[i + 1]);
        result.m[j].y = Float64_Build(v[i + 2], v[i + 3]);
        result.m[j].z = Float64_Build(v[i + 4], v[i + 5]);
        result.m[j].w = Float64_Build(v[i + 6], v[i + 7]);
    }
    return result;
}

fn Float64Matrix4_BuildFromFloat32Matrix4(m4x4: mat4x4<f32>) -> Float64Matrix4 {
    var result: Float64Matrix4;
    for (var i: i32 = 0; i < 4; i += 1) {
        result.m[i] = Float64Vec4_BuildFromFloat32Vec4(m4x4[i]);
    }
    return result;
}

fn Float64Matrix4_ToFloat32Matrix4(a: Float64Matrix4) -> mat4x4<f32> {
    var result: mat4x4<f32>;
    result[0][0] = Float64_ToFloat32(a.m[0].x);
    result[0][1] = Float64_ToFloat32(a.m[0].y);
    result[0][2] = Float64_ToFloat32(a.m[0].z);
    result[0][3] = Float64_ToFloat32(a.m[0].w);

    result[1][0] = Float64_ToFloat32(a.m[1].x);
    result[1][1] = Float64_ToFloat32(a.m[1].y);
    result[1][2] = Float64_ToFloat32(a.m[1].z);
    result[1][3] = Float64_ToFloat32(a.m[1].w);

    result[2][0]= Float64_ToFloat32(a.m[2].x);
    result[2][1]= Float64_ToFloat32(a.m[2].y);
    result[2][2] = Float64_ToFloat32(a.m[2].z);
    result[2][3] = Float64_ToFloat32(a.m[2].w);

    result[3][0] = Float64_ToFloat32(a.m[3].x);
    result[3][1] = Float64_ToFloat32(a.m[3].y);
    result[3][2] = Float64_ToFloat32(a.m[3].z);
    result[3][3] = Float64_ToFloat32(a.m[3].w);
    return result;
}

fn Float64Matrix4_ToFloat32Array(v: Float64Matrix4) -> array<f32, 32> {
    var result: array<f32, 32>;
    for (var i: i32 = 0; i < 32; i += 8) {
        let j = i / 8;

        result[i + 0] = v.m[j].x.hBit;
        result[i + 1] = v.m[j].x.lBit;

        result[i + 2] = v.m[j].y.hBit;
        result[i + 3] = v.m[j].y.lBit;

        result[i + 4] = v.m[j].z.hBit;
        result[i + 5] = v.m[j].z.lBit;

        result[i + 6] = v.m[j].w.hBit;
        result[i + 7] = v.m[j].w.lBit;
    }
    return result;
}

fn Float64Matrix4_Add(a: Float64Matrix4, b: Float64Matrix4) -> Float64Matrix4 {
    var result: Float64Matrix4;
    result.m[0] = Float64Vec4_Add(a.m[0], b.m[0]);
    result.m[1] = Float64Vec4_Add(a.m[1], b.m[1]);
    result.m[2] = Float64Vec4_Add(a.m[2], b.m[2]);
    result.m[3] = Float64Vec4_Add(a.m[3], b.m[3]);
    return result;
}

fn Float64Matrix4_Subtract(a: Float64Matrix4, b: Float64Matrix4) -> Float64Matrix4 {
    var result: Float64Matrix4;
    result.m[0] = Float64Vec4_Subtract(a.m[0], b.m[0]);
    result.m[1] = Float64Vec4_Subtract(a.m[1], b.m[1]);
    result.m[2] = Float64Vec4_Subtract(a.m[2], b.m[2]);
    result.m[3] = Float64Vec4_Subtract(a.m[3], b.m[3]);
    return result;
}

fn Float64Matrix4_Multiply(a: Float64Matrix4, b: Float64Matrix4) -> Float64Matrix4 {
    var result: Float64Matrix4;
    var t = Float64_Multiply(b.m[0].x, a.m[0].x);
    t = Float64_Add(t, Float64_Multiply(b.m[0].y, a.m[1].x));
    t = Float64_Add(t, Float64_Multiply(b.m[0].z, a.m[2].x));
    t = Float64_Add(t, Float64_Multiply(b.m[0].w, a.m[3].x));
    result.m[0].x = t; // b.m[0].x * a.m[0].x + b.m[0].y * a.m[1].x + b.m[0].z * a.m[2].x + b.m[0].w * a.m[3].x;

    t = Float64_Multiply(b.m[0].x, a.m[0].y);
    t = Float64_Add(t, Float64_Multiply(b.m[0].y, a.m[1].y));
    t = Float64_Add(t, Float64_Multiply(b.m[0].z, a.m[2].y));
    t = Float64_Add(t, Float64_Multiply(b.m[0].w, a.m[3].y));
    result.m[0].y = t; // b.m[0].x * a.m[0].y + b.m[0].y * a.m[1].y + b.m[0].z * a.m[2].y + b.m[0].w * a.m[3].y;

    t = Float64_Multiply(b.m[0].x, a.m[0].z);
    t = Float64_Add(t, Float64_Multiply(b.m[0].y, a.m[1].z));
    t = Float64_Add(t, Float64_Multiply(b.m[0].z, a.m[2].z));
    t = Float64_Add(t, Float64_Multiply(b.m[0].w, a.m[3].z));
    result.m[0].z = t; // b.m[0].x * a.m[0].z + b.m[0].y * a.m[1].z + b.m[0].z * a.m[2].z + b.m[0].w * a.m[3].z;

    t = Float64_Multiply(b.m[0].x, a.m[0].w);
    t = Float64_Add(t, Float64_Multiply(b.m[0].y, a.m[1].w));
    t = Float64_Add(t, Float64_Multiply(b.m[0].z, a.m[2].w));
    t = Float64_Add(t, Float64_Multiply(b.m[0].w, a.m[3].w));
    result.m[0].w = t; // b.m[0].x * a.m[0].w + b.m[0].y * a.m[1].w + b.m[0].z * a.m[2].w + b.m[0].w * a.m[3].w;

    t = Float64_Multiply(b.m[1].x, a.m[0].x);
    t = Float64_Add(t, Float64_Multiply(b.m[1].y, a.m[1].x));
    t = Float64_Add(t, Float64_Multiply(b.m[1].z, a.m[2].x));
    t = Float64_Add(t, Float64_Multiply(b.m[1].w, a.m[3].x));
    result.m[1].x = t; // b.m[1].x * a.m[0].x + b.m[1].y * a.m[1].x + b.m[1].z * a.m[2].x + b.m[1].w * a.m[3].x;

    t = Float64_Multiply(b.m[1].x, a.m[0].y);
    t = Float64_Add(t, Float64_Multiply(b.m[1].y, a.m[1].y));
    t = Float64_Add(t, Float64_Multiply(b.m[1].z, a.m[2].y));
    t = Float64_Add(t, Float64_Multiply(b.m[1].w, a.m[3].y));
    result.m[1].y = t; // b.m[1].x * a.m[0].y + b.m[1].y * a.m[1].y + b.m[1].z * a.m[2].y + b.m[1].w * a.m[3].y;

    t = Float64_Multiply(b.m[1].x, a.m[0].z);
    t = Float64_Add(t, Float64_Multiply(b.m[1].y, a.m[1].z));
    t = Float64_Add(t, Float64_Multiply(b.m[1].z, a.m[2].z));
    t = Float64_Add(t, Float64_Multiply(b.m[1].w, a.m[3].z));
    result.m[1].z = t; // b.m[1].x * a.m[0].z + b.m[1].y * a.m[1].z + b.m[1].z * a.m[2].z + b.m[1].w * a.m[3].z;

    t = Float64_Multiply(b.m[1].x, a.m[0].w);
    t = Float64_Add(t, Float64_Multiply(b.m[1].y, a.m[1].w));
    t = Float64_Add(t, Float64_Multiply(b.m[1].z, a.m[2].w));
    t = Float64_Add(t, Float64_Multiply(b.m[1].w, a.m[3].w));
    result.m[1].w = t; // b.m[1].x * a.m[0].w + b.m[1].y * a.m[1].w + b.m[1].z * a.m[2].w + b.m[1].w * a.m[3].w;

    t = Float64_Multiply(b.m[2].x, a.m[0].x);
    t = Float64_Add(t, Float64_Multiply(b.m[2].y, a.m[1].x));
    t = Float64_Add(t, Float64_Multiply(b.m[2].z, a.m[2].x));
    t = Float64_Add(t, Float64_Multiply(b.m[2].w, a.m[3].x));
    result.m[2].x = t; // b.m[2].x * a.m[0].x + b.m[2].y * a.m[1].x + b.m[2].z * a.m[2].x + b.m[2].w * a.m[3].x;

    t = Float64_Multiply(b.m[2].x, a.m[0].y);
    t = Float64_Add(t, Float64_Multiply(b.m[2].y, a.m[1].y));
    t = Float64_Add(t, Float64_Multiply(b.m[2].z, a.m[2].y));
    t = Float64_Add(t, Float64_Multiply(b.m[2].w, a.m[3].y));
    result.m[2].y = t; // b.m[2].x * a.m[0].y + b.m[2].y * a.m[1].y + b.m[2].z * a.m[2].y + b.m[2].w * a.m[3].y;

    t = Float64_Multiply(b.m[2].x, a.m[0].z);
    t = Float64_Add(t, Float64_Multiply(b.m[2].y, a.m[1].z));
    t = Float64_Add(t, Float64_Multiply(b.m[2].z, a.m[2].z));
    t = Float64_Add(t, Float64_Multiply(b.m[2].w, a.m[3].z));
    result.m[2].z = t; // b.m[2].x * a.m[0].z + b.m[2].y * a.m[1].z + b.m[2].z * a.m[2].z + b.m[2].w * a.m[3].z;

    t = Float64_Multiply(b.m[2].x, a.m[0].w);
    t = Float64_Add(t, Float64_Multiply(b.m[2].y, a.m[1].w));
    t = Float64_Add(t, Float64_Multiply(b.m[2].z, a.m[2].w));
    t = Float64_Add(t, Float64_Multiply(b.m[2].w, a.m[3].w));
    result.m[2].w = t; // b.m[2].x * a.m[0].w + b.m[2].y * a.m[1].w + b.m[2].z * a.m[2].w + b.m[2].w * a.m[3].w;

    t = Float64_Multiply(b.m[3].x, a.m[0].x);
    t = Float64_Add(t, Float64_Multiply(b.m[3].y, a.m[1].x));
    t = Float64_Add(t, Float64_Multiply(b.m[3].z, a.m[2].x));
    t = Float64_Add(t, Float64_Multiply(b.m[3].w, a.m[3].x));
    result.m[3].x = t; // b.m[3].x * a.m[0].x + b.m[3].y * a.m[1].x + b.m[3].z * a.m[2].x + b.m[3].w * a.m[3].x;

    t = Float64_Multiply(b.m[3].x, a.m[0].y);
    t = Float64_Add(t, Float64_Multiply(b.m[3].y, a.m[1].y));
    t = Float64_Add(t, Float64_Multiply(b.m[3].z, a.m[2].y));
    t = Float64_Add(t, Float64_Multiply(b.m[3].w, a.m[3].y));
    result.m[3].y = t; // b.m[3].x * a.m[0].y + b.m[3].y * a.m[1].y + b.m[3].z * a.m[2].y + b.m[3].w * a.m[3].y;

    t = Float64_Multiply(b.m[3].x, a.m[0].z);
    t = Float64_Add(t, Float64_Multiply(b.m[3].y, a.m[1].z));
    t = Float64_Add(t, Float64_Multiply(b.m[3].z, a.m[2].z));
    t = Float64_Add(t, Float64_Multiply(b.m[3].w, a.m[3].z));
    result.m[3].z = t; // b.m[3].x * a.m[0].z + b.m[3].y * a.m[1].z + b.m[3].z * a.m[2].z + b.m[3].w * a.m[3].z;

    t = Float64_Multiply(b.m[3].x, a.m[0].w);
    t = Float64_Add(t, Float64_Multiply(b.m[3].y, a.m[1].w));
    t = Float64_Add(t, Float64_Multiply(b.m[3].z, a.m[2].w));
    t = Float64_Add(t, Float64_Multiply(b.m[3].w, a.m[3].w));
    result.m[3].w = t; // b.m[3].x * a.m[0].w + b.m[3].y * a.m[1].w + b.m[3].z * a.m[2].w + b.m[3].w * a.m[3].w;
    return result;
}

fn Float64Matrix4_MultiplyScalar(a: Float64Matrix4, scalar: Float64) -> Float64Matrix4 {
    var result: Float64Matrix4;
    result.m[0] = Float64Vec4_MultiplyScalar(a.m[0], scalar);
    result.m[1] = Float64Vec4_MultiplyScalar(a.m[1], scalar);
    result.m[2] = Float64Vec4_MultiplyScalar(a.m[2], scalar);
    result.m[3] = Float64Vec4_MultiplyScalar(a.m[3], scalar);
    return result;
}

fn Float64Matrix4_MultiplyVec4(a: Float64Matrix4, v: Float64Vec4) -> Float64Vec4 {
    var result: Float64Vec4;
    result.x = Float64_Add(Float64_Multiply(v.x, a.m[0].x), Float64_Multiply(v.y, a.m[1].x));
    result.x = Float64_Add(result.x, Float64_Multiply(v.z, a.m[2].x));
    result.x = Float64_Add(result.x, Float64_Multiply(v.w, a.m[3].x));

    result.y = Float64_Add(Float64_Multiply(v.x, a.m[0].y), Float64_Multiply(v.y, a.m[1].y));
    result.y = Float64_Add(result.y, Float64_Multiply(v.z, a.m[2].y));
    result.y = Float64_Add(result.y, Float64_Multiply(v.w, a.m[3].y));

    result.z = Float64_Add(Float64_Multiply(v.x, a.m[0].z), Float64_Multiply(v.y, a.m[1].z));
    result.z = Float64_Add(result.z, Float64_Multiply(v.z, a.m[2].z));
    result.z = Float64_Add(result.z, Float64_Multiply(v.w, a.m[3].z));

    result.w = Float64_Add(Float64_Multiply(v.x, a.m[0].w), Float64_Multiply(v.y, a.m[1].w));
    result.w = Float64_Add(result.w, Float64_Multiply(v.z, a.m[2].w));
    result.w = Float64_Add(result.w, Float64_Multiply(v.w, a.m[3].w));
    return result;
}
