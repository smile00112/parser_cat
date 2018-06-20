################################################################################
@CLASS
statistic
################################################################################
@auto[]
$self.classVersion[1.0]
$self.classBuildDate[11.04.2014]
$self.classDeveloper[������� ����� ���������]
$self.className[statistic]
$self.classDescription[����� ������ "����������"]
$self.classModuleDescription[���������� �����]
$self.classHistory[
	<p align="justify">
		<strong><u>������ 1.0 (11.04.2014):</u></strong>
		<ol>
			<li>������ ����� ��� ������ "$self.classModuleDescription"</li>
		</ol>
	</p>
]
# ���� � �������
$self.statisticFolder[/$self.className]
# ������� ����
$self.date[^date::now[]]
# ����� ����������
$self.folder[/modules/${self.className}]
# ���� ���������� ��� ����������
$self.file_name[${self.folder}/${self.className}]
# ���������� ����� ����������
$self.file_ext[.txt]
# ���� ����������
$self.file[${self.file_name}${self.file_ext}]
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
^self.ShowTemplate[${self.templateFolder}${self.statisticFolder}/index.html]
^self.ShowstatisticTemplate[$block_id]
################################################################################
@InsertInfo[]
^if(-f $self.file){
	$new_string[$env:REMOTE_ADDR	$env:HTTP_REFERER	$env:HTTP_USER_AGENT	^self.date.sql-string[]^#0A]
	$res[^new_string.save[append;$self.file]]
}{
	$header_string[ip	referer	user_agent	date^#0A]
	$res[^header_string.save[append;$self.file]]
	$new_string[$env:REMOTE_ADDR	$env:HTTP_REFERER	$env:HTTP_USER_AGENT	^self.date.sql-string[]^#0A]
	$res[^new_string.save[append;$self.file]]
}
$fileStat[^file::stat[$self.file]]
$fileSize(^eval($fileStat.size/1024/1024))
^if($fileSize >= 10){
	$res[^file:move[$self.file;${self.file_name}_${self.date.year}-${self.date.month}-${self.date.day}_${self.date.hour}-${self.date.minute}-${self.date.second}${self.file_ext}]]
}
################################################################################