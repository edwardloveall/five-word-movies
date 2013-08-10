$ ->
  $('a.reveal').click( (e) ->
    e.preventDefault()
    $('h2.hidden').css('opacity', 1)
  )