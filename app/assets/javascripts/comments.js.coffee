CFB.Comments = class Comments

  constructor: ->
    @post_id = null
    @link = null
    @init_events()
  
  init_events: ->
    _this = @
    $(".comment-link").each ->
      post_id = $(this).parent().attr("data-id")
      if CFB.touch
        $("a", this).on("touchstart", -> _this.swap_comment_link(this.parentNode, post_id))
      else
        $("a", this).on("click", -> _this.swap_comment_link(this.parentNode, post_id))
        
  swap_comment_link: (link, post_id) ->
    @link = link
    @post_id = post_id
    tmpl = JST["comment_form"]()
    $(link).addClass("open")
    $(link).append(tmpl)
    $("#comment-text").focus()
    @init_delayed_events()

  init_delayed_events: ->
    if CFB.touch
      $("button.submit", @$comment_form).on("touchstart", => @submit_comment())
      $("button.cancel", @$comment_form).on("touchstart", => @remove_form())
    else
      $("button.submit", @$comment_form).on("click", => @submit_comment())
      $("button.cancel", @$comment_form).on("click", => @remove_form())

  remove_form: ->
    $("#comment-form").remove()
    $(@link).removeClass("open")

  submit_comment: ->
    comment_json = { utf8: "✓", comment: { text: $("#comment-text").val() }}
    $.ajax
      url: "/newsfeed/posts/#{@post_id}/comments",
      type: 'post',
      datatype: 'json',
      data: comment_json,
      success: (data, textstatus, xhr) =>
        console.log data
        @remove_form()
        @add_comment(data)
      error: (response) ->
        console.log response

  add_comment: (data) =>
    tmpl = JST["comment"](id: data.user.id, name: data.user.name, text: data.text)
    $post_container = $(".post[data-id='#{@post_id}']")
    $comments_container = $(".comments-container", $post_container)
    $comments_container.append(tmpl)


CFB.Comments.init = ->
  new CFB.Comments()
