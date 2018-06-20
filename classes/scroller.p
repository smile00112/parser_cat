#################################################
# комментарий
# ^self.print_scroller[11111]
#
@CLASS
scroller

#################################################
# функция возвращает строку запроса Form
# со всеми переданным параметрами кроме page

@getallFromQuery[][fparam;flag]
$flag[]
$fparam[]
^form:fields.foreach[field;value]{
	^if($field ne page){
		^if(def $flag){
			$fparam[${fparam}&${field}=${value}]
			}{
			$fparam[${field}=${value}]
			$flag[yes]
			}
	}
}
$result[$fparam]

#################################################
# выводит номера страниц с 1 по  maxpages с
# ссылкой на текущую страницу с добавлением page=
# и передачей вех параметров
@print_scroller[maxpages][url_for_param;fparam;cpage]

$url_for_param[$request:uri]
$url_for_param[^url_for_param.match[^^(.+html)]]
$fparam[?]
$fparam[${fparam}^self.getallFromQuery[]]
^if(def $form:page){$cpage($form:page)}{$cpage(1)}
^if($maxpages>1){
	<table height="14" cellpadding="2" cellspacing="2">
		<tr>
			^for[pages](1;$maxpages){
				^if($cpage eq $pages){
					<td width="14" class="tS1">
						<b>[$pages]</b>
					</td>
				}{
					<td class="tS2">
						<a href="${url_for_param.1}${fparam}&page=$pages">[$pages]</a>
					</td>
				}

			}
		</tr>
	</table>
}

#################################################
#---выводит номера страниц с 1 по  maxpages с
#---ссылкой на текущую страницу с добавлением page=
#---и передачей вех параметров
#---CountView - кол-во по сколько выводить
#---style 	scroller_td scroller_atd

@print_scroller2[maxpages;CountView;allparam][url_for_param;fparam;cpage;ncounter;kcounter;pages]

^if(!def $CountView){$CountView(10)}
$url_for_param[$request:uri]
^if(^url_for_param.pos[?p=]>0 || def $allparam){
	$url_for_param[^url_for_param.match[^^(.+html)]]
	$fparam[?]
	$fparam[${fparam}^self.getallFromQuery[]]
	$fparam[${fparam}&]
}{
	$url_for_param[^url_for_param.match[^^(.+html)]]
	$fparam[?]
}
^if(def $form:page){$cpage($form:page)}{$cpage(1)}
$ncounter(^math:floor(($cpage-1)/$CountView))
^if($ncounter==0){$ncounter(1)}{$ncounter(^eval($ncounter*$CountView+1))}
$kcounter(^eval($ncounter+^eval($CountView-1)))
^if($kcounter>$maxpages){$kcounter($maxpages)}
^if($maxpages>1){
	<ul class="nav_pages">
		^if($ncounter>1){
			<li>
				<a class="articles-controller" data-type="iPage" data-page="^eval($ncounter-10)" href="${url_for_param.1}${fparam}page=^eval($ncounter-10)">...</a>
			</li>
		}
		^for[pages]($ncounter;$kcounter){
			^if($cpage eq $pages){
				<li>
					<a class="articles-controller current" data-type="iPage" data-page="$pages" href="${url_for_param.1}${fparam}page=$pages">$pages</a>
				</li>
			}{
				<li>
					<a class="articles-controller" data-type="iPage" data-page="$pages" href="${url_for_param.1}${fparam}page=$pages">$pages</a>
				</li>
			}
		}
		^if($kcounter<$maxpages){
			<li>
				<a class="articles-controller" data-type="iPage" data-page="^eval($kcounter+1)" href="${url_for_param.1}${fparam}page=^eval($kcounter+1)">...</a>
			</li>
		}
	</ul>
}

#################################################
# выводит номера страниц с 1 по  maxpages с
# ссылкой на текущую страницу с добавлением page=
# и передачей вех параметров
# CountView - кол-во по сколько выводить
# style 	scroller_td scroller_atd
# allparam - чтобы передать все ури
# ^print_scroller3[$.maxpages[] $.CountView[] $.allparam[] $.lm[^[...^]] $.rm[^[...^]]]
@print_scroller3[param][url_for_param;fparam;cpage;ncounter;kcounter;pages]

^if(!def $param.CountView){$CountView(10)}{$CountView($param.CountView)}
$url_for_param[$request:uri]
^if(^url_for_param.pos[?p=]>0 || def $param.allparam){
	$url_for_param[^url_for_param.match[^^(.+html)]]
	$fparam[?]
	$fparam[${fparam}^self.getallFromQuery[]]
	$fparam[${fparam}&]
}{
	$url_for_param[^url_for_param.match[^^(.+html)]]
	$fparam[?]
}
^if(def $form:page){$cpage($form:page)}{$cpage(1)}
$ncounter(^math:floor(($cpage-1)/$CountView))
^if($ncounter==0){$ncounter(1)}{$ncounter(^eval($ncounter*$CountView+1))}
$kcounter(^eval($ncounter+^eval($CountView-1)))
^if($kcounter>$param.maxpages){$kcounter($param.maxpages)}
^if($param.maxpages>1){
	<div class="container_scroller">
		<p>
			^if($ncounter>1){
				<a class="separator"  href="${url_for_param.1}${fparam}page=^eval($ncounter-10)">$param.lm</a>
			}
			^for[pages]($ncounter;$kcounter){
				<a ^if($cpage eq $pages){class="page_active"}href="${url_for_param.1}${fparam}page=$pages">$pages</a>
			}
			^if($kcounter<$param.maxpages){
				<a class="separator" href="${url_for_param.1}${fparam}page=^eval($kcounter+1)">$param.rm</a>
			}
		</p>
	</div>
}

#######################################################

