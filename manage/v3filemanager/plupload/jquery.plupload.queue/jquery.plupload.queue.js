(function(c){
var d={};

/////////////////////////////////////////////////////
	//Функция транслит
	function translit(str, repl) {
		for (var i = 0; i < str.length; i++) {
			var f = str.charAt(i),
				r = repl[f];
			if (r) {
				str = str.replace(new RegExp(f, 'g'), r);
			}
		}
		return str;
	}
	
	var transl = {
'а':'a','б':'b','в':'v','г':'g',
'д':'d','е':'e','ё':'jo','ж':'zh',
'з':'z','и':'i','й':'j','к':'k',
'л':'l','м':'m','н':'n','о':'o',
'п':'p','р':'r','с':'s','т':'t',
'у':'u','ф':'f','х':'h','ц':'c',
'ч':'ch','ш':'sh','щ':'shh','ъ':'',
'ы':'y','ь':"",'э':'je','ю':'ju',
'я':'ja', ' ':'-'};

function getParameterByName(name)
{
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}
var url=getParameterByName("url");
var spisok_files=getParameterByName("name_file");
n_file=spisok_files.split("|");
var spisok_ext=getParameterByName("ext");
n_ext=spisok_ext.split("|");


/////////////////////////////////////////////////////

	function a(e){
		return plupload.translate(e)||e
	}
	function b(f,e){
		e.contents().each(
			function(g,h){
				h=c(h);
				if(!h.is(".plupload")){
					h.remove()
				}
			}
		);
		
		//Форма добавления файлов
		e.prepend('<div class="plupload_wrapper plupload_scroll"><div id="'+f+'_container" class="plupload_container"><div class="plupload"><div class="plupload_header"><div class="plupload_header_content"><div class="plupload_header_title">'+a("Добавить файл")+'</div><div class="plupload_header_text">'+a("Чтобы изменить имя файла, нужно кликнуть по имени файла, ввести текст и нажать Enter")+'</div></div></div><div class="plupload_content"><div class="plupload_filelist_header"><div class="plupload_file_name">'+a("Имя файла")+'</div><div class="plupload_file_action">&nbsp;</div><div class="plupload_file_status"><span>'+a("Статус")+'</span></div><div class="plupload_file_size">'+a("Размер")+'</div><div class="plupload_clearer">&nbsp;</div></div><ul id="'+f+'_filelist" class="plupload_filelist"></ul><div class="plupload_filelist_footer"><div class="plupload_file_name"><div class="plupload_buttons"><a href="#" class="plupload_button plupload_add">'+a("Добавить файлы")+'</a><a href="#" class="plupload_button plupload_start">'+a("Начать загрузку")+'</a><a href="" class="plupload_button_cancel">'+a("Закрыть")+'</a></div></div><div class="plupload_file_action"></div><div class="plupload_upload_status"></div><div class="plupload_file_status"><span class="plupload_total_status">0%</span></div><div class="plupload_file_size"><span class="plupload_total_file_size">0 b</span></div><div class="plupload_progress"><div class="plupload_progress_container"><div class="plupload_progress_bar"></div></div></div><div class="plupload_clearer">&nbsp;</div></div><div class="footer_footer"></div></div></div></div><input type="hidden" id="'+f+'_count" name="'+f+'_count" value="0" /></div>')
		//////////////////////////////////////////////////////////////////////////////////
		//При нажатии на крестик и esc закрывает форму 
		//plupload_button_cancel
		^$('.plupload_button_cancel').click(function(q){
			var win = window.dialogArguments || opener || parent || top;
			win.location.reload();
		});
		c("#file_add_close").click(function(q){
			location.href="index.html?url="+url;
			//$("#uploader").pluploadQueue().splice();
			//$('#formFile').hide();
		});

		
	}
	c.fn.pluploadQueue=function(e){
		if(e){
			this.each(function(){
				var j,i,k;
				i=c(this);
				k=i.attr("id");
				if(!k){
					k=plupload.guid();
					i.attr("id",k)
				}
				j=new plupload.Uploader(c.extend({dragdrop:true,container:k},e));
				d[k]=j;function h(l){
					var n;
					if(l.status==plupload.DONE){
						n="plupload_done";
						l.hint=('Загружено');
						c(".hide_close").hide();  //убрать крестик
					}
					if(l.status==plupload.FAILED){
						n="plupload_failed";
						c(".hide_close").hide();
				    }
					if(l.status==plupload.QUEUED){
						n="plupload_delete";
						l.hint=('Готов к загрузке');
					}
					if(l.status==plupload.UPLOADING){
						n="plupload_uploading";
						//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//При нажатии ok крестик и esc перезагрузка страницы
						//c("div.footer_footer",i).html("<br><div style='border:1px solid grey'><input type='button' style='height:20px;' value='OK' onclick='location.href=\"index.html?url="+url+"\"'/></div>");
						c("#file_add_close").click(function(q){
							location.href="index.html?url="+url;
						});
						// $(this).keydown(function(eventObject){
						//	if (eventObject.which == 27){
						//		location.href="index.html?url="+url;
						//	}
						//});
						//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					}
					var m=c("#"+l.id).attr("class",n).find("a").css("display","block");
					if(l.hint){
						m.attr("title",l.hint)
					}
				}
				function f(){
					//c("span.plupload_total_status",i).html(j.total.percent+"%");
					//c("div.plupload_progress_bar",i).css("width",j.total.percent+"%");
					c("div.plupload_upload_status",i).html(a('Загружено %d/%d файлов').replace(/%d\/%d/,j.total.uploaded+"/"+j.files.length));
					//c("#uploader_browse",i).remove();
					
				}
				function g(){
					var m=c("ul.plupload_filelist",i).html(""),n=0,l;
					c.each(j.files,function(p,o){
						l="";
						if(o.status==plupload.DONE){
							if(o.target_name){
								l+='<input type="hidden" name="'+k+"_"+n+'_tmpname" value="'+plupload.xmlEncode(o.target_name)+'" />'
							}
							l+='<input type="hidden" name="'+k+"_"+n+'_name" value="'+plupload.xmlEncode(o.name)+'" />';
							l+='<input type="hidden" name="'+k+"_"+n+'_status" value="'+(o.status==plupload.DONE?"done":"failed")+'" />';
							n++;
							c("#"+k+"_count").val(n)
						}
						
						//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//Списки добавляемых файлов
						o.name=o.name.toLowerCase()
						o.name=translit(o.name, transl);
						
						n=o.name;
						r=/^(.+)(\.[^.]+)$/.exec(n); //при клике обрезает расширение
						if(r){n=r[1];
							p=r[2]
						}
						
						//Проверка расширения						
						for (var i = 0; i < n_ext.length; i++){ 
							if('.'+n_ext[i]==p){						
								var err_ext=1;
								break;
							}
						}
						
						if(!err_ext){
							alert("Неразрешённое расширение файла: "+n+p);
							c("#"+o.id).remove();
							j.removeFile(o);
							q.preventDefault()
						}
						
						var name_s=n;
						name_s=name_s.replace(/[^A-Za-z0-9_-]/g,"");
						var name_ext=name_s+p;
						var name_exist=($("#"+name_s+".tit").attr("title"));//Проверка на существование файла с таким же именем
						o.name=name_s+p;

						m.append('<li id="'+o.id+'"><div class="plupload_file_name"><span title="Чтобы изменить имя файла, нужно кликнуть по имени файла, ввести текст и нажать Enter">'+o.name+'</span></div><div style="float:right; margin-left:10px;"><img style="cursor:pointer;" title="Удалить" class="hide_close" id="'+o.id+'file_add_close_name" style="width:16px; height: 16px;" src="picturies/close.png" /></div><div class="plupload_file_action"><a></a></div><div class="plupload_file_status">'+o.percent+'%</div><div class="plupload_file_size">'+plupload.formatSize(o.size)+'</div><div class="plupload_clearer">&nbsp;</div>'+l+'</li>');				
						h(o);

						for (var i = 0; i < n_file.length; i++){ 
							if(n_file[i]==name_ext){
								c("#"+o.id).attr("class","plupload_failed").find("a").css("display","block").attr("title","Файл с таким именем уже существует");
							}
						}
						
						//При клике удаляется один файл из списка
						c("#"+o.id+"file_add_close_name").click(function(q){
							c("#"+o.id).remove();
							j.removeFile(o);
							q.preventDefault()
						});
						
						//o.name=n+p;
						//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					
					});
					c("span.plupload_total_file_size",i).html(plupload.formatSize(j.total.size));
					if(j.total.queued===0){
						c("span.plupload_add_text",i).text(a("Добавить файлы."))
					}else{
						c("span.plupload_add_text",i).text(j.total.queued+" Файлы в очереди.")
					}
					c("a.plupload_start",i).toggleClass("plupload_disabled",j.files.length==(j.total.uploaded+j.total.failed));
					m[0].scrollTop=m[0].scrollHeight;
					f();
					if(!j.files.length&&j.features.dragdrop&&j.settings.dragdrop){
						c("#"+k+"_filelist").append('<li class="plupload_droptext">'+a("Нажмите кнопку \"Добавить файлы\" или перетащите файл с компьютера")+"</li>")
					}
				}
				j.bind("UploadFile",function(l,m){
					c("#"+m.id).addClass("plupload_current_file");
				});
				j.bind("Init",function(l,m){
					b(k,i);
					//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					//Если кликнуть на имя файла то изменяем его
					if(!e.unique_names&&e.rename){
						c("#"+k+"_filelist div.plupload_file_name span",i).live("click",function(s){
							var q=c(s.target),o,r,n,p="";
							o=l.getFile(q.parents("li")[0].id);
							n=o.name;
							r=/^(.+)(\.[^.]+)$/.exec(n); //при клике обрезает расширение
							if(r){n=r[1];
								p=r[2]
							}
							q.hide().after('<input type="text" />');
							q.next().val(n).focus().blur(function(){
								q.show().next().remove()
							}).keydown(function(u){
								var t=c(this);
								
								if(u.keyCode==13){                  //нажать Enter чтобы сохранить измененное имя
										u.preventDefault();
										var name_s=t.val();
										name_s=name_s.toLowerCase()
										name_s=translit(name_s, transl);
										name_s=name_s.replace(/[^A-Za-z0-9_-]/g,"");
										var name_ext=name_s+p;
										
										c("#"+o.id).attr("class","plupload_delete").find("a").css("display","block").attr("title","Готов к загрузке");
										for (var i = 0; i < n_file.length; i++){ 
											if(n_file[i]==name_ext){
												c("#"+o.id).attr("class","plupload_failed").find("a").css("display","block").attr("title","Файл с таким именем уже существует");
											}
										}

										if(!name_s){		
											q.text(o.name);
											t.blur();
										}
										else{
											o.name=name_s+p;
											q.text(o.name);
											t.blur()
										}
								}
								else{
									document.body.onclick = function (e) {     //кликнуть мышкой чтобы сохранить измененное имя
										u.preventDefault();
										var name_s=t.val();
										name_s=name_s.toLowerCase()
										name_s=translit(name_s, transl);
										name_s=name_s.replace(/[^A-Za-z0-9_-]/g,"");
										var name_ext=name_s+p;
										
										c("#"+o.id).attr("class","plupload_delete").find("a").css("display","block").attr("title","Готов к загрузке");
										for (var i = 0; i < n_file.length; i++){ 
											if(n_file[i]==name_ext){
												c("#"+o.id).attr("class","plupload_failed").find("a").css("display","block").attr("title","Файл с таким именем уже существует");
											}
										}								
										
										if(!name_s){		
											q.text(o.name);
											t.blur();
										}
										else{
											o.name=name_s+p;
											q.text(o.name);
											t.blur()
										}
									}
									//При клике удаляется один файл из списка
									c("#"+o.id+"file_add_close_name").click(function(q){
										c("#"+o.id).remove();
										j.removeFile(o);
										q.preventDefault()
									});
									//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								}
							})
						})
					}
					
					c("a.plupload_add",i).attr("id",k+"_browse");
					l.settings.browse_button=k+"_browse";         //Кнопка добавить файлы начинает работать
					if(l.features.dragdrop&&l.settings.dragdrop){
						l.settings.drop_element=k+"_filelist";
						c("#"+k+"_filelist").append('<li class="plupload_droptext">'+a("Нажмите кнопку \"Добавить файлы\" или перетащите файл с компьютера")+"</li>")
					}
					
					//c("#"+k+"_container").attr("title","Using runtime: "+m.runtime);
					c("a.plupload_start",i).click(function(n){
						if(!c(this).hasClass("plupload_disabled")){
							j.start()
						}
						n.preventDefault()
					});
					c("a.plupload_stop",i).click(function(n){
						n.preventDefault();
						j.stop()
					});
					c("a.plupload_start",i).addClass("plupload_disabled")
				});
				j.init();
										
				j.bind("Error",function(l,o){
					var m=o.file,n;
					if(m){
						n=o.message;
						if(o.details){
							n+=" ("+o.details+")"
						}
						if(o.code==plupload.FILE_SIZE_ERROR){
							alert(a("Файл слишком большой: ")+m.name)
						}
						if(o.code==plupload.FILE_EXTENSION_ERROR){
							alert(a("Неразрешённое расширение файла: ")+m.name)
						}
						m.hint=n;c("#"+m.id).attr("class","plupload_failed").find("a").css("display","block").attr("title",n)  // при ошибке
					}
					
				});
				
				j.bind("StateChanged",function(){
					if(j.state===plupload.STARTED){
						//c("li.plupload_delete a,div.plupload_buttons",i).hide();
						//c(".plupload",i).remove();
						
						c("div.plupload_upload_status,a.plupload_stop",i).css("display","block");
						c("a.plupload_stop",i).css("display","block");
						c("div.plupload_upload_status",i).text('Загружено '+j.total.uploaded+'/'+j.files.length+' файлов');

						
						if(e.multiple_queues){
							c("span.plupload_total_status,span.plupload_total_file_size",i).show()
						}
					}
					else{
						g();
						c("a.plupload_stop",i).hide();
						c("a.plupload_delete",i).css("display","block")
					}
				});
				
				j.bind("QueueChanged",g);
				j.bind("FileUploaded",function(l,m){h(m);});
				j.bind("UploadProgress",function(l,m){
					c("#"+m.id+" div.plupload_file_status",i).html(m.percent+"%");
					h(m);
					f();
					if(e.multiple_queues&&j.total.uploaded+j.total.failed==j.files.length){
						c(".plupload_buttons,.plupload_upload_status",i).css("display","inline");
						c(".plupload_start",i).addClass("plupload_disabled");
						c("span.plupload_total_status,span.plupload_total_file_size",i).hide()
					}
				});
				if(e.setup){
					e.setup(j)
				}
			});
			return this
		}
		else{
			return d[c(this[0]).attr("id")]
		}
	}
	
})(jQuery);