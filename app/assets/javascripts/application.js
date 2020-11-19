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
//= require bootstrap-sprockets
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
      limit:     100
    };
  
  function set_params(attribute, term) {
    // reset search parameters
    reset_params();
    // reset search results
    $('#results').empty();
    // set attribute
    params.attribute = attribute;
    // set searching keywords
    params.term = term;
    // execute searching
    search_exec();
  }
  
  // initialize parameters
  function reset_params() {
    results_array = [];
    params.term = '';
    params.attribute = '';
  }

  // execute searching / get the JSON file
  function search_exec() {
    $.getJSON(search_url, params,
      function(data, status) {
        // save rusults
        results_array = data.results;
        // show results
        $.each(data.results, function(index, result) {
          build_result(index, result);
        });
      }
    )
  }

  // show results
  function build_result(index, result) {
    // do not show the results which have same collection ids

    // append div tags for index of search results
    var item_index = index;
    $('#results').append($('<div>', { id: item_index, class: 'result_item' }));
    
    // show content
    var $item_id = $('#' + item_index);
    $item_id.append($('<img>', { src: result.artworkUrl100,   class: 'result_artwork' }));
    $item_id.append($('<p>',   { text: result.artistName,     class: 'result_artist_name' }));
    $item_id.append($('<p>',   { text: result.collectionName, class: 'result_album_name' }));
    $item_id.append($('<p>',   { text: result.trackName,      class: 'result_track_name' }));

    // click to generate an embed URL
    $item_id.click(function () {
      var embed_player_html = generate_html(result.collectionId);
      $('#show_player').html(embed_player_html);
      // generate the form for sending attributes of the Music model
      attr_music(result);
      // show music artist name, album name, and artwork on post create form
      show_heading(result);
      // able post form and submit button when an album has been selected
      $('#post_form').prop("disabled", false);
      $('#post_btn').prop("disabled", false);
    });
  }

  // show music artist name, album name, and artwork on post create form
  function show_heading(result) {
    $('#heading_new').empty();
    $('#heading_new').append( `<h3>${result.collectionName} - ${result.artistName}</h3> `);
    $('#heading_new').append('<p>Compose your impression about this album!</p>');
  }

  // generate the form for sending attributes of the Music model
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

  // search with the artist form
  $('#artist').keypress(function(e) {
    // execute searching when return
    if (e.which === 13) {
      set_params(attribute_artist, e.target.value);
      return false;
    }
  });

  // search with the album form
  $('#album').keypress(function(e) {
    // execute searching when return
    if (e.which === 13) {
      set_params(attribute_album, e.target.value);
      return false;
    }
  });

  // generate embed URL
  function generate_html(id) {
    return $('<iframe>',{ src: first_part_url + id + latter_part_url,
                          frameborder: 0,
                          sandbox: "allow-forms allow-popups allow-same-origin allow-scripts allow-top-navigation-by-user-activation",
                          allow: "autoplay *; encrypted-media *;",
                          style: "height: 450px; width: 100%; max-width: 450px; overflow: hidden; border-radius: 10px; background: transparent;" });
  }

  $(document).on('turbolinks:load', function() {
    // scrollbar for search results
    $('#results').mCustomScrollbar();

    // disable post form and submit button untill an album is selected
    $("#post_form").prop("disabled", true);
    $("#post_btn").prop("disabled", true);

    // like button popup
    $('#like_form').hover(
      function() {
        $('#like_popup').css('display', 'block');
      },
      function() {
        $('#like_popup').css('display', 'none');
      }
    );

    // back-to-top button
    $('#back_to_top').click(function() {
      $('html, body').animate({ 'scrollTop': 0 }, 'slow');
    });

    // switch home slide images
    const $slide = $('.slide'),
          $info  = $('.slide_info');
    var index = 0;
    $slide.eq(index).css('display', 'block');
    $info.eq(index).css('display', 'block');

    $('.index_btn').click(function() {
      var clickedIndex = $('.index_btn').index(this);
      if ( clickedIndex != index ) {
        $slide.eq(index).css('display', 'none');
        $info.eq(index).css('display', 'none');
        index = clickedIndex;
        $slide.eq(index).fadeIn();
        $info.eq(index).fadeIn();
      }
    });
  });
});  