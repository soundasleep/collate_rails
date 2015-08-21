require "fast_gettext"

FastGettext.add_text_domain "app", :path => File.dirname(__FILE__) + '/../config/locale', :type => :po
FastGettext.default_text_domain = "app"

module FastGettext
  module Translation
    # helper method to relate to pluralize()
    def p_(n, key)
      n.to_s + " " + n_(key, key.pluralize, n)
    end

    # override the default i18n t() to make more sense
    # so we don't need to do _("arg") % {args} everywhere
    def t(string, *args)
      _(string) % args
    end
  end
end
