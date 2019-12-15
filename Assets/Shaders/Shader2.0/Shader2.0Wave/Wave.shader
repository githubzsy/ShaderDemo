Shader "Shader2.0/Wave"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Arange("峰值高度",float)=1
        _PhiRate("初相(X轴左右偏移量)",float)=0.5
        _Speed("Y轴起伏频率",float)=0.5
    }
    SubShader
    {
        Color(0,0,0,1)
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
            
            sampler2D _MainTex;
            float _PhiRate;
            float _Arange;
            float _Speed;

            v2f vert (appdata v)
            {
                v2f o;
                // y = A*sin(ωx+φ)
                // A:决定峰值
                // ω:决定y轴方向的压缩程度,大于为1时,表示被压缩,小于1时表示拉伸
                // φ:初相,决定波形与X轴位置关系或横向移动距离（左加右减）
                // x:变量,这里就是时间

                // y轴压缩程度,从某个点上来看，就是它在这个时间时所在的高度
                // 从这个地面整体上来看，可以看作y轴的起伏频率
                float timer=_Speed * _Time.y;
                //初相，从某个点上来看是
                //从地面整体上来看，是x轴的上每个点y上面的差值
                float phi=v.vertex.x * _PhiRate;

                float wave =_Arange*sin(timer+phi);
                //将顶点坐标y进行改变
                v.vertex.y=v.vertex.y+wave;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }


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
