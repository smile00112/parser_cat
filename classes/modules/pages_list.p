################################################################################
@CLASS
pages_list
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[18.12.2013]
$self.classDeveloper[������� ����� ���������]
$self.className[pages_list]
$self.classDescription[����� ������ ������ �������]
$self.classModuleDescription[������ �������]
$self.classHistory[
 <p align="justify">
  <strong><u>������ 1.0 (18.12.2013):</u></strong>
  <ol>
   <li>������ ����� ��� ������ "$self.classModuleDescription"</li>
  </ol>
 </p>
]
# ���� � �������
$self.plFolder[/$self.className]
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
@Show[block_id]
^site:ShowTemplate[${site:templateFolder}${self.plFolder}/index.html]
^site:ShowPlTemplate[$block_id]
################################################################################