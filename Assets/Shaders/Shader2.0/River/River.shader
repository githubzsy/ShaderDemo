Shader "Shader2.0/River"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
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
                /*
                _Time.x = time / 20
                _Time.y = time
                _Time.z = time * 2
                _Time.w = time * 3
                */
                float2 tempUV=i.uv;
                //
                tempUV.x+=_Time.x;
                tempUV.y+=_Time.y;

                //_MainTex表示一张图片
                //uv表示uv比例,二维坐标
                fixed4 col = tex2D(_MainTex, tempUV);
                //红色变成两倍
                // col.x*=2;
                //变成红色呃
                //col.rgba=float4(1,0,0);
                return col;
            }
            ENDCG
        }
    }
}
