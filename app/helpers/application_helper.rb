module ApplicationHelper
  def locale
    I18n.locale == :en ? "Inglês Estados Unidos" : "Português do Brasil"
  end  
end
