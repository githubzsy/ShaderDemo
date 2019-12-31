//兰伯特Lambert漫反射（逐顶点）
Shader "Shader/Lambert/VertexDiffuse"
{
    Properties
    {
        //漫反射颜色
        _DiffuseColor("Color",Color)=(1,1,1,1)
    }
    SubShader
    {
        Pass
        {
            //正向渲染
            Tags{ "LightMode"="ForwardBase" }
            CGPROGRAM//------------------CG语言开始-------------------
            //声明顶点函数
            #pragma vertex vert
            //声明片段函数
            #pragma fragment frag
            //引入光照函数库
            #include "Lighting.cginc"
            //定义外部属性-漫反射颜色
            float4 _DiffuseColor;
            //顶点输入结构体
            struct appdata
            {
                //顶点坐标
                float4 vertex : POSITION;
                //顶点法线
                float3 normal : NORMAL;
            };
            //顶点输出结构体
            struct v2f
            {
                //像素坐标
                float4 vertex : SV_POSITION;
                //临时变量：颜色
                fixed3 color : COLOR;
            };
            //顶点函数实现
            v2f vert (appdata v)
            {
                //定义顶点输出结构体对象
                v2f o;
                //顶点坐标转换到屏幕像素坐标
                o.vertex = UnityObjectToClipPos(v.vertex);
                //获取环境光
                float3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                //将顶点法线转换到世界空间下，并做归一化处理
                float3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                //将光照方向转换到世界空间下，并做归一化处理
                float3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                //带入公式运算
                fixed3 diffuse = _LightColor0.rgb * _DiffuseColor.rgb * saturate(dot(worldNormal,worldLight));
                //结合漫反射和环境光
                o.color = ambient + diffuse;
                //返回结果
                return o;
            }
            

            fixed4 frag (v2f i) : SV_Target
            {
                //将结果返回
                return fixed4(i.color,1.0);
            }
            ENDCG//------------------CG语言结束-------------------
        }
    }
}