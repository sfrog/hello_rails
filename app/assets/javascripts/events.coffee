document.addEventListener "turbolinks:load", ->
  WEEK_DAY = ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
  last_event = $()
  load_timer = ''
  loading = false

  init = ->
    handle_events()
    $('#by_project, #by_member').change(refresh_events)
    $(window).unbind('scroll')
    $(window).scroll(auto_load)

  today = ->
    date = new Date
    date.getFullYear() + '/' + (date.getMonth()+1) + '/' + date.getDate()

  yesterday = ->
    date = new Date(new Date - 86400000)
    date.getFullYear() + '/' + (date.getMonth()+1) + '/' + date.getDate()

  getDay = (created) ->
    WEEK_DAY[new Date(created).getDay()]

  format_created = (created) ->
    return "今" if created == today()
    return "昨" if created == yesterday()
    day = getDay(created)
    created = created.slice(5)
    wrap = $('<div>')
    $('<span>').addClass('date').text(created).appendTo(wrap)
    $('<span>').addClass('day').text(day).appendTo(wrap)
    wrap.html()

  handle_events = ->
    $('.event').each ->
      if $(this).attr('handled')
        last_event = $(this)
        return

      $(this).attr('handled', 'handled')
      created = $(this).data('created')
      project = $(this).data('project')

      if created != last_event.data('created')
        $('<h4>').addClass('event-day').html(format_created(created)).insertBefore(this)
        $('<h5>').addClass('event-project').text(project).insertBefore(this)
      else if project != last_event.data('project')
        $('<h5>').addClass('event-project').text(project).insertBefore(this)

      last_event = $(this)

  getParams = ->
    {
      by_project: $('#by_project').val()
      by_member: $('#by_member').val()
    }

  refresh_events = ->
    if history.pushState
      history.pushState(null, null, location.pathname + '?' + $.param(getParams()))

    $.get(location.pathname, getParams()).then (html) ->
      $('.events').html(html)
      handle_events()
      $(window).unbind('scroll', auto_load)
      $(window).scroll(auto_load)

  load_more = ->
    return if loading
    loading = true
    params = getParams()
    params.offset = last_event.data('seq')
    $.get(location.pathname, params).then (html) ->
      if $.trim(html)
        $('.events').append(html)
        handle_events()
      else
        $('<div>').addClass('no-more').text('没有更多了').appendTo('.events')
        $(window).unbind('scroll', auto_load)
      loading = false

  auto_load = ->
    clearTimeout(load_timer)
    load_timer = setTimeout(do_auto_load, 100)

  do_auto_load = ->
    scrollTop = $(window).scrollTop()
    scrollHeight = $(document).height()
    windowHeight = $(window).height()
    if scrollTop + windowHeight >= scrollHeight - 100
      load_more()

  init()
