################################################################################
@CLASS
parser
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[20.03.2015]
$self.classDeveloper[������� ����� ���������]
$self.className[parser]
$self.classDescription[��� parser]
$self.classModuleDescription[��� parser]
$self.classHistory[
	<p align="justify">
		<strong><u>������ $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>������ ����� ${self.className}.</li>
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