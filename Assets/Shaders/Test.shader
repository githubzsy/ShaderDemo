//Shader "文件路径",材质球中可以选择Shader:Custom/Test 
Shader "Custom/Test"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Test ("TestInt",  Range(0,1)) = 1
        _TestColor("TestColor",Color) = (1,2,3,4)
        
        _TestVector("TestVector",Vector) = (1,1,1,1)
        //CubeMap，六个面的纹理
        _TestCube("TestCube",Cube) =""{}
        //3D纹理
        _Test3D("Test3D",3D)=""{}
    }

    //SubShader可以有多个，去寻找第一个执行不报错的显卡。第一个SubShader报错则继续判断下一个
    //如果全部都报错，则FallBack
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        //上面的是公共部分
        //每一个pass就渲染一次，多个就渲染多次

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }

    //所有SubShader失败时，则使用Shader:Diffuse
    FallBack "Diffuse"
}
