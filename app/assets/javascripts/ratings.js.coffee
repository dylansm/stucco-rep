CFB.Ratings = class Ratings

  init: (posts_data) ->
    @posts_data = posts_data
    @init_events()
    @init_rating_states()

  init_events: ->
    _this = @
    $("span.rating").each ->
      unless CFB.touch
        $(this).hover(
          ->
          ,
          (e) -> _this.revert(e)
        )
      $("span.icon-star", this).each ->
        if CFB.touch
          $(this).on("touchstart", (e) -> _this.hover_touch_star(e))
          $(this).on("touchend", (e) -> _this.select_star(e))
        else
          $(this).on("mouseover", (e) -> _this.hover_touch_star(e))
          $(this).on("click", (e) -> _this.select_star(e))


  hover_touch_star: (e) =>
    e.preventDefault()
    cur_index = @star_index(e.target)
    @set_rating_status($(e.target).closest(".post"), cur_index + 1)
      
  star_index: (star) ->
    $ratings = $(star).parent()
    $("span.icon-star", $ratings).index(star)
    

  init_rating_states: ->
    _.each(@posts_data, (post) =>
      if post.rating
        rating = parseInt post.rating.rating, 10
        $post = $(".post[data-id='#{post.id}']")
        @set_rating_status($post, rating)
      )

  set_rating_status: ($post, rating) ->
    $(".icon-star", $post).each (index, el) ->
      if index < rating
        $(el).addClass("star-lit")
      else
        $(el).removeClass("star-lit")

  select_star: (e) ->
    cur_index = @star_index(e.target)
    rating = cur_index + 1
    $rating = $(e.target).parent()
    $post = $(e.target).closest(".post")
    post_id = $post.attr("data-id")
    if $rating.attr("data-rating") == "0"
      method = "post"
    else
      method = "patch"

    $.ajax
      url: "/admin/ratings/post/#{post_id}/#{rating}",
      type: 'post',
      data: { "_method": method }
      dataType: 'json',
      success: (data, textStatus, xhr) =>
        @rating_saved(data, $rating)
      error: (response) ->
        console.log response

  rating_saved: (data, $rating) ->
    $rating.attr("data-rating", data.rating)

  revert: (e) ->
    if $(e.target).hasClass("icon-star")
      e.target = e.target.parentNode
    saved_rating = parseInt $(e.target).attr("data-rating"), 10
    $("span.icon-star", e.target).each (index, el) ->
      if index < saved_rating
        $(this).addClass("star-lit")
      else
        $(this).removeClass("star-lit")

