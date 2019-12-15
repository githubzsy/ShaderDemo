using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestMatrix : MonoBehaviour
{
    public Camera Camera;

    public GameObject Parent;

    void Start()
    {
        //P(物体的世界坐标)=M(物体的父级从本地到世界的矩阵)*P(物体的本地坐标)
        Vector3 positionWorld = transform.parent.localToWorldMatrix.MultiplyPoint(transform.localPosition);
        Debug.Log("物体的世界坐标:"+positionWorld);

        //P(物体的本地坐标)=M(父级的世界到本地的坐标)*P(物体的世界坐标)
        Vector3 positionParent = Parent.transform.worldToLocalMatrix.MultiplyPoint(positionWorld);
        Debug.Log("物体的本地坐标:" + positionParent);

        //P(物体的相机坐标)=M(相机的世界到本地的坐标)*P(物体的世界坐标)
        Vector3 positionCamera= Camera.transform.worldToLocalMatrix.MultiplyPoint(positionWorld);
        Debug.Log("物体的相机坐标:" + positionCamera);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
