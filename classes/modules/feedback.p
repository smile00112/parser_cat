################################################################################
@CLASS
feedback
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[08.06.2014]
$self.classDeveloper[������� ����� ���������]
$self.className[feedback]
$self.classDescription[����� ������ �������� �����]
$self.classModuleDescription[�������� �����]
$self.classHistory[
 <p align="justify">
  <strong><u>������ 1.0 (08.06.2014):</u></strong>
  <ol>
   <li>������ ����� ��� ������ "�������� �����"</li>
  </ol>
 </p>
]
# ���� � �������
$self.feedbackFolder[/$self.className]
################################################################################
@create[blockId]
$self.blockId($blockId)
$self.pageId(^textext:GetPageIdByBlockId[$self.blockId])
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
^if(!def $block_id){$block_id[$self.blockId]}
^site:ShowTemplate[${site:templateFolder}${self.feedbackFolder}/index.html]
^site:ShowFeedbackTemplate[$block_id]
################################################################################