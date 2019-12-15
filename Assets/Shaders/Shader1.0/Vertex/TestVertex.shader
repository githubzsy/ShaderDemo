Shader "Custom/TestVertex"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //漫反射颜色
        _DiffuseColor("DiffuseColor",Color) =(1,1,1,1)
        //灯光颜色
        _AmbientColor("AmbientColor",Color) =(1,1,1,1)
        //高光颜色
        _SpecularColor("SpecularColor",Color) =(1,1,1,1)
        //自发光颜色
        _EmissionColor("自发光颜色",Color) =(1,1,1,1)
    }
    SubShader
    {
       Pass
       {
           Material
           {
               Diffuse[_DiffuseColor]
               Ambient[_AmbientColor]
               Specular[_SpecularColor]
               Emission[_EmissionColor]
           }
           
           //高光打开
           SeparateSpecular On
           //灯光打开
           Lighting On
	   }
    }
    FallBack "Diffuse"
}
