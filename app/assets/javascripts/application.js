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
//= require_tree .


// ユーザ情報詳細画面
$(function(){
    // 「.modal-open」をクリック
    $('#modal-open').click(function(){
        // オーバーレイ用の要素を追加
        $('body').append('<div class="js-modal-overlay"></div>');
        // オーバーレイをフェードイン
        $('.js-modal-overlay').fadeIn('slow');

        // モーダルコンテンツのIDを取得
        var modal = '#' + $(this).attr('data-target');
        // モーダルコンテンツの表示位置を設定
        modalResize();
         // モーダルコンテンツフェードイン
        $(modal).fadeIn('slow');

        // 「.modal-overlay」あるいは「.modal-close」をクリック
        $('.js-modal-overlay, #modal-close').off().click(function(){
            // モーダルコンテンツとオーバーレイをフェードアウト
            $('.modal-text').fadeOut('slow');
            $('.js-modal-overlay').fadeOut('slow',function(){
                // オーバーレイを削除
                $('.js-modal-overlay').remove();
            });
        });

        // リサイズしたら表示位置を再取得
        $(window).on('resize', function(){
            modalResize();
        });

        // モーダルコンテンツの表示位置を設定する関数
        function modalResize(){
            // ウィンドウの横幅、高さを取得
            var w = $(window).width();
            var h = $(window).height();

            // モーダルコンテンツの表示位置を取得
            var x = (w - $(modal).outerWidth(true)) / 2;
            var y = (h - $(modal).outerHeight(true)) / 2;

            // モーダルコンテンツの表示位置を設定
            $(modal).css({'left': x + 'px','top': y + 'px'});
        }

        // .modal_switchを押すとモーダルを切り替える
        $('.modal-switch').click(function(){

          // 押された.modal_switchの親要素の.modal_boxをフェードアウトさせる
          $(this).parents('.modal-text').fadeOut();

          // 押された.modal_switchのdata-targetの内容をIDにしてmodalに代入
          var modal = '#' + $(this).attr('data-target');

          // モーダルをウィンドウの中央に配置する
          function modalResize(){
              var w = $(window).width();
              var h = $(window).height();

              var x = (w - $(modal).outerWidth(true)) / 2;
              var y = (h - $(modal).outerHeight(true)) / 2;

              $(modal).css({'left': x + 'px','top': y + 'px'});
          }

          // modalResizeを実行
          modalResize();

          $(modal).fadeIn();

          // ウィンドウがリサイズされたらモーダルの位置を再計算する
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
    $('.late-posts').show();
    $('.trend-posts').hide();

    $('.late').click(function(){
      $('.late-posts').show();
      $('.trend-posts').hide();
    });

    $('.trend').click(function(){
      $('.trend-posts').show();
      $('.late-posts').hide();
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
