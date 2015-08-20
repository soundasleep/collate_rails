module CollateRails
end

I18n.load_path += Dir[File.dirname(__FILE__) + "/../config/locale/*.{rb,yml}"]
puts "Collate: loaded #{I18n.available_locales} available locales"
