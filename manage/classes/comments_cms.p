################################################################################
@CLASS
comments_cms
################################################################################
@USE
comments.p
################################################################################
@BASE
comments
################################################################################
@auto[]
$self.modulePath[textext/modules/$self.className]
$self.moduleTables[
	$.necessary[
		$.1[$self.commentsTable.name]
	]
	$.superfluous[
		$.1[]
	]
]
$self.moduleOptions[
	$.main[
		$.per_page[
			$.caption[���-�� ������������ �� ��������]
			$.value[$self.perPage]
			$.type_field(0)
		]
	]
	$.rename[
		$.preview_width[]
		$.width[]
	]
]
################################################################################
@create[]
################################################################################
# �����������
################################################################################
@DeleteComment[comment_id][comment_id;comment;childs]
$answer[^hash::create[]]
^if(def $comment_id){
	^try{
		$comment[^table::sql{SELECT block_id, unit_id FROM $self.commentsTable.name WHERE id=$comment_id}]
		^if(def $comment){
			$childs[^table::sql{SELECT id FROM $self.commentsTable.name WHERE parent=$comment_id}]
			^if(def $childs){
				^childs.menu{
					$res[^self.DeleteComment[$childs.id]]
				}
			}
			$res[^void:sql{DELETE FROM $self.commentsTable.name WHERE id=$comment_id}]
	# ������ ������ � ���
			$params[
				$.unit_id[$comment_id]
				$.module[$self.className]
				$.module_id[$comment.block_id]
				$.method[DeleteComment]
				$.description[�������� �����������^if($comment.unit_id > 0){ (unit_id = $comment.unit_id)}]
			]
			$res[^cms:InsertIntoLog[$params]]
			$answer.error(false)
			$answer.text[^if(def $childs){����������� � ��� ��� ���������� ����������� �������}{����������� �����}]
		}{
			$answer.error(true)
			$answer.text[������� � ID=$comment_id �� ������]
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
@SetCommentVisible[id]
$answer[^hash::create[]]
^if(def $id){
	^try{
		$comment[^table::sql{SELECT block_id, unit_id, visible FROM $self.commentsTable.name WHERE id=$id}]
		^if($comment.visible==1){$visible(0)}{$visible(1)}
		$res[^void:sql{UPDATE $self.commentsTable.name SET visible=$visible WHERE id=$id}]
# ������ ������ � ���
		$params[
			$.unit_id[$id]
			$.module[$self.className]
			$.module_id[$comment.block_id]
			$.method[SetCommentVisible]
			$.description[^if($visible){�����������}{ �������} �����������]
		]
		$res[^cms:InsertIntoLog[$params]]
		$answer.visible($visible)
		$answer.error(false)
		$answer.text[�����������^if($visible){ ��������}{ �����}]
	}{
		$exception.handled(true)
		$answer.error(true)
		$answer.text[������ ���������� �������]
	}
}{
	$answer.error(true)
	$answer.text[�� ������� ID �����������]
}
$result[$answer]
################################################################################