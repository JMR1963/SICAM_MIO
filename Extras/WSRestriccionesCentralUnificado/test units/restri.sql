SELECT COUNT(*) as total
FROM (SELECT P.ID_SIC,
               P.APELLIDO,
               P.APELLIDO2,
               P.NOMBRE,
               P.NOMBRE2,
               P.FECHA_NAC,
               D.NUM_DOC,
               'DNM'
          FROM PERSONAS P,
               R_DNM R,
               PERS_DOC D
         WHERE     (P.CLASE_CONTROL = 22)
               AND (P.VALID = 't')
               AND (P.ID_LOC_C = R.ID_LOC)
               AND (P.ID_MOV_C = R.ID_MOV)
               AND (R.TIPO_RESTRICCION <> 98)
               AND (R.TIPO_RESTRICCION <> 99)
               AND (P.ID_LOC_PADRE = D.ID_LOC)
               AND (P.ID_PERS_PADRE = D.ID_PERS)
               AND (D.VALID = 't')
		AND (P.NACIONALIDAD IN ('ARG','XXX'))
        UNION ALL
        SELECT P.ID_SIC,
               P.APELLIDO,
               P.APELLIDO2,
               P.NOMBRE,
               P.NOMBRE2,
               P.FECHA_NAC,
               D.NUM_DOC,
               'JUSTICIA'
          FROM PERSONAS P,
               R_JUSTICIA R,
               PERS_DOC D
         WHERE (P.CLASE_CONTROL = 21) AND (P.VALID = 't')
               AND (P.ID_LOC_C = R.ID_LOC)
               AND (P.ID_MOV_C = R.ID_MOV)
               AND (R.TIPO_RESTRICCION <> 100)
               AND (P.ID_LOC_PADRE = D.ID_LOC)
               AND (P.ID_PERS_PADRE = D.ID_PERS)
               AND (D.VALID = 't')
		AND (P.NACIONALIDAD IN ('ARG','XXX'))
        UNION ALL
        SELECT P.ID_SIC,
               P.APELLIDO,
               P.APELLIDO2,
               P.NOMBRE,
               P.NOMBRE2,
               P.FECHA_NAC,
               D.NUM_DOC,
               'OTRAS'
          FROM PERSONAS P,
               R_OTRAS R,
               PERS_DOC D
         WHERE (P.CLASE_CONTROL = 23) AND (P.VALID = 't')
               AND (P.ID_LOC_C = R.ID_LOC)
               AND (P.ID_MOV_C = R.ID_MOV)
               AND (P.ID_LOC_PADRE = D.ID_LOC)
               AND (P.ID_PERS_PADRE = D.ID_PERS)
               AND (D.VALID = 't')
               AND (R.TIPO_RESTRICCION not in (102,103))
		AND (P.NACIONALIDAD IN ('ARG','XXX'))
               AND (r.entidad_emisora <> 11) ) TEMPORAL 