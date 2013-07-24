CFB.Likes = class Likes

  constructor: (likes_data) ->
    @user_id = parseInt $("body").attr("data-user-id"), 10
    @initial_data = likes_data
    @init_like_links()
    @init_events()

  init_like_links: ->
    _.each(@initial_data, (like_data) =>
      @update_like_link(like_data.id, like_data.likes)
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
    like_json = { post_id: post_id }
    $.ajax
      url: "/newsfeed/posts/#{post_id}/likes",
      type: 'post',
      datatype: 'json',
      data: like_json,
      success: (data, textstatus, xhr) =>
        @update_like_link(data.liked_post.id, data.liked_post.likes)
      error: (response) ->
        console.log response

  update_like_link: (post_id, likes)->
    num_likes = likes.length
    $post = $(".post[data-id='#{post_id}']")
    $link = $(".like-link", $post)
    if num_likes > 0
      user_ids = _.pluck(likes, 'user_id')
      if _.contains(user_ids, @user_id)
        $link.html("Liked (#{num_likes})")
      else
        $link.html("Likes (#{num_likes})")
    else
      $link.html("Like")


CFB.Likes.init = (likes_data) ->
  new CFB.Likes(likes_data)
