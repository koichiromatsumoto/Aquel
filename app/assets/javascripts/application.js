// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


// ユーザ情報詳細画面
$(function(){
  $('#modal-open').click(function(){

    $('body').append('<div class="js-modal-overlay"></div>');
    $('.js-modal-overlay').fadeIn('slow');
    var modal = '#' + $(this).attr('data-target');
    modalResize();
    $(modal).fadeIn('slow');

    $('.js-modal-overlay, #modal-close').off().click(function(){
      $('.modal-text').fadeOut('slow');
      $('.js-modal-overlay').fadeOut('slow',function(){
        $('.js-modal-overlay').remove();
      });
    });

    $(window).on('resize', function(){
      modalResize();
    });

    function modalResize(){
      var w = $(window).width();
      var h = $(window).height();

      var x = (w - $(modal).outerWidth(true)) / 2;
      var y = (h - $(modal).outerHeight(true)) / 2;

      $(modal).css({'left': x + 'px','top': y + 'px'});
    }

    $('.modal-switch').click(function(){

      $(this).parents('.modal-text').fadeOut();
      var modal = '#' + $(this).attr('data-target');

      function modalResize(){
          var w = $(window).width();
          var h = $(window).height();

          var x = (w - $(modal).outerWidth(true)) / 2;
          var y = (h - $(modal).outerHeight(true)) / 2;

          $(modal).css({'left': x + 'px','top': y + 'px'});
      }

      modalResize();
      $(modal).fadeIn();

      $(window).on('resize', function(){
          modalResize();
      });
    });

  });
});

// ユーザ編集画面のイメージプレビュー
$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#user_img_prev').attr({
          src: e.target.result,
          width: "150px",
          height: "150px"});
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $(".select-profile-image").change(function(){
    $('#user_img_prev').removeClass('hidden');
    $('.modal-img-user').hide();
    readURL(this);
    $('.js-modal-overlay, #modal-close').click(function(){
      $('#user_img_prev').addClass('hidden');
      $('.modal-img-user').show();
    });
  });
});

// 投稿一覧画面の新着orトレンド

$(function(){
  $('#tab-contents .tab[id != "tab1"]').hide();
  $('#tab-menu a, .follow a').on('click', function() {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    if ($(this).attr("href") == ("#tab2")){
      $(".tab2 a").addClass("active");
    } else if($(this).attr("href") == ("#tab3")){
      $(".tab3 a").addClass("active");
    };
    $($(this).attr("href")).show();
    return false;
  });
});

// kaminariとタブの共存用

$(function(){
  $('#page').on('click', function() {
    if ($(this).attr("param_name") == ('late_page')){
      $(".tab2").hide();
    } else if($(this).attr("param_name") == ("trend_page")){
      $(".tab1").hide();
    };
  });
});

// 新規投稿ページのイメージプレビュー
$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#post_img_prev').attr({
          src: e.target.result,
          width: "95%"});
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#post_img").change(function(){
    $('#post_img_prev').removeClass('hidden');
    readURL(this);
  });
});