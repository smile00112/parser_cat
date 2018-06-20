1) Обновить класс site.p (либо добавить в него функцию @GetBlockFlag[])
2) Скопировать в папку /manage папку /api/info

################################################################################
@GetBlockFlag[]
$result(^connect[$self.connectString]{^int:sql{SELECT value FROM $self.settingsTable.name WHERE name='block'}[$.default(0)]})
################################################################################