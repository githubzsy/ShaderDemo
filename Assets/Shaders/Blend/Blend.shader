Shader "Shader/Blend"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always

        // Gbuffer默认颜色是相机颜色(DstColor)
        // 假设相机颜色为红色(255,0,0,255)
        // 因为此处只有一个物体,所以Gbuffer里面的颜色默认就是相机颜色(蓝色)
        // 若物体当前像素点为透明白色(255,255,255,127)
        
        // 传统透明度
        // (物体颜色)*物体透明度 + Gbuffer颜色 * (1-物体透明度)
        // (255,255,255,255) * 0.7 + (255,0,0,255) * (1-0.7) = (255,178,178,255)
        // 物体按照自身透明度显示,缺失的透明度用相机颜色填充
        //Blend SrcAlpha OneMinusSrcAlpha

        // 传统透明度的反向效果
        // 物体颜色*(1-物体透明度) + Gbuffer颜色 * 物体透明度
        // (255,255,255,255) * (1-0.7) + (255,0,0,255) * 0.7 = (255,76,76,255)
        // 物体越透明的地方越接近于相机默认颜色,越不透明的地方越接近于物体本身颜色(白色)
        //Blend OneMinusSrcAlpha SrcAlpha

        // 预乘透明度:将要渲染的像素完全通过 + gbuffer里面的像素值 * (1-将要渲染的像素的a)
        // 物体颜色*1 + Gbuffer颜色 * (1-物体透明度)
        // (255,255,255,255) * 1 + (255,0,0,255) * (1-0.7) = (255,255,255,255)
        // 物体只显示白色
        //Blend One OneMinusSrcAlpha

        // 完全显示相机颜色(将看不到物体)
        // Gbuffer颜色 * 1 + 0
        // (255,0,0,255)
        //Blend DstColor Zero

        
        Blend DstColor DstColor

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
