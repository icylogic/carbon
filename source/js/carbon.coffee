(($)->
  $ document
  .on 'click', '.comments-switch-duoshuo',
    () ->
      comments = $('#duoshuo_thread')
      if comments.has("div").length > 0
        comments.toggle('fast')
        return;
      el = document.createElement('div')
      el.setAttribute('data-thread-key', $(this).attr('key'))
      el.setAttribute('data-url', $(this).attr('url'))
      el.setAttribute('data-author-key', $(this).attr('duoshuo'))
      DUOSHUO.EmbedThread(el)
      comments.append(el).hide().fadeIn('')
  .on 'click', '.extra-switch',
    () ->
      $('.extra').toggle('fast')
  .pjax 'a',
    '#content',
    fragment:'#content'
    timeout: 10000
  .on 'pjax:send',
    ()->
      $ '#content'
      .fadeTo 0, 0
  .on 'pjax:complete',
    ()->
      $ '#content'
      .fadeTo "fast", 1
) jQuery
