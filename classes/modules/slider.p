################################################################################
@CLASS
slider
################################################################################
@auto[]
$self.classVersion[1.1]
$self.classBuildDate[24.03.2014]
$self.classDeveloper[������� ����� ���������]
$self.className[slider]
$self.classDescription[����� ������ "�������"]
$self.classModuleDescription[������ "�������"]
$self.classHistory[
 <p align="justify">
  <strong><u>������ 1.1 (24.03.2014):</u></strong>
  <ol>
   <li>������������ ���������� ������ � ������ �����������</li>
   <li>��������� ������� <font color="red">^@GetImage[id]</font>, ������������ ���������� �� �����������.</li>
   <li>��������� ������� <font color="red">^@ShowWidget[id]</font>, ��������� ������ ������� ��������.</li>
  </ol>
 </p>
 <p align="justify">
  <strong><u>������ 1.0 (28.11.2013):</u></strong>
  <ol>
   <li>������ ����� ��� ������ "�������"</li>
  </ol>
 </p>
]
# ������� "slider"
$self.sliderTable[
 $.name[$self.className]
 $.file[${self.className}.table]
]
# ����� ��������
$self.sliderFolder[/slider]
# ���� � ������������
$self.srcPath[/images/${self.className}/src]
$self.bigPath[/images/${self.className}/big]
$self.smallPath[/images/${self.className}/small]
# ������ �����������
$self.imagesHeight[
 $.small(240)
 $.big(600)
]
# ������ �����������
$self.imagesWidth[
 $.small(320)
 $.big(800)
]
# ���� � �������
$self.sliderFolder[/$self.className]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.imagesWidth.small(^textext:GetOptionValue[preview_width;$blockId;$self.imagesWidth.small])
$self.imagesHeight.small(^textext:GetOptionValue[preview_height;$blockId;$self.imagesHeight.small])
$self.imagesWidth.big(^textext:GetOptionValue[width;$blockId;$self.imagesWidth.big])
$self.imagesHeight.big(^textext:GetOptionValue[height;$blockId;$self.imagesHeight.big])
$self.makeResizePreview[^textext:GetOptionValue[make_resize_preview;$blockId]]
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
@GetImage[id]
$result[^table::sql{SELECT id, description, ext, link, sortir FROM $self.sliderTable.name WHERE id='$id' ORDER BY sortir}]
################################################################################
@GetImages[id;params]
^if(!def $id){$id($self.blockId)}
^if(!def $params){$params[^hash::create[]]}
^if(!def $params.order){$params.order[sortir]}
^if(!def $params.orderType){$params.orderType[ASC]}
$result[^table::sql{SELECT id, description, ext, link, sortir FROM $self.sliderTable.name WHERE block_id='$id' ORDER BY $params.order $params.orderType}]
################################################################################
@GetColumnCount[blockId]
$result[^textext:GetOptionValue[countcol;$blockId;2]]
################################################################################
@SaveImageProperty[id;name;value]
$result[^void:sql{UPDATE $self.sliderTable.name SET $name='$value' WHERE id=$id}]
################################################################################
@Show[blockId]
^if(!def $tmpl){$tmpl[index.html]}
^if(!def $blockId){$blockId[$self.blockId]}
^if(-f "${site:templateFolder}${self.sliderFolder}/${tmpl}"){
	^try{
		^use[${site:templateFolder}${self.sliderFolder}/${tmpl}]
		^ShowSliderTemplate[$blockId]
	}{
		^site:Catch[$exception;<h1>������ � ������� ��������!</h1>]
	}
}{<p>���������� ����� ������ "${site:templateFolder}$self.sliderFolder/${tmpl}"</p>}
################################################################################
@ShowWidget[idpage;tmpl]
^if(!def $tmpl){$tmpl[widget.html]}
^if(-f "${site:templateFolder}${self.sliderFolder}/${tmpl}"){
	^try{
		^use[${site:templateFolder}$self.sliderFolder/${tmpl}]
		^ShowWidgetTemplate[$idpage]
	}{
		^site:Catch[$exception;<h1>������ � ������� ��������!</h1>]
	}
}{<p>���������� ����� ������ "${site:templateFolder}$self.sliderFolder/${tmpl}"</p>}
################################################################################
@ShowGalleriesList[idpage;tmpl;link]
^if(!def $tmpl){$tmpl[galleriesList.html]}
^if(-f "${site:templateFolder}${self.sliderFolder}/${tmpl}"){
 ^try{
  ^site:ShowTemplate[${site:templateFolder}$self.sliderFolder/${tmpl}]
  ^site:ShowGalleriesListTemplate[$idpage;$link]
 }{
  ^site:Catch[$exception;<h1>������ � ������� ��������!</h1>]
 }
}{<p>���������� ����� ������ "${site:templateFolder}$self.sliderFolder/${tmpl}"</p>}
################################################################################
@GetMaxSort[blockId]
^if(!def $blockId){$blockId($self.blockId)}
$result(^int:sql{SELECT MAX(sortir) FROM $self.sliderTable.name WHERE block_id=$blockId})
################################################################################
@InsertImage[blockId;description;ext;link;sort]
^if(!def $blockId){$blockId($self.blockId)}
$result[^void:sql{INSERT INTO $self.sliderTable.name (block_id, description, ext, link, sortir) VALUES ($blockId, '$description', '$ext', '$link', '$sort')}]
################################################################################
@DeleteImage[id]
$result[^void:sql{DELETE FROM $self.sliderTable.name WHERE id=$id}]
################################################################################
@GetMaxId[]
$result(^int:sql{SELECT MAX(id) FROM $self.sliderTable.name})
################################################################################
@GetImageExtById[id]
$result[^string:sql{SELECT ext FROM $self.sliderTable.name WHERE id=$id}]
################################################################################