
SELECT 
       a.apellido1,
       a.apellido2,
       a.nombre1,
       a.nombre2,
       a.nro_documento,
       a.fecha_nacimiento,
       a.nacionalidad AS cod_nac,
       B.NACIONALIDAD as Nacionalidad,
       a.usuario_registro,
       a.fecha_registro,
       substr(foto_personal,31,length(foto_personal)) as facial,
       substr(imagen_pasaporte,31,length(imagen_pasaporte)) as ImgDoc
       FROM    SIGER.CONSTANCIA_ENTREVISTA a
       INNER JOIN
          CATALOGOS.CAT_PAISES b
       ON A.NACIONALIDAD = b.codigo
where 
    a.nacionalidad =:unaNac and 
    a.nro_documento =:unDoc
 order by fecha_registro desc