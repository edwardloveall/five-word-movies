$ ->
  $('a.reveal').click( (e) ->
    e.preventDefault()
    $('h2.hidden').removeClass('hidden')
    $('h1.five-words').addClass('answered')
  )