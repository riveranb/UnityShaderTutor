Shader "Unlit/FixedVertexLit"
{
	Properties
	{
		_Diffuse("Diffuse Color", Color) = (1,1,1,0)
		_Specular("Specular Color", Color) = (1,1,1,1)
		_Emission("Emmissive Color", Color) = (0,0,0,0)
		_Shininess("Shininess", Range(0.01, 1)) = 0.7
		_BaseTex("Base Texture", 2D) = "white" {}
	}

	// setup fixed function lighting shader (legacy version)
	
	SubShader
	{
		Pass
		{
			Material
			{
				Diffuse[_Diffuse]
				Shininess[_Shininess]
				Specular[_Specular]
				Emission[_Emission]
			}

			Lighting On
			SeparateSpecular On
			SetTexture[_BaseTex]
			{
				Combine texture * primary
			}
		}
	}
}
