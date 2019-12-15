Shader "Custom/SetTexture"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BlendTex ("BlendTex", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            //Color(1,0,0,1)
            SetTexture[_MainTex]
            {
                //当前顶点颜色与纹理进行融合
                //乘法越乘越小，加法越加越大
                combine Primary*Texture
            }

            SetTexture[_BlendTex]
            {
                //前面顶点与当前纹理进行融合
                combine Previous*Texture
            }

            SetTexture[_BlendTex]
            {
                //公式: combine src1 lerp(src2) src3
                //src1与src3进行插值运算，并且取src2的alpha值
                //结果= (1 - src2.alpha)src1 + src.alpha * src3
                combine Previous lerp(Previous) Texture
            }

            SetTexture[_MainTex]
            {
                //ConstantColor可以作为变量，用Constant进行引用
                ConstantColor(0,1,0,1)
                Combine Texture * Constant
            }
        }
    }
}
