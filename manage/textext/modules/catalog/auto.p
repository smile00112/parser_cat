################################################################################
@auto[]
^if(def $form:idblock){$idblock($form:idblock)}{$idblock($form:id)}
^connect[$site:connectString]{
	^use[catalog_cms.p;$.replace(true)]
	$this[^catalog_cms::create[$idblock]]
	^cms.SetCurrentModule[$this.className]
}
$cms.languageVars[^hash::create[^loadTexts[]]]
################################################################################
@loadTexts[]
$result[
	$._diagnostics[
		$.link[
			$.header[Выбор родителя для ELEMENT]
			$.notFoundName[вложенных ELEMENTS раздела с ID=_ID]
		]
		$.redirect[
			$.header[Перенаправление для ELEMENT]
			$.notFoundName[вложенных ELEMENTS раздела с ID=_ID]
		]
	]
	$.index[
		$.header[]
	]
]
################################################################################