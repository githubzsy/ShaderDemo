Shader "Shader2.0/Alpha"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _AlphaMin("最小透明度",float) = 0.1
    }
    SubShader
    {
        //打开2.0的透明通道
        Blend SrcAlpha OneMinusSrcAlpha
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
            float _AlphaMin;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                //直接在片段着色器中判断alpha值
                if(col.a<_AlphaMin){
                    return fixed4(0,0,0,0);
                    return fixed4(0,0,0,0);
                }
                else return col;
            }
            ENDCG
        }
    }
}
