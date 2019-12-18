using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Gaosi : MonoBehaviour
{
    public Material Material;

    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        //source,拦截相机渲染出来的图片
        //destination,更改后的图片存在这里,重新交给引擎
        //Material,用哪个材质球渲染
        Graphics.Blit(source,destination,Material);
    }
}
