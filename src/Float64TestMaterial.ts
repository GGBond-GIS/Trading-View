import { Color, Engine3D, MaterialBase, ShaderLib, Texture, UniformGPUBuffer, Vector4 } from "@orillusion/core";
import SimulateFloat64 from "./SimulateFloat64.wgsl?raw"
import SimulateFloat64Vector4 from "./SimulateFloat64Vector4.wgsl?raw"
import SimulateFloat64Matrix4 from "./SimulateFloat64Matrix4.wgsl?raw"

export class Float64TestMaterial extends MaterialBase {
    constructor() {
        super();
        ShaderLib.register("SimulateFloat64", SimulateFloat64);
        ShaderLib.register("SimulateFloat64Vector4", SimulateFloat64Vector4);
        ShaderLib.register("SimulateFloat64Matrix4", SimulateFloat64Matrix4);
        ShaderLib.register("Float64TestShader", Float64TestMaterial.shader);

        let shader = this.setShader(`Float64TestShader`, `Float64TestShader`);
        shader.setShaderEntry(`VertMain`, `FragMain`);

        shader.setUniformVector4(`transformUV1`, new Vector4(0, 0, 1, 1));
        shader.setUniformVector4(`transformUV2`, new Vector4(0, 0, 1, 1));
        shader.setUniformColor(`baseColor`, new Color());
        shader.setUniformFloat(`alphaCutoff`, 0.5);
        shader.setUniformBuffer(`args`, new UniformGPUBuffer(96));
        let shaderState = shader.shaderState;
        shaderState.acceptShadow = false;
        shaderState.receiveEnv = false;
        shaderState.acceptGI = false;
        shaderState.useLight = false;
        shaderState.useZ = false;

        shader.setUniformColor("ccc", new Color(1.0, 0.0, 0.0, 1.0));

        // default value
        this.baseMap = Engine3D.res.whiteTexture;
    }

    public set envMap(texture: Texture) {
    }

    public set shadowMap(texture: Texture) {
    }

