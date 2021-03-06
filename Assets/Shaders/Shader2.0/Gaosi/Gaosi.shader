﻿Shader "Shader2.0/Gaosi"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Ambient("模糊程度",float)=0.001
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

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
            float _Ambient;
            fixed4 frag (v2f i) : SV_Target
            {
                float2 tempUV=i.uv;
                fixed4 col = tex2D(_MainTex, i.uv);
                //当前像素左侧0.001的点
                fixed4 col2=tex2D(_MainTex,tempUV+float2(-_Ambient,0));
                fixed4 col3=tex2D(_MainTex,tempUV+float2(_Ambient,0));
                //当前像素下方0.001的点
                fixed4 col4=tex2D(_MainTex,tempUV+float2(0,-_Ambient));
                fixed4 col5=tex2D(_MainTex,tempUV+float2(0,_Ambient));
                col=(col+col2+col3+col4+col5)/5.0;
                
                // just invert the colors
                // col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
