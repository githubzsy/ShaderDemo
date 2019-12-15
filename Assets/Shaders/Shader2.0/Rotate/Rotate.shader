Shader "Shader2.0/Rotate"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed("Speed",float) = 20
    }
    SubShader
    {
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
            float _Speed;

            fixed4 frag (v2f i) : SV_Target
            {
                //1.先将uv平移到原点
                float2 pianyi=(0.2,0.2);

                float2 tempUV=i.uv;
                tempUV -= pianyi;

                if(length(tempUV)>0.2){
                    return fixed4(0,0,0,0);
                }
                float2 finalUV=0;
                float angle=_Time.x*_Speed;
                //2.确定是按照z轴旋转，选取旋转公式
                finalUV.x=tempUV.x * cos(angle) - tempUV.y*sin(angle);
                finalUV.y=tempUV.x * sin(angle) + tempUV.y*cos(angle);
                //3.将uv还原到以前的位置
                finalUV += pianyi;
                fixed4 col = tex2D(_MainTex, finalUV);
                return col;
            }
            ENDCG
        }
    }
}
