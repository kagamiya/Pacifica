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
//= require rails-ujs
//= require jquery
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .

$(function() {
  
  var
    first_part_url = "https://embed.music.apple.com/us/album/",
    latter_part_url = "?app=music&amp;itsct=music_box&amp;itscg=30200"
    search_url        = 'https://itunes.apple.com/search',
    attribute_artist = 'artistTerm',
    attribute_album  = 'albumTerm',
    results_array = [],
    params = {
      term:      '',
      media:     'music',
      entity:    'song',
      attribute: '',
      country:   'US',
      lang:      'en_us',
      offset:    0,
      limit:     50
    };
  
  function set_params(attribute, term) {
    // 検索パラメータのリセット
    reset_params();
    // 検索結果のリセット
    $('#results').empty();
    // attributeの設定
    params.attribute = attribute;
    // 検索ワードの設定
    params.term = term;
    // 検索の実行
    search_exec();
  }
  
  // パラメータの初期化
  function reset_params() {
    results_array = [];
    params.term = '';
    params.attribute = '';
  }

  // 検索の実行/JSONファイルの取得
  function search_exec() {
    $.getJSON(search_url, params,
      function(data, status) {
        // 結果の保存
        results_array = data.results;
        // 結果の表示
        $.each(data.results, function(index, result) {
          build_result(index, result);
        });
      }
    )
  }

  // 結果を表示
  function build_result(index, result) {
    // 同じcollectionIdのアルバムを表示しない

    // 項目のdivタグを追加
    var item_index = index;
    $('#results').append($('<div>', { id: item_index, class: 'result_item' }));
    
    // 内容の表示
    var $item_id = $('#' + item_index);
    $item_id.append($('<img>', { src: result.artworkUrl100,   class: 'result_artwork' }));
    $item_id.append($('<p>',   { text: result.artistName,     class: 'result_artist_name' }));
    $item_id.append($('<p>',   { text: result.collectionName, class: 'result_album_name' }));
    $item_id.append($('<p>',   { text: result.trackName,      class: 'result_track_name' }));

    // クリックして埋め込みURLを生成
    $item_id.click(function () {
      var embed_player_html = generate_html(result.collectionId);
      $('#show_player').html(embed_player_html);
      // Musicモデルの属性を送信するフォームを生成
      attr_music(result);
    });
  }

  // Musicモデルの属性を送信するフォームを生成
  function attr_music(result) {
    var $name          = $('#form_name'),
        $artist        = $('#form_artist'),
        $artwork       = $('#form_artwork'),
        $collection_id = $('#form_collection_id');
    
    $name.empty();
    $artist.empty();
    $artwork.empty();
    $collection_id.empty();

    $name.append($('<input>',          { name: 'post[music_attributes][name]',
                                         type: 'hidden',
                                         value: result.collectionName }));
    $artist.append($('<input>',        { name: 'post[music_attributes][artist]',
                                         type: 'hidden',
                                         value: result.artistName }));
    $artwork.append($('<input>',       { name: 'post[music_attributes][artwork]',
                                         type: 'hidden',
                                         value: result.artworkUrl100 }));
    $collection_id.append($('<input>', { name: 'post[music_attributes][collection_id]',
                                         type: 'hidden',
                                         value: result.collectionId }));
  }

  // artistフォームで検索
  $('#artist').keypress(function(e) {
    // Enterキーが押されたら検索する
    if (e.which === 13) {
      set_params(attribute_artist, e.target.value);
      return false;
    }
  });

  // albumフォームで検索
  $('#album').keypress(function(e) {
    // Enterキーが押されたら検索する
    if (e.which === 13) {
      set_params(attribute_album, e.target.value);
      return false;
    }
  });

  //埋め込みhtmlを生成
  function generate_html(id) {
    return $('<iframe>',{ src: first_part_url + id + latter_part_url,
                          frameborder: 0,
                          sandbox: "allow-forms allow-popups allow-same-origin allow-scripts allow-top-navigation-by-user-activation",
                          allow: "autoplay *; encrypted-media *;",
                          style: "height: 450px; width: 100%; max-width: 450px; overflow: hidden; border-radius: 10px; background: transparent;" });
  }

  // scrollbar for search results
  $('#results').mCustomScrollbar();

  // back-to-top button
  $('#back-to-top').click(function() {
    $('html, body').animate({ 'scrollTop': 0 }, 'slow');
  });

});  