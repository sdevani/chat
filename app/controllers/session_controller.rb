class SessionController < ApplicationController
  def create
	  cookies.permanent.signed[:authenticated] = true
	  cookies.permanent.signed[:user_name] = request.env['omniauth.auth']['extra']['raw_info']['login']
	  redirect_to root_url
  end

  def destroy
	  cookies.delete :authenticated
	  debugger
	  cookies.delete :user_name
	  redirect_to root_url
  end
end
