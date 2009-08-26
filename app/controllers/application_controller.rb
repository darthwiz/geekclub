# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_facebook_session
  helper_method :facebook_session

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private

  def require_facebook_user
    @fb_session = session[:facebook_session]
    redirect_to root_path and return unless @fb_session
    @user = User.find_by_fbid(@fb_session.send(:uid))
    @user = User.new if @user.nil?
    if (@user.updated_at.nil? || @user.updated_at < 5.minutes.ago)
      begin
        logger.info "updating fb user info"
        fb_user          = @fb_session.user
        @user.first_name = fb_user.first_name
        @user.last_name  = fb_user.last_name
        @user.fbid       = fb_user.id
        @user.picture    = fb_user.pic_square
        @user.updated_at = Time.now
        @user.save
      rescue StandardError => exc
        session[:facebook_session] = nil
        redirect_to root_path
        return false
      rescue Exception => exc2
        session[:facebook_session] = nil
        redirect_to root_path
        return false
      end
    end
    return true
  end

end
