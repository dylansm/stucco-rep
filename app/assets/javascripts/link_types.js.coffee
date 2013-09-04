CFB.LinkTypes = class LinkTypes

  constructor: ($form) ->
    @$form = $form
    @$edit_btn = $("button.edit", $form)
    @init_form()
    @init_buttons()

  init_form: ->
    @$form.on("submit", ->
      if $("button.btn.submit", this).hasClass("btn-primary")
        unless confirm "Are you sure you want to delete this link type?\nThis will remove all links currently associated\nwith this link type."
          return false
      else
        return false
    )

  init_buttons: ->
    if CFB.touch
      @$edit_btn.on("touchstart", (e) => @update_link_type(e) )
    else
      @$edit_btn.on("click", (e) => @update_link_type(e) )


  $("#delete_link_type button.cancel").click ->
    $("#update-link-type").removeClass("vis")
    $("#delete_link_type button.edit").removeClass("btn-primary")
    $("#delete_link_type button.submit").removeClass("btn-primary")
    # clear values on update fields too

  $("#delete_link_type input[type=radio]").change ->
    $("#delete_link_type button.edit").addClass("btn-primary")
    $("#delete_link_type button.submit").addClass("btn-primary")


  update_link_type: (e) ->
    e.preventDefault()
    unless $(e.target).hasClass("btn-primary")
      return
    $("#update-link-type").addClass("vis")
    id = $("#delete_link_type input[type=radio]:checked").val()
    @load_link_type(id)


$ ->

  $("#delete_link_type").each ->
    new CFB.LinkTypes($(this))
  


    

