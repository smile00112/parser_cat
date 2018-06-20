################################################################################
@CLASS
parser
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[20.03.2015]
$self.classDeveloper[Баранов Вадим Сергеевич]
$self.className[parser]
$self.classDescription[Код parser]
$self.classModuleDescription[Код parser]
$self.classHistory[
	<p align="justify">
		<strong><u>Версия $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>Создан класс ${self.className}.</li>
		</ol>
	</p>
]
################################################################################
@GetClassInfo[]
$result[
	$.className[$self.className]
	$.classVersion[$self.classVersion]
	$.version[$self.classVersion]
	$.classBuildDate[$self.classBuildDate]
	$.build_date[$self.classBuildDate]
	$.classDeveloper[$self.classDeveloper]
	$.classDescription[$self.classVersion]
	$.classHistory[$self.classVersion]
]
################################################################################
@create[blockId]
$self.blockId($blockId)
################################################################################
@Show[]
^process[$caller.self]{^taint[as-is][^textext:GetBlockContent[$self.blockId]]}
################################################################################