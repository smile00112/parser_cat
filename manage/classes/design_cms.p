################################################################################
@CLASS
design_cms
################################################################################
@auto[]
$self.classVersion[2.0]
$self.classBuildDate[07.12.2014]
$self.classDeveloper[������� ����� ���������]
$self.className[design]
$self.classDescription[����� ������ "��������� ��������"]
$self.classModuleDescription[��������� ��������]
$self.classHistory[
	<p align="justify">
		<strong><u>������ $self.classVersion ($self.classBuildDate):</u></strong>
		<ol>
			<li>������ ��������� ��� <font color="red">CMS ver. 2.22</font>.</li>
			<li>��������� ������� <font color="red">^@GetTemplateProperties</font>[template^;params], ������������ ������� �� ����� ���������� �������.</li>
			<li>��������� ������� <font color="red">^@GetProperty</font>[id], ������������ ���������� � �������� �� ��� <strong>id</strong>.</li>
			<li>��������� ������� <font color="red">^@CreateProperty</font>[params], ����������� ��������.</li>
			<li>��������� ������� <font color="red">^@DeleteProperty</font>[id], ������� ������� �������� <strong>id</strong>.</li>
			<li>��������� ������� <font color="red">^@ReloadImage</font>[id^;image], ������� �������� ����������� <strong>image</strong> ��� �������� <strong>id</strong>.</li>
			<li>��������� ������� <font color="red">^@ReloadDefaultImage</font>[id], ������� �������� ������� ����������� �������� <strong>id</strong> ������������ �� ���������.</li>
			<li>��������� ������� <font color="red">^@UpdatePropertyField</font>[id^;field^;value], ������� ����������� �������� <strong>value</strong> ���� <strong>field</strong> �������� <strong>id</strong>.</li>
		</ol>
	</p>
	<p align="justify">
		<strong><u>������ 1.0 (26.12.2014):</u></strong>
		<ol>
			<li>������ ����� ��� ������ "��������� ��������"</li>
		</ol>
	</p>
]
# ���������� �� ���������
$self.order[sortir]
# ��� ���������� �� ���������
$self.orderType[ASC]
# ������� "��������� ��������"
$self.templateSettingsTable[
	$.name[template_settings]
	$.file[template_settings.table]
]
# ���� � ������
$self.modulePath[options/$self.className]
# ��� ������ ������
$self.moduleTables[
	$.necessary[
		$.1[$self.templateSettingsTable.name]
	]
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
@GetPropertyValue[template;property]
^try{
	$result[^string:sql{SELECT value FROM $self.templateSettingsTable.name WHERE property="$property" AND template="$template"}[$.default[]]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetPropertyDefaultValue[template;property]
^try{
	$result[^string:sql{SELECT default_value FROM $self.templateSettingsTable.name WHERE property="$property" AND template="$template"}[$.default[]]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@GetPropertyComment[template;property]
^try{
	$result[^string:sql{SELECT comment FROM $self.templateSettingsTable.name WHERE property="$property" AND template="$template"}[$.default[]]]
}{
	$exception.handled(true)
	$result[]
}
################################################################################
@SaveProperty[template;property;value]
^if(def $template && def $property){
	^try{
		^void:sql{UPDATE $self.templateSettingsTable.name SET value="$value" WHERE property="$property" AND template="$template"}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@GetTemplateProperties[template;params]
^if(def $template){
	^try{
		^if(def $params.order){$order[$params.order]}{$order[$self.order]}
		^if(def $params.orderType){$params.orderType}{$orderType[$self.orderType]}
		$result[^table::sql{
			SELECT id, template, name, value, default_value, type_field, comment, sortir
			FROM $self.templateSettingsTable.name
			WHERE template="$template"
			ORDER BY $order $orderType
		}]
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@GetProperty[id]
^if(def $id){
	^try{
		$result[^table::sql{SELECT id, template, name, value, default_value, type_field, comment, sortir FROM $self.templateSettingsTable.name WHERE id=$id}]
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@CreateProperty[params]
^if(def $params.template && def $params.type && def $params.name && def $params.value){
	^try{
		^if(!def $params.sortir){
			$params.sortir(^eval(^int:sql{SELECT MAX(sortir) FROM $self.templateSettingsTable.name}+10))
		}
		^void:sql{
			INSERT INTO $self.templateSettingsTable.name
			(template, name, value, default_value, type_field, comment, sortir)
			VALUES
			("$params.template", "$params.name", "$params.value", "$params.default_value", $params.type, "$params.comment", $params.sortir)
		}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@DeleteProperty[id]
^if(def $id){
	^try{
		^void:sql{DELETE FROM $self.templateSettingsTable.name WHERE id=$id}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@ReloadImage[id;image]
^if(def $id && def $image){
	^try{
		$property[^self.GetProperty[$id]]
		$imagePath[${site:templatesFolder}/${property.template}${property.value}]
		$res[^file:delete[$imagePath;$.keep-empty-dirs(true)$.exception(false)]]
		$res(^image.save[binary;$imagePath])
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@ReloadDefaultImage[id]
^if(def $id){
	^try{
		$property[^self.GetProperty[$id]]
		$defaultImagePath[${site:templatesFolder}/${property.template}/default${property.value}]
		$imagePath[${site:templatesFolder}/${property.template}${property.value}]
		$res[^file:delete[$imagePath;$.keep-empty-dirs(true)$.exception(false)]]
		^if(-f $defaultImagePath){
			$res[^file:copy[$defaultImagePath;$imagePath]]
		}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################
@UpdatePropertyField[id;field;value]
^if(def $id && def $field){
	^try{
		^void:sql{UPDATE $self.templateSettingsTable.name SET ${field}="$value" WHERE id=$id}
		$result(1)
	}{
		$exception.handled(true)
		$result(0)
	}
}{
	$result(-1)
}
################################################################################