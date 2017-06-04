Shader "Unlit/ViewDepth"
{
	Properties
	{
		_ZRatioStart("Z ratio start", Float) = 1
		_ZRatioEnd("Z ratio end", Float) = 100
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM

			// HLSL/CG shader

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			// 定義由GPU端傳送進vertex shader之參數內容
			struct appdata
			{
				float4 vertex : POSITION;
			};

			// 定義資料結構, 讓vertex shader 傳送並內插計算數值結果到fragment shader
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			// 宣告由 Properties 區間定義之變數, 讓 vertex shader使用
			float _ZRatioStart;
			float _ZRatioEnd;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex); // 計算投影正規座標
				float3 viewpos = UnityObjectToViewPos(v.vertex.xyz); // 計算鏡頭空間座標
				o.uv.x = (-viewpos.z - _ZRatioStart) / (_ZRatioEnd - _ZRatioStart); // 計算深度值在指定區間的距離比例
				o.uv.x = clamp(o.uv.x, 0, 1);
				o.uv.y = 0;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(i.uv.x, 0, 0, 1);
				return col;
			}
			ENDCG
		}
	}
}
