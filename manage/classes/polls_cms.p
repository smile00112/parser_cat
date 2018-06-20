################################################################################
@CLASS
polls_cms
################################################################################
@USE
polls.p
################################################################################
@BASE
polls
################################################################################
@auto[]
$self.modulePath[$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.pollsTable.name]
	]
	$.superfluous[
		$.1[]
	]
]
$self.moduleOptions[
	$.main[
	]
	$.rename[
	]
]
################################################################################
@create[]
################################################################################
# ������ ����� �������
@CreateElement[fields;params]
^try{
	^if(def $fields.name && def $fields.type){
		^if(def $fields.parent){$parent(^fields.parent.int(0))}{$parent(0)}
		$sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.pollsTable.name WHERE parent=$parent}+10))
		$query_fields[sortir, create_date]
		$query_values[$sortir, NOW()]
		^fields.foreach[key;value]{
			^if($value ne ''){
				$query_fields[${query_fields}, $key]
				$query_values[${query_values}, '$value']
			}
		}
		^void:sql{INSERT INTO $self.pollsTable.name ($query_fields) VALUES ($query_values)}
	# ������ ������ � ���
			$params[
				$.unit_id[]
				$.module[$self.className]
				$.module_id[]
				$.method[CreateElement]
				$.description[���������� ^self.elementTypes.[$fields.type].titleRE.lower[]]
			]
			$res[^cms:InsertIntoLog[$params]]
		$answer[^hash::create[
			$.error(false)
			$.text[$self.elementTypes.[$fields.type].title ��������]
		]]
	}{
		$answer[^hash::create[
			$.error(true)
			$.text[������������ ���������� ��� �������� ^self.elementTypes.[$fields.type].titleRE.lower[]]
		]]
	}
}{
	$exception.handled(true)
	$answer[^hash::create[
		$.error(true)
		$.text[������ ���������� �������]
	]]
}
$result[$answer]
################################################################################
@DeleteElement[element_id][element_id;element;childs]
$answer[^hash::create[]]
^if(def $element_id){
	^try{
		$element[^table::sql{SELECT name, type FROM $self.pollsTable.name WHERE id=$element_id}]
		^if(def $element){
			$childs[^table::sql{SELECT id FROM $self.pollsTable.name WHERE parent=$element_id}]
			^if(def $childs){
				^childs.menu{
					$res[^self.DeleteElement[$childs.id]]
				}
			}
			$res[^void:sql{DELETE FROM $self.pollsTable.name WHERE id=$element_id}]
# ������ ������ � ���
			$params[
				$.unit_id[$element_id]
				$.module[$self.className]
				$.module_id[]
				$.method[DeleteImage]
				$.description[�������� ^self.elementTypes.[$element.type].titleRE.lower[]]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[^if($element.type == 1){������ �����}{^if(def $childs){����� � ��� ��� ������� �������}{����� �����}}]
		}{
			$answer.error(true)
			$answer.text[������� � ID=$element_id �� ������]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[������ ���������� �������]
	}
}{
	$answer.error(true)
	$answer.text[�� ������� ID ��������]
}
$result[$answer]
################################################################################
@SaveProperty[id;name;value]
$answer[$.error(false)]
^if(def $id && def $name){
	^try{
		^switch[$name]{
			^case[sortir]{
				$parent[^string:sql{SELECT parent FROM $self.pollsTable.name WHERE id=$id}]
				^if(!^int:sql{SELECT 1 FROM $self.pollsTable.name WHERE $name=$value AND parent=$parent}[$.default(0)]){
					$res[^void:sql{UPDATE $self.pollsTable.name SET $name='$value' WHERE id=$id}]
				}{
					$answer.error(true)
					$answer.text[��� �������� ��� ������������!]
				}
			}
			^case[DEFAULT]{
				$res[^void:sql{UPDATE $self.pollsTable.name SET $name='$value' WHERE id=$id}]
			}
		}
		^if(!$answer.error){
# ������ ������ � ���
			$params[
				$.unit_id[$id]
				$.module[$self.className]
				$.module_id[]
				$.method[SaveProperty]
				$.description[���� "$name" ��������]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.text[�������� ���������]
		}
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[������ ���������� �������]
	}
}{
	$answer.error(true)
	$answer.text[�������� �� ��� ���������]
}
$result[$answer]
################################################################################
@SetElementVisible[id]
$answer[^hash::create[]]
^if(def $id){
	^try{
		$visible(^int:sql{SELECT visible FROM $self.pollsTable.name WHERE id=$id})
		^if($visible==1){$visible(0)}{$visible(1)}
		$res[^void:sql{UPDATE $self.pollsTable.name SET visible=$visible WHERE id=$id}]
# ������ ������ � ���
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[]
			$.method[SetImageVisible]
			$.description[^if($visible){�����������}{ �������} ��������]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.visible($visible)
		$answer.error(false)
		$answer.text[�������^if($visible){ ��������}{ �����}]
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[������ ���������� �������]
	}
}{
	$answer.error(true)
	$answer.text[�� ������� ID ��������]
}
$result[$answer]
################################################################################