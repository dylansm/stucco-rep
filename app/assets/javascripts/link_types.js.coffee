CFB.LinkTypes = class LinkTypes

  constructor: ($form) ->
    @$form = $form
    @init_form()
    @init_buttons()
    @init_radio()

  init_form: ->
    @$form.on("submit", ->
      if $("button.btn.submit", this).hasClass("btn-primary")
        unless confirm "Are you sure you want to delete this link type?\nThis will remove all links currently associated\nwith this link type."
          return false
      else
        return false
    )

  init_buttons: ->
    @$edit_btn = $("button.edit", @$form)
    @$cancel_btn = $("button.cancel", @$form)
    @$delete_btn = $("button.submit", @$form)
    if CFB.touch
      @$edit_btn.on("touchstart", (e) => @update_link_type(e) )
      @$cancel_btn.on("touchstart", (e) => @cancel_update(e) )
    else
      @$edit_btn.on("click", (e) => @update_link_type(e) )
      @$cancel_btn.on("click", (e) => @cancel_update(e) )


  cancel_update: (e) ->
    $("#update-link-type").removeClass("vis")
    @$edit_btn.removeClass("btn-primary")
    @$delete_btn.removeClass("btn-primary")
    # clear values on update fields too

  init_radio: ->
    $("#delete_link_type input[type=radio]").change =>
      @$edit_btn.addClass("btn-primary")
      @$delete_btn.addClass("btn-primary")
      id = $("input[type=radio]:checked", @$form).val()
      @load_link_type(id)

  load_link_type: (id) ->
    $.ajax
      url: "/admin/link_types/#{id}"
      type: "get"
      datatype: "json"
      success: (data, textstatus, xhr) =>
        @fill_update_form(data)
      error: (response) =>
        console.log response

  fill_update_form: (data) ->
    $form = $("#update_link_type")
    action = $form.attr("action")
    action = action.replace /\/\d+$/, ''
    $form.attr("action", "#{action}/#{data.id}")
    $("#update_name").val(data.name)
    $("#update_call_to_action").val(data.call_to_action)

  update_link_type: (e) ->
    e.preventDefault()
    unless $(e.target).hasClass("btn-primary")
      return
    $("#update-link-type").addClass("vis")


$ ->

  $("#delete_link_type").each ->
    new CFB.LinkTypes($(this))

