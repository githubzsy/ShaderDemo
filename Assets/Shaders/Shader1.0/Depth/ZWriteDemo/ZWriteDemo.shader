Shader "Shader/Depth/ZWriteDemo"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        //当前深度值总是替换Gbuffer中的深度值
        //ZWrite On
        
        //深度测试总是通过
        //ZTest Always

        //比当前Gbuffer深度值要小时通过
        //ZTest Less

        //比当前Gbuffer深度值要大时通过
        //ZTest Greater

        //永远不替换Gbuffer中深度值（颜色值在通过时还是会替换）
        ZWrite Off
        ZTest Always



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
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
