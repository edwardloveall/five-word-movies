$(document).ready(function() {
  $('a.reveal').click(function(e) {
    e.preventDefault();
    $('h2.hidden').removeClass('hidden');
    $('h1.five-words').addClass('answered');
  });

  $('ul.results li').click(function(e) {
    $(this).toggleClass('selected');
  });

  var wait = null;

  $('input#guess, input#movie_title').on('input', function(e) {
    console.log(e);

    clearTimeout(wait);
    var guess = $(this).val();

    if (guess.length <= 0) {
      clear_movies();
    }

    wait = setTimeout((function() {
      movie_request(guess);
    }), 500);
  });

  movie_request = function(title) {
    if (title.length > 0) {
      return $.ajax({
        url: "/movie_search/" + title,
        dataType: 'json',
        success: render_movies
      });
    }
  };

  render_movies = function(data) {
    var movie, _i, _len, _ref, _results;
    clear_movies();
    for (i = 0; i < data.movies.length; i++) {
      movie = data.movies[i];
      $('ul.results').append("<li>" + movie.title + " (" + movie.year + ")</li>");
      $('ul.results li:last-child').data('id', movie.id).data('title', movie.title).click(select_movie);

      if($('input#movie_rotten_id').val() == movie.id) {
        $('ul.results li:last-child').addClass('correct')
      }
    }
  };

  clear_movies = function() {
    $('ul.results').children().remove();
  };

  select_movie = function() {
    $('ul.results li').not(this).removeClass('selected');
    $(this).toggleClass('selected');

    if(window.location.toString().match(/(edit|new)/)) {
      $('input#movie_rotten_id').val($(this).data('id'))
      $('input#movie_title').val($(this).data('title'))
    }

    if ($(this).hasClass('correct')) {
      $('div.cta').addClass('done');
    }
  }

  $(window).keypress(function(e) {
    console.log(e.keycode);
  })

  set_movie = function(id) {
    $('input#movie_rotten_id').val(id);
  }
});
