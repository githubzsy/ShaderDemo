Shader "Shader/MySurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _ChangeRate("顶点xyz变化率", float) = 1
        _NormalChangeRate("所有面的法线的变化", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // 定义片段着色器函数为surf,顶点着色器入口为myvert
        #pragma surface surf Lambert vertex:myvert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            //Input还可以定义其它的许多结构
            float2 uv_MainTex;

            //自定义了一个myColor
            float3 myColor;
        };

        half _Glossiness;
        half _Metallic;
        half _ChangeRate;
        half _NormalChangeRate;
        fixed4 _Color;
        // 顶点着色器
        void myvert(inout appdata_base v,out Input o)
        {
            //先初始化Input类型,o
            UNITY_INITIALIZE_OUTPUT(Input,o);
            //因为myColor是float3,_Color是float4
            //自定义颜色乘以法线信息，得到每个面不一样的颜色
            o.myColor = _Color.rgb * abs(v.normal);
            //这样o.myColor就可以传递到surf的输入参数IN中

            // 让体积增大
            v.vertex.xyz*=_ChangeRate;
            v.vertex.xyz+= v.normal * _NormalChangeRate;
		}

        // 类似于片段着色器
        void surf(Input IN,inout SurfaceOutput o){
            float2 tempUV=IN.uv_MainTex;
            tempUV.x+=_Time.x;
            tempUV.y+=_Time.y;

            o.Albedo = tex2D(_MainTex,tempUV).rgb * IN.myColor;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
