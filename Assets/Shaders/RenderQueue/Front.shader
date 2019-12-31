Shader "Shader/RenderQueue/Front"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags {"Queue"="Geometry"}
        Pass
        {
            Color(1,0,0,1)
        }
    }
}
