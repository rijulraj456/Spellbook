{{ config(
	tags=['legacy'],
	
        alias = alias('api_fills_deduped', legacy_model=True),
        post_hook='{{ expose_spells(\'["ethereum","arbitrum", "optimism", "polygon","fantom","avalanche_c"]\',
                                "project",
                                "zeroex",
                                \'["rantum","bakabhai993"]\') }}'
        )
}}

/********************************************************
spells with issues, to be excluded in short term:
,ref('zeroex_polygon_api_fills_deduped_legacy') contains duplicates
********************************************************/

{% set zeroex_models = [  
ref('zeroex_arbitrum_api_fills_deduped_legacy')
,ref('zeroex_avalanche_c_api_fills_deduped_legacy')
,ref('zeroex_ethereum_api_fills_deduped_legacy')
,ref('zeroex_fantom_api_fills_deduped_legacy')
,ref('zeroex_optimism_api_fills_deduped_legacy')
,ref('zeroex_bnb_api_fills_deduped_legacy')
] %}


SELECT *
FROM (
    {% for model in zeroex_models %}
    SELECT
      *
    FROM {{ model }}
    {% if not loop.last %}
    UNION ALL
    {% endif %}
    {% endfor %}
)
;
