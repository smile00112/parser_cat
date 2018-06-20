################################################################################
@auto[]
# Создаём объект класса cms.p, с которым в дальнейшем будем работать
$cms[^cms::create[]]
################################################################################
# Оператор @include[]. В случае отсутствия файла НЕ ВЫЗЫВАЕТ фатальной ошибки, а только выводит предупреждение.
@include[file][_fd]
^if(-f $file){
	$_fd[^file::load[text;$file]]
	$result[^process[$caller.self]{^taint[as-is][$_fd.text]}[$.file[$file]]]
}{
	$result[^process[$caller.self]{<br><font color="red"><b>Warning! Оператор ^^#5einclude[$file] не нашел файл!</b></font><br>}]
}
################################################################################
# Используется для загрузки js скриптов в (document).ready шаблона CMS
@head[]
################################################################################
# Используется для загрузки css и js файлов в head шаблона CMS
@head_global[]
################################################################################
@main[]
^if(!def $cms.cmsUser){
	^if( !($cms.currentFolder eq $cms.cmsFolder && $cms.currentFolder eq index.html) ){
		$response:refresh[
			$.value(0)
			$.url[${cms.cmsFolder}/]
		]
	}
}
#	Инициализируем Хэш с текстовыми значениями (для многоязычности)
^if(def $cms.languageVars){
	^if(^cms.languageVars.contains[_^cms.currentFolder.trim[left;/]]){
		$cms.languageVars[^hash::create[$cms.languageVars.[_^cms.currentFolder.trim[left;/]].[^file:justname[$cms.currentFile]]]]
	}{
		$cms.languageVars[^hash::create[$cms.languageVars.[^file:justname[$cms.currentFile]]]]
	}
}
^inMain[]
################################################################################
# Загружаем шаблон
@inMain[]
$result[^include[${cms.templateFolder}/index.html]]
################################################################################
# Функция сохранения изменений
@make_rewrite[]
$result[^cms.HtaccessGenerate[]]
################################################################################