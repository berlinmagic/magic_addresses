require "action_view/helpers/asset_tag_helper"

# encoding: utf-8
module MgcaHelper
  
  def country_flag( lcl = I18n.locale.to_s, format = "small" )
    format = "medium" unless %w(small medium large).include?(format)
    lcl = "xx" unless %w(at by be ba bg ca hr cy cz dk fi fr de gr hu ie it lv li lt lu nl no pl pt ro ru rs sk si es se ch ua gb us).include?( lcl.to_s.downcase )
    raw( image_tag( "flags/countries/#{format}/flag-#{lcl.to_s.downcase}.png", class: "flag" ) )
  end
  
end