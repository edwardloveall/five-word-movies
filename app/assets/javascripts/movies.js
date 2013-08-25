$(document).ready(function() {
  $('a.reveal').click(function(e) {
    e.preventDefault();
    $('h2.hidden').removeClass('hidden');
    $('h1.five-words').addClass('answered');
  });

  $('ul.results li').click(function(e) {
    $(this).toggleClass('selected');
  });

  var guessField = $('input#guess');
  var wait = null;

  guessField.on('input', function(e) {
    clearTimeout(wait);
    var guess = guessField.val();

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
      $('ul.results li:last-child').data('id', movie.id).click(select_movie);
    }
  };

  clear_movies = function() {
    $('ul.results').children().remove();
  };

  select_movie = function() {
    $('ul.results li').not(this).removeClass('selected');
    $(this).toggleClass('selected');
  }

  $(window).keypress(function(e) {
    console.log(e.keycode);
  })
});
