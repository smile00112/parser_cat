################################################################################
@CLASS
structure
################################################################################
@auto[]
#------------------------------ ����� SQL-������ -------------------------------
$self.pagesTable[
	$.name[menus]
	$.file[menus.table]
]
$self.pageBlocksTable[
	$.name[text_ext]
	$.file[text_ext.table]
]
#---------------------------- ���������� � ������ ------------------------------
$self.className[structure]
$self.classVersion(1.0)
$self.classBuildDate[05.06.2016]
$self.classDeveloper[������� ����� ���������]
$self.classDescription[����� ������ '���������']
$self.classModuleDescription[����� ������ '���������']
$self.classHistory[
<p align="justify">
	<strong><u>������ $self.classVersion ($self.classBuildDate):</u></strong>
	<ol>
		<li>������ ����� ��� ������ �� ���������� �����.</li>
	</ol>
</p>
]
################################################################################
@create[]
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
@GetPages[params]
^if(!def $params){$params[^hash::create[]]}
^try{
	$result[^table::sql{
		SELECT id, name, uri, sortir, visible
		FROM $self.pagesTable.name
		WHERE 1=1
		^if(def $params.page_id){ AND id IN ($params.page_id)}
	}]
}{
	$exception.handled(true)
	$result[
		$.error(true)
		$.text[������ ����������]
		$.exception[$exception]
	]
}
################################################################################
# ������������ � ������� @GenerateHtaccessRules[] ������� ������, ��� ����������� ������ ���� ������� ������ name
@GetPagesByBlockName[name]
$result[
	^table::sql{
		SELECT id, uri
		FROM $self.pagesTable.name
		WHERE
			id IN (SELECT idpage FROM $self.pageBlocksTable.name WHERE pref_block='$name')
			AND (id_menu='a' OR id_menu='b')
	}
]
################################################################################
# ������������ � ������� @GenerateHtaccessRules[] ������� ������, ��� ����������� ������ ���� ������ ������ name
@GetBlocksByBlockName[name]
$result[^table::sql{SELECT id, idpage AS page_id, name AS block_name FROM $self.pageBlocksTable.name WHERE pref_block='$name'}]
################################################################################