    protected static shader = /* wgsl */ `
        #include "GlobalUniform"
        #include "WorldMatrixUniform"
        #include "SimulateFloat64"
        #include "SimulateFloat64Vector4"
        #include "SimulateFloat64Matrix4"

        struct VertexInput {
            @builtin(instance_index) index : u32,
            @location(0) position: vec3<f32>,
            @location(1) normal: vec3<f32>,
            @location(2) uv: vec2<f32>,
        };

        struct VertexOutput {
            @location(0) uv: vec2<f32>,
            @location(1) color: vec4<f32>,
            @location(2) worldPos: vec4<f32>,
            @builtin(position) member: vec4<f32>
        };

        struct MVPMatrix {
            cameraPos_h: vec3<f32>,
            retain0: f32,
            cameraPos_l: vec3<f32>,
            retain1: f32,
            matrixMVP_RTE: mat4x4<f32>,
        };
        
        @group(2) @binding(0)
        var<uniform> args: MVPMatrix;

        fn applyLogarithmicDepth(
            clipPosition: vec4<f32>,
            logarithmicDepthConstant: f32,
            perspectiveFarPlaneDistance: f32) -> vec4<f32>
       {
           let z = ((2.0 * log((logarithmicDepthConstant * clipPosition.z) + 1.0) / 
                          log((logarithmicDepthConstant * perspectiveFarPlaneDistance) + 1.0)) - 1.0) * clipPosition.w;
       
           return vec4<f32>(clipPosition.x,clipPosition.y,z,clipPosition.w);
       }
       
        @vertex
        fn VertMain( in: VertexInput ) -> VertexOutput {
            let position_h = in.position;
            let position_l = in.normal;

            let highDiff = position_h - args.cameraPos_h;
            let lowDiff = position_l - args.cameraPos_l;
            let clipPosition = args.matrixMVP_RTE * vec4<f32>(highDiff + lowDiff, 1.0);

            var out: VertexOutput;
            out.uv = in.uv;
            out.color = vec4<f32>(1, 1, 1, 1);
            // out.worldPos = worldPos;
            out.member = applyLogarithmicDepth(clipPosition,1.0,16478137.0);

            // out.member = clipPosition;
            return out;

            // // let ORI_MATRIX_M = models.matrix[u32(in.index)];
            // var ORI_MATRIX_V = globalUniform.viewMat;
            // let ORI_MATRIX_P = globalUniform.projMat;
            // let cameraPos = globalUniform.CameraPos;

            // var position = in.position + in.normal;
            // position = position - cameraPos;

            // ORI_MATRIX_V[3][0] = 0;
            // ORI_MATRIX_V[3][1] = 0;
            // ORI_MATRIX_V[3][2] = 0;

            // var worldPos = /* ORI_MATRIX_M * */ vec4<f32>(position, 1.0);
            // var viewPosition = ORI_MATRIX_V * worldPos;
            // var clipPosition = ORI_MATRIX_P * viewPosition;

            // var out: VertexOutput;
            // out.uv = in.uv;
            // out.color = vec4<f32>(0, 1, 0, 1);
            // // out.worldPos = worldPos;
            // out.member = clipPosition;
            // return out;



            

            // let position_f64: Float64Vec4 = Float64Vec4_Build(
            //     Float64_Build(in.position.x, in.normal.x),
            //     Float64_Build(in.position.y, in.normal.y),
            //     Float64_Build(in.position.z, in.normal.z),
            //     Float64_BuildFromFloat32(1.0),
            // );

            // let ORI_MATRIX_M_F64: Float64Matrix4 = Float64Matrix4_BuildFromFloat32Matrix4(ORI_MATRIX_M);
            // let ORI_MATRIX_V_F64: Float64Matrix4 = Float64Matrix4_BuildFromFloat32Matrix4(ORI_MATRIX_V);
            // let ORI_MATRIX_P_F64: Float64Matrix4 = Float64Matrix4_BuildFromFloat32Matrix4(ORI_MATRIX_P);

            // let ORI_MATRIX_M_F64: Float64Matrix4 = Float64Matrix4_Build(matrixMVP.modelMat_h, matrixMVP.modelMat_l);
            // let ORI_MATRIX_V_F64: Float64Matrix4 = Float64Matrix4_Build(matrixMVP.viewMat_h, matrixMVP.viewMat_l);
            // let ORI_MATRIX_P_F64: Float64Matrix4 = Float64Matrix4_Build(matrixMVP.projMat_h, matrixMVP.projMat_l);

            // let worldPos_f64: Float64Vec4 = Float64Matrix4_MultiplyVec4(ORI_MATRIX_M_F64, position_f64);
            // let viewPosition_f64: Float64Vec4 = Float64Matrix4_MultiplyVec4(ORI_MATRIX_V_F64, worldPos_f64);
            // let clipPosition_f64: Float64Vec4 = Float64Matrix4_MultiplyVec4(ORI_MATRIX_P_F64, viewPosition_f64);

            // var out: VertexOutput;
            // out.uv = in.uv;
            // out.worldPos = Float64Vec4_ToFloat32Vec4(worldPos_f64);
            // out.member = Float64Vec4_ToFloat32Vec4(clipPosition_f64);
            // return out;
        }

        struct FragmentInput {
            @location(0) uv: vec2<f32>,
            @location(1) color: vec4<f32>,
            @location(2) worldPos: vec4<f32>,
            @builtin(position) member: vec4<f32>
        };

        struct FragmentOutput {
            @location(0) color: vec4<f32>,
            #if USE_WORLDPOS
                @location(1) worldPos: vec4<f32>,
            #endif
            #if USEGBUFFER
                @location(2) worldNormal: vec4<f32>,
                @location(3) material: vec4<f32>,
            #endif
        };

        @group(1) @binding(0)
        var baseMapSampler: sampler;
        @group(1) @binding(1)
        var baseMap: texture_2d<f32>;

        @fragment
        fn FragMain( in: FragmentInput ) -> FragmentOutput {
            var out: FragmentOutput;
            out.worldPos = in.worldPos;
            out.color = textureSample(baseMap, baseMapSampler, in.uv) * in.color;
            return out;
        }
    `;
}
