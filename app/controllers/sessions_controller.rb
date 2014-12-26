class SessionsController < Devise::SessionsController
  #protected

  # CUSTOM (Mix of actual devise controller method and ajax customization from http://natashatherobot.com/devise-rails-sign-in/):
  def create
    # (NOTE: If user is not confirmed, execution will never get this far...)
    respond_to do |format|
      format.html { super }                     
      format.js  do
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        return sign_in_and_redirect(resource_name, resource)
      end          
    end

  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    respond_to do |format|
      format.json {render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}}
      format.html {redirect_to root_url}
    end
  end

  def failure
    respond_to do |format|
      format.json { render:json => {:success => false, :errors => ["Login failed."]} }
    end
  end
end