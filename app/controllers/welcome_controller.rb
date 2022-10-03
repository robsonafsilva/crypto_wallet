class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Jackson Pires [COOKIES]"
    session[:user_name] = "ROBSON [SESSION]"
  end
end
