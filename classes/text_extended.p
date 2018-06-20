################################################################################
@CLASS
text_extended
################################################################################
@init[idpage]
^if($idpage eq $site:currentPage.id){
	$self.blocks[^table::create[$site:currentPage.blocks]]
}{
	$self.blocks[^textext:GetPageBlocks[$idpage]]
}
################################################################################
@show[params]
^if(!def $params){$params[^hash::create[]]}
^if(^self.blocks.count[]>0){
# Если есть блок авторизации
	^if(^self.blocks.locate[name;auth]){
		^if($site:user.isRegUser){
			$show(true)
		}{
			^site:ShowTemplate[${site:templateFolder}/auth/authModule.html]
			$show(false)
		}
	}{
		$show(true)
	}
	^if($show){
		^if(!def $params.only){
			^if(def $form:idg && ^self.blocks.locate[name;gallery]){$params.only[gallery]}
			^if(def $form:id && ^self.blocks.locate[name;news]){$params.only[news]}
			^if(def $form:idc && ^self.blocks.locate[name;catalog]){$params.only[catalog]}
		}
		^self.blocks.menu{
			^if(def $params.only){
				^if($params.only eq $self.blocks.name){$blockName[$self.blocks.name]}{$blockName[not_show]}
			}{
				$blockName[$self.blocks.name]
			}
			^switch[$blockName]{
				^case[text]{^self.block_text[$self.blocks.id]}
				^case[forma]{^self.block_forma[$self.blocks.id;$self.blocks.name]}
				^case[html]{^self.block_html[$self.blocks.id]}
				^case[auth;not_show]{}
				^case[DEFAULT]{
					^switch[$self.blocks.name]{
						^case[videogallery]{$className[video]}
						^case[DEFAULT]{$className[$self.blocks.name]}
					}
					$block[^process[$caller.self]{^taint[as-is][^^${className}::create[$self.blocks.id]]}]
					^if(def $params){
						^block.Show[$params]
					}{
						^block.Show[]
					}
				}
			}
		}
	}
}
################################################################################
@block_html[id_te]
$tableres[^table::sql{select * from te_text where id='$id_te'}]
^process[$caller.self]{^untaint{$tableres.content}}
################################################################################
@block_text[id_te]
$content[^string:sql{SELECT content FROM te_text WHERE id='$id_te'}[$.default[]]]
^if(-f "${site:templateFolder}/text/index.html"){
	^site:ShowTemplate[${site:templateFolder}/text/index.html]
	^try{^site:ShowTextTemplate[^process[$caller.self]{^untaint{$content}}]}{^site:Catch[$exception;<h1>Ошибка загрузки шаблона!</h1>]}
}{
	^process[$caller.self]{^untaint{$content}}
}
#########################################################################