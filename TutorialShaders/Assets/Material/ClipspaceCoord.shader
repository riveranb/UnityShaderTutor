Shader "Unlit/ClipspaceCoord"
{
	Properties
	{
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
				float4 clipped : TEXCOORD0;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex); // 物體空間座表轉換到投影正規空間座標
				o.clipped = o.vertex;
				o.clipped.xyz = o.clipped.xyz / o.clipped.w; // 正規化成 [-1~1] 數值區域
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = i.clipped;
				col.rgb = col.rgb * 0.5f + 0.5f; // 轉移 [-1~1] 數值到 [0~1]
				col.b = 0.0f;
				return col;
			}
			ENDCG
		}
	}
}
