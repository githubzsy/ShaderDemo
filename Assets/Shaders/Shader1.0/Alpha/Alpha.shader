Shader "Shader1.0/Alpha"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _AlphaMin("最小透明度",float) = 0.1
    }
    SubShader
    {
        //打开Alpha测试
        AlphaTest Greater [_AlphaMin]
        Pass
        {
            SetTexture[_MainTex]
            {
                combine Texture
            }
		}
    }
}
