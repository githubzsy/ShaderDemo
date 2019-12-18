Shader "Shader/OffsetRed"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            offset 0,-1
            Color(1,0,0,1)
        }
    }
}
