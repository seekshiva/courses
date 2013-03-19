window.renderSignupModal = (user)->
  $("#wizard").bwizard
    activeIndexChanged: (e,ui) ->
      if ui.index is 2 then $(".modal-footer").show() else $(".modal-footer").hide()

  if user
    $("#profileModal").find('input[name="user_name"]').val(user.name)