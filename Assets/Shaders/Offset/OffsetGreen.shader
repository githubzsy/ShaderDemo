Shader "Shader/OffsetGreen"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
       Pass
       {
           offset -1,0
           Color(0,1,0,1)

       }
    }
}
