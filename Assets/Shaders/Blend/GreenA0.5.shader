Shader "Custom/GreenA0.5"
{
    Properties
    {
        //当前颜色为绿色,透明通道值为0.5
        _Color ("Color", Color) = (0,1,0,0.5)
    }
    SubShader
    {
        Pass{
            Color [_Color]
            // (0,255,0,255)绿色 + (255,0,0,255)红色 = (255,255,0,255)黄色
            // 忽略了透明通道,中间重合部分为黄色
            //Blend One One

            // (0,255,0,255)*0.5 + (255,0,0,255)*(1-0.5) = (127,127,0,255)
            Blend SrcAlpha OneMinusSrcAlpha
        }
    }
}
