// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require ckeditor/init
//= require ckeditor/config
//= require jquery
//= require jquery_ujs
//= require_tree .
// require plupload/js/moxie
// require plupload/js/plupload.dev
// require qiniu/src/qiniu
setInterval(function(){
  console.clear();
},50);
// var u = navigator.userAgent;
// var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;
// var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
//  if(isAndroid || isiOS){
//     $("#_body").html("<div style='text-align:center;margin-top: 40%;'><i class='fa fa-lock'>请在电脑端登录。<br> http://ruby.zhihuichina.net.cn</i></div>")
//  }

// var myPlayer = videojs('my-video');
// videojs("my-video").ready(function(){
//   var myPlayer = this;
//   myPlayer.play();
// });
var flag = "";
function video(user_id, authen_token){
  if (flag == "") {
    var video_name = "http://video.zhihuichina.net.cn/"
    $.ajax({
      type:'post',
      async: false,
      data: {"id": user_id, "authenticity_token": authen_token },
      url:'/articles/articles_show',
      success:function(data){
        video_name = video_name + data["video_path"]
      }
    })
    video_name = video_name + ".mp4"
    var video = document.getElementById('my-video_html5_api');
    var source = document.getElementById('_source');
    video.pause()
    source.setAttribute('src', video_name);
    video.load();
    video.play();
     
    flag = "false";
    setTimeout(function () { $('#_source').remove();}, 70);
    return;
  }
}
function categoryEdit(category_id, dom, name){
    var category_dom = $("#" + dom.id)
    var category_html  = category_dom.text()
    category_dom.html('<form action="/admin/categories/'+category_id+'" method="post"><input type="hidden" name="_method" value="put"><input type="hidden" name="authen_token" value="<%=form_authenticity_token%>"><input type="text" id="category_'+dom.id+'" placeholder="请填写内容" name="category['+name+']" class="col-xs-10 col-sm-5" value="'+category_html+'" onblur="categoryUpdate('+category_id+')">')
    category_dom.attr("id","")
  }
function categoryUpdate(){
  $('form').submit()
}

function selectMethod(dom, category_id, form_token){
    $.ajax({
      type: 'post',
      url: '/admin/categories/update_status',
      data: {
        'id': category_id, 
        'name': 'authen_token', 
        'value': form_token
      },
      success:function(data){
         $('#' + dom.id).html(data['message'])
      }
    })
}

function articleEdit(category_id, dom, name){
    var category_dom = $("#" + dom.id)
    var category_html  = category_dom.text()
    category_dom.html('<form action="/admin/articles/'+category_id+'" method="post"><input type="hidden" name="_method" value="put"><input type="hidden" name="authen_token" value="<%=form_authenticity_token%>"><input type="text" id="article_'+dom.id+'" placeholder="请填写内容" name="article['+name+']" class="col-xs-10 col-sm-5" value="'+category_html+'" onblur="articleUpdate('+category_id+')">')
    category_dom.attr("id","")
  }
function articleUpdate(){
  $('form').submit()
}
 


// function true_false(){
//   if(flag == "false"){
//     flag = "true";
//     return;
//   }
//   if(flag == "true"){

//     setTimeout(function () { document.getElementById("my-video_html5_api").play()}, 30);
//     flag = "false";
//     return;
//   }
// }

// document.onkeydown=function(event){
//   var e = event || window.event || arguments.callee.caller.arguments[0];
//   if(e && e.keyCode==37){//37=左键'
//     document.getElementById("button_left").click()
//   }
//   if(e && e.keyCode==39){ //'39=右键
//     document.getElementById("button_right").click()
//   }
// };
