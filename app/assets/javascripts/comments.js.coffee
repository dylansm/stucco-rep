CFB.Comments = class Comments

  constructor: ->
    @init_events()
  
  init_events: ->
    _this = @
    $(".comment-link").each ->
      post_id = $(this).parent().attr("data-id")
      if CFB.touch
        $("a", this).on("touchstart", -> _this.swap_comment_link(this.parentNode, post_id))
      else
        $("a", this).on("click", -> _this.swap_comment_link(this.parentNode, post_id))

        
  swap_comment_link: (link, post_id)->
    #console.log "#{link} #{post_id}"
    tmpl = JST["comment_form"]()
    $(link).addClass("open")
    $(link).append(tmpl)
    @init_new_events(link)

  init_new_events: (link)->
    if CFB.touch
      $("button.cancel", @$comment_form).on("touchstart", => @remove_form(link))
    else
      $("button.cancel", @$comment_form).on("click", => @remove_form(link))

  remove_form: (link)->
    $("#comment-form").remove()
    $(link).removeClass("open")



CFB.Comments.init = ->
  new CFB.Comments()
