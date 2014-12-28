(($)->
  $ document
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
