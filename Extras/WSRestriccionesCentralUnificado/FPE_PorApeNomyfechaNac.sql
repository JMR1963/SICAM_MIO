select i.Id,i.FpeId,i.Tagged,i.Gender,i.Disposition,i.Timestamp,i.Created,i.Modified,i.Deleted,
		n.Id,FirstName,n.MiddleName,n.LastName,n.IdentityId,n.DocumentId,
		d.Id,d.Type,d."Number",d.IssueCountry,d.IdentityId,
		dob.Id,dob.DOB,dob.Day,dob.Month,dob.Year,dob.IdentityId,dob.DocumentId,
		c.Id,CountryCode,c.IdentityId,cou.NACIONALIDAD,couDoc.DESCRIPCION AS PAIS_DOCUMENTO
from APISQL.FPE_Identity I 
		inner join APISQL.FPE_Name N on i.id = n.identityiD 
		left join APISQL.FPE_document D on i.id = d.identityiD  and d.Id = n.DocumentId
		left join APISQL.FPE_DOB dob on i.id = dob.identityiD  and NVL(d.Id,-1000) = NVL( dob.DocumentId , -1000)
		left join APISQL.FPE_Citizenship c on i.id = c.identityiD
		left join API_OWNER.CAT_PAISES cou on cou.CODIGO_2 = c.CountryCode
		left join API_OWNER.CAT_PAISES couDoc on couDoc.CODIGO_2 = d.IssueCountry
where FIRSTNAME = :nombre AND LastName = :apellido AND dob.dob = TO_DATE(:fecha, 'DD/MM/YYYY') and I.Deleted <> 1