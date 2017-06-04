// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/UVs"
{
	Properties
	{
		_WeightU("Weight U", Range(0, 1)) = 1
		_WeightV("Weight V", Range(0, 1)) = 1
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100
		
		Pass
		{
			CGPROGRAM

			// implement HLSL/CG shader

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			// 定義由GPU端傳送進vertex shader之參數內容
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			// 定義資料結構, 讓vertex shader 傳送並內插計算數值結果到fragment shader
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			// 宣告由 Properties 區間定義之變數, 讓 vertex shader使用
			float _WeightU;
			float _WeightV;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex); // 計算投影正規空間座標
				o.uv = v.uv * float2(_WeightU, _WeightV); // 由權重控制 UV 最終顯示的數值
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(i.uv.x, i.uv.y, 0, 1);
				return col;
			}
			ENDCG
		}
	}
}
