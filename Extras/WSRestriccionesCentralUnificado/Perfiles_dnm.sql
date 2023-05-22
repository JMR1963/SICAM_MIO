select * 
from SIGER.perfiles_dnm
where
    --1    
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad = UPPER(:unaNacionalidad) AND
    sentido =:unSentido and
    pais_doc = UPPER(:unEmisorDoc)
    and flag = 't' 
union all 
select * 
from SIGER.perfiles_dnm
where
    --2
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad = UPPER(:unaNacionalidad) AND
    sentido =:unSentido and        
    pais_doc IS NULL
    and flag = 't' 
union all
select * 
from SIGER.perfiles_dnm
where
    --3
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad = UPPER(:unaNacionalidad) AND
    sentido is null and
    pais_doc = UPPER(:unEmisorDoc)
    and flag = 't' 
union all
select * 
from SIGER.perfiles_dnm
where
    --4
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad = UPPER(:unaNacionalidad) and
    sentido is null and
    pais_doc is null
    and flag = 't' 
union all
select * 
from SIGER.perfiles_dnm
where
    --5    
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad  is null AND
    sentido =UPPER(:unSentido) and
    pais_doc = UPPER(:unEmisorDoc)
    and flag = 't'      
union all
select * 
from SIGER.perfiles_dnm
where
    --6   
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad  is null AND
    sentido =UPPER(:unSentido) and
    pais_doc is null
    and flag = 't'            
union all
select * 
from SIGER.perfiles_dnm
where
    --7  
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad  is null AND
    sentido is null and
    pais_doc  = UPPER(:unEmisorDoc)
    and flag = 't'   
union all
select * 
from SIGER.perfiles_dnm
where
    --8 
    :edad>=edad_min and :edad<=edad_max and
    nacionalidad is null AND
    sentido is null and
    pais_doc  is null
    and flag = 't'   