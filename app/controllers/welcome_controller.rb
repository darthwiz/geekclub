class WelcomeController < ApplicationController

  ensure_authenticated_to_facebook [ :except => :canvas ]

  def canvas
  end

  def test_auth
    @fb_user = facebook_session.user
  end

end
