Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SpecularPower("高光强度",float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Simple

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        float _SpecularPower;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        // 计算灯光效果
        // 
        half4 LightingSimple(SurfaceOutput s,half3 lightDir,half3 viewDir,half atten)
        {
            // 计算漫反射 =  Dot(L,N) * 纹理采样  * 灯光颜色 * 衰减值
            float NDotL = dot(lightDir,s.Normal);

            // 计算镜面反射= 镜面反射 * 纹理采样 * 灯光颜色 * 衰减值
            half3 H= normalize(viewDir + lightDir);
            float HDotN = dot(H,s.Normal);
            
            half4 result = 0;
            result.rgb = (NDotL + HDotN * _SpecularPower) * s.Albedo * _LightColor0 * atten;
            result.a=s.Alpha;


            return result;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
