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
          #$(this).on("mouseout", (e) -> _this.dim_star(e))
          $(this).on("click", (e) -> _this.select_star(e))


  hover_touch_star: (e) =>
    e.preventDefault()
    cur_index = @star_index(e.target)
    @rate_post($(e.target).closest(".post"), cur_index + 1)
      
  star_index: (star) ->
    $ratings = $(star).parent()
    $("span.icon-star", $ratings).index(star)
    

  init_rating_states: ->
    _.each(@posts_data, (post) =>
      if post.rating
        rating = parseInt post.rating.rating, 10
        $post = $(".post[data-id='#{post.id}']")
        @rate_post($post, rating)
      )

  rate_post: ($post, rating) ->
    $(".icon-star", $post).each (index, el) ->
      if index < rating
        $(el).addClass("star-lit")
      else
        $(el).removeClass("star-lit")

  select_star: (e) ->
    cur_index = @star_index(e.target)
    post_id = $(e.target).parent().attr("data-rating", cur_index + 1)
    #$(e.target).parent().attr("data-rating") = 

  revert: (e) ->
    if $(e.target).hasClass("icon-star")
      e.target = e.target.parentNode
    saved_rating = parseInt $(e.target).attr("data-rating"), 10
    $("span.icon-star", e.target).each (index, el) ->
      if index < saved_rating
        $(this).addClass("star-lit")
      else
        $(this).removeClass("star-lit")


  dim_star: (e) ->
    #console.log e.target

