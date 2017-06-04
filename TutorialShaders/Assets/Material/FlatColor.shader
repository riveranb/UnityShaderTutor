Shader "Unlit/FlatColor"
{
	Properties
	{
		// 編輯器可編輯變數, 由編輯器指定顏色
		_TintColor ("Tint", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
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
			};

			// 定義資料結構, 讓vertex shader 傳送並內插計算數值結果到fragment shader
			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex); // 物體空間座表轉換到投影正規空間座標
				return o;
			}

			// 在Properties 區塊中定義的可編輯變數, 在此宣告後fragment shader就可以使用
			fixed4 _TintColor;
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = _TintColor; // single flat color
				return col;
			}
			ENDCG
		}
	}
}
