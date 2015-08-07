(($) ->
  if performFancybox? and performFancybox
    setFancybox = ->
      $ '.article-content img'
      .each ->
        image = $ this
        imageLink = image.parent('a')
        if (imageLink.size() < 1)
          imageLink = image.wrap('<a href="' + this.getAttribute('src') + '"></a>').parent('a')
        imageLink.fancybox()
  else
    setFancybox = ->

  if doRenderMath?
    switch doRenderMath
      when 'katex'
        renderMath = ->
          renderMathInElement document.getElementById('content'),
            delimiters: [
              {left: "$$", right: "$$", display: true},
              {left: "\\[", right: "\\]", display: true},
              {left: "$", right: "$", display: false},
              {left: "\\(", right: "\\)", display: false}
            ]
      when 'mathjax'
        renderMath = ->
          #MathJax.Hub.Queue ["Typeset", MathJax.Hub, document.getElementById 'content'] 
  else
    renderMath = ->

  if swiftypeKey?
    loadSwiftype = ->
      ((w, d, t, u, n, s, e) ->
        w['SwiftypeObject'] = n
        w[n] = w[n] or ->
          (w[n].q = w[n].q or []).push arguments
          return
        s = d.createElement(t)
        e = d.getElementsByTagName(t)[0]
        s.async = 1
        s.src = u
        e.parentNode.insertBefore s, e
        return
      ) window, document, 'script', '//s.swiftypecdn.com/install/v2/st.js', '_st'
      _st 'install', swiftypeKey, '2.0.0'
  else
    loadSwiftype = ->

  renderContent = ->
    setFancybox()
    renderMath()
    loadSwiftype()

  $ '#search-icon'
    .click ->
      $ '#search-input'
        .toggle 'fast', ->
          $ this
            .toggleClass('hidden')
          if not $('#search-input').hasClass('hidden')
            $ '#search-input'
              .focus()

  $ document
    .on 'click', '.comments-switch-duoshuo', ->
      comments = $('#duoshuo_thread')
      if comments.has('div').length > 0
        comments.toggle('fast')
        return;
      el = document.createElement('div')
      el.setAttribute('data-thread-key', $(this).attr('key'))
      el.setAttribute('data-url', $(this).attr('url'))
      el.setAttribute('data-author-key', $(this).attr('duoshuo'))
      DUOSHUO.EmbedThread(el)
      comments.append(el).hide().fadeIn('')

    .on 'click', '.extra-switch', ->
      $('.extra').toggle('fast')

    .pjax 'a',
      '#content',
      fragment:'#content'
      timeout: 10000

    .on 'pjax:send', ->
      $ '#content'
        .fadeTo 0, 0

    .on 'pjax:complete', ->
      $ '#content'
        .fadeTo 'fast', 1
        # Fix for Google Analytics
        renderContent()
        if ga?
          ga 'set', 'location', window.location.href
          ga 'sent', 'pageview'
    .ready ->
      renderContent()

) jQuery
