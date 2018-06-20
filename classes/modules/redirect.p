################################################################################
@CLASS
redirect
################################################################################
@OPTIONS
locals
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[24.11.2013]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[redirect]
$self.classDescription[Класс модуля перенаправления]
$self.classModuleDescription[Перенаправление]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия 1.0 (17.11.2013):</u></strong>
		<ol>
			<li>Создан класс для модуля "Перенаправление"</li>
		</ol>
	</p>
]
################################################################################
@create[blockId]
################################################################################
@GetClassInfo[]
$result[
	$.version[$self.classVersion]
	$.build_date[$self.classBuildDate]
	$.developer[$self.classDeveloper]
	$.module_name[$self.className]
	$.module_description[$self.classModuleDescription]
	$.history[$self.classHistory]
]
################################################################################
@GetRedirectField[idpage]
$s[^string:sql{SELECT redirect FROM $site:menusTable.name WHERE id=$idpage}[$default[]]]
^if(^s.pos[#]>0){
	$k[^s.match[(.+)\#(.+)]]
	$k1[$k.1]
}{
	$k1[$s]
}
$result[
	$.field[$k1]
	$.anchor[$k.2]
]
################################################################################
@UpdateRedirectField[idpage;field;anchor]
$result(^void:sql{UPDATE $site:menusTable.name SET redirect='${field}^if(def $anchor){#$anchor}' WHERE id='$idpage'})
################################################################################
@Show[blockId]
$redirectField[^string:sql{SELECT redirect FROM $site:menusTable.name WHERE id=$site:currentPage.id}]
$parts[^redirectField.split[^#;lh]]
$uripage[]
^if(def $parts.1){
	$uripage[$parts.1]
}{
	^if(def $parts.0){$uripage[^string:sql{SELECT uri FROM $site:menusTable.name WHERE id=$parts.0}[$.default[]]]}
}
^if(^uripage.pos[http://]>=0){
	$pos[^uripage.pos[http://]]
	$response:refresh[$.value(0)$.url[^untaint{^uripage.right(^eval(^uripage.length[]-$pos))}]]
}{
	$uripage[^uripage.match[\#(.+)][g]]
	^if(def $uripage){$response:refresh[$.value(0)$.url[/${uripage}/^if(def $tmp.1){#$tmp.1}]]}{$response:refresh[$.value(0)$.url[/?p=^untaint{$redirectField}]]}
}
################################################################################