CFB.Likes = class Likes

  init: (posts_data) ->
    @posts_data = posts_data
    @user_id = parseInt $("body").attr("data-user-id"), 10
    @init_like_link_text()
    @init_events()

  init_like_link_text: ->
    _.each(@posts_data, (post_data) =>
      $post = $($(".post[data-id='#{post_data.id}']"))
      $link = $(".like-link", $post)
      CFB.Utils.format_link(post_data, $link, @user_id)
    )

  init_events: ->
    _this = @
    $(".like-link").each ->
      _this.init_like(this)

  init_like: (link) ->
    _this = @
    post_id = $(link).closest(".post").attr("data-id")
    if CFB.touch
      $(link).on("touchstart", (e) -> _this.toggle_like(e, post_id))
    else
      $(link).on("click", (e) -> _this.toggle_like(e, post_id))

  toggle_like: (e, post_id) ->
    $link = $(e.target).parent() #TODO evaluate if this works on all browsers
    like_json = { post_id: post_id }
    $.ajax
      url: "/newsfeed/posts/#{post_id}/likes",
      type: 'post',
      datatype: 'json',
      data: like_json,
      success: (data, textstatus, xhr) =>
        CFB.Utils.format_link(data.liked_post, $link, @user_id)
      error: (response) ->
        console.log response
