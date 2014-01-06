module UserCukeHelpers
  def login_as(user)

  end

  def logout
    $browser.delete_cookie('_session', 'path=/') if $browser
    $browser.delete_all_visible_cookies if $browser
  end
end

World(UserCukeHelpers)
