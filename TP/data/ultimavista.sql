SELECT
	C.nombre_circuito, A.codigo_auto, A.modelo_auto,
	AVG(SS.dgt_motor)		AS promedio_desgaste_motor,
	AVG(dgt_caja)			AS promedio_desgaste_caja,
	AVG(dgt_freno1)			AS promedio_desgaste_freno1,
	AVG(dgt_freno2)			AS promedio_desgaste_freno2,
	AVG(dgt_freno3)			AS promedio_desgaste_freno3,
	AVG(dgt_freno4)			AS promedio_desgaste_freno4,
	AVG(dgt_neu1)			AS promedio_desgaste_neumatico1,
	AVG(dgt_neu2)			AS promedio_desgaste_neumatico2,
	AVG(dgt_neu3)			AS promedio_desgaste_neumatico3,
	AVG(dgt_neu4)			AS promedio_desgaste_neumatico4
FROM (SELECT 
	codigo_circuito, codigo_auto, numero_vuelta,
	MAX(potencia_motor) - MIN(potencia_motor)						as dgt_motor,
	MAX(desgaste_caja) - MIN(desgaste_caja)							as dgt_caja,
	
	MAX(grosor_pastilla1) - MIN(grosor_pastilla1)					as dgt_freno1,
	MAX(grosor_pastilla2) - MIN(grosor_pastilla2)					as dgt_freno2,
	MAX(grosor_pastilla3) - MIN(grosor_pastilla3)					as dgt_freno3,
	MAX(grosor_pastilla4) - MIN(grosor_pastilla4)					as dgt_freno4,
	
	MAX(profundidad_neumatico1) - MIN(profundidad_neumatico1)		as dgt_neu1,
	MAX(profundidad_neumatico2) - MIN(profundidad_neumatico2)		as dgt_neu2,
	MAX(profundidad_neumatico3) - MIN(profundidad_neumatico3)		as dgt_neu3,
	MAX(profundidad_neumatico4) - MIN(profundidad_neumatico4)		as dgt_neu4
			
	FROM [MARCO_AND_FRIENDS].[BI_Telemetria]
	GROUP BY codigo_circuito, codigo_auto, numero_vuelta
	) AS SS
	JOIN MARCO_AND_FRIENDS.BI_Auto A ON SS.codigo_auto = A.codigo_auto
	JOIN MARCO_AND_FRIENDS.BI_Circuito C ON SS.codigo_circuito = C.codigo_circuito 
GROUP BY C.nombre_circuito, A.codigo_auto, A.modelo_auto
ORDER BY C.nombre_circuito, A.codigo_auto, A.modelo_auto




-- reemplaza:

SELECT
    A.modelo_auto,
    C.nombre_circuito,
    AVG(SS.DES_CAJA) AS DESGASTE_PROMEDIO_CAJA,
    AVG(SS.DES_MOTOR) AS DESGASTE_PROMEDIO_MOTOR,
    AVG(SS.DES_F1) AS DESGASTE_PROMEDIO_FRENO1,
    AVG(SS.DES_F2) AS DESGASTE_PROMEDIO_FRENO2,
    AVG(SS.DES_F3) AS DESGASTE_PROMEDIO_FRENO3,
    AVG(SS.DES_F4) AS DESGASTE_PROMEDIO_FRENO4,
    AVG(SS.DES_NEU1) AS DESGASTE_PROMEDIO_NEUMATICO1,
    AVG(SS.DES_NEU2) AS DESGASTE_PROMEDIO_NEUMATICO2,
    AVG(SS.DES_NEU3) AS DESGASTE_PROMEDIO_NEUMATICO3,
    AVG(SS.DES_NEU4) AS DESGASTE_PROMEDIO_NEUMATICO4

FROM (SELECT 
        codigo_auto, codigo_circuito, numero_vuelta,
        MARCO_AND_FRIENDS.DESGASTE_CAJA(codigo_auto, codigo_circuito, numero_vuelta) AS DES_CAJA,
        MARCO_AND_FRIENDS.DESGASTE_MOTOR(codigo_auto, codigo_circuito, numero_vuelta) AS DES_MOTOR,
            
        MARCO_AND_FRIENDS.DESGASTE_FRENO1(codigo_auto, codigo_circuito, numero_vuelta) AS DES_F1,
        MARCO_AND_FRIENDS.DESGASTE_FRENO2(codigo_auto, codigo_circuito, numero_vuelta) AS DES_F2,
        MARCO_AND_FRIENDS.DESGASTE_FRENO3(codigo_auto, codigo_circuito, numero_vuelta) AS DES_F3,
        MARCO_AND_FRIENDS.DESGASTE_FRENO4(codigo_auto, codigo_circuito, numero_vuelta) AS DES_F4,

        MARCO_AND_FRIENDS.DESGASTE_NEUMATICO1(codigo_auto, codigo_circuito, numero_vuelta) AS DES_NEU1,
        MARCO_AND_FRIENDS.DESGASTE_NEUMATICO2(codigo_auto, codigo_circuito, numero_vuelta) AS DES_NEU2,
        MARCO_AND_FRIENDS.DESGASTE_NEUMATICO3(codigo_auto, codigo_circuito, numero_vuelta) AS DES_NEU3,
        MARCO_AND_FRIENDS.DESGASTE_NEUMATICO4(codigo_auto, codigo_circuito, numero_vuelta) AS DES_NEU4
            
        FROM MARCO_AND_FRIENDS.BI_Telemetria
        GROUP BY codigo_auto, codigo_circuito, numero_vuelta
) AS SS
LEFT JOIN MARCO_AND_FRIENDS.BI_Auto A ON A.codigo_auto = SS.codigo_auto
LEFT JOIN MARCO_AND_FRIENDS.BI_Circuito C ON C.codigo_circuito = SS.codigo_circuito
GROUP BY A.modelo_auto, C.nombre_circuito


select * from MARCO_AND_FRIENDS.BI_DESGASTE_PROMEDIO_AUTO_POR_VUELTA_POR_CIRCUITO