################################################################################
@CLASS
xml
################################################################################
@OPTIONS
locals
################################################################################
@create[]
$self.sitesTable[business_sites]
$self.domainsTable[business_domains]
$self.registrarsTable[business_registrars]
################################################################################
@ClassInfo[]
$result[
 $.classVersion[1.0]
 $.classBuildDate[23.07.2013]
 $.classDeveloper[Баранов Вадим Сергеевич]
 $.className[xml]
 $.classDescription[Экспорт данных в формате xml]
]
################################################################################
@GetTableFields[table]
$result[^table::sql{SHOW COLUMNS FROM $table}]
################################################################################
@GetTableValues[table]
$result[^table::sql{SELECT * FROM $table}]
################################################################################
@GetXMLTable[tableName]
$tableNameLower[^tableName.lower[]]
$data[
 $.fields[^self.GetTableFields[$self.[${tableNameLower}Table]]]
 $.values[^self.GetTableValues[$self.[${tableNameLower}Table]]]
]
<?xml version="1.0" encoding="windows-1251" ?>
 ^if(def $data.values){
 <$tableName>
  ^data.values.menu{
  <Field>
   ^data.fields.menu{
   <$data.fields.Field>$data.values.[$data.fields.Field]</$data.fields.Field>
   }
  </Field>
  }
 </$tableName>
 }
################################################################################