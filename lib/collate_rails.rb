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
    # also allows for smarter failure captures with strings
    # that might not be present
    def t(string, *args)
      template = FastGettext.cached_find(string)

      [":", "!", "?"].each do |c|
        if !template && string[-1] == c
          template = FastGettext.cached_find(string[0...(string.length - 1)])
          template += c if template
        end
      end

      if !template && string[0] == "(" && string[-1] == ")"
        template = FastGettext.cached_find(string[1...(string.length - 2)])
        template = "(#{template})" if template
      end

      # for capitalized strings
      if !template
        if string.capitalize == string
          if !template
            template = FastGettext.cached_find(string.downcase)
            template = template.capitalize if template
          end
        end
      end

      # for lowercase strings
      if !template
        if string.downcase == string
          if !template
            template = FastGettext.cached_find(string.capitalize)
            template = template.downcase if template
          end

          if !template
            template = FastGettext.cached_find(titleize(string))
            template = template.downcase if template
          end
        end
      end

      # for titleized strings e.g. "Open Source"
      if !template
        if titleize(string) == string
          if !template
            template = FastGettext.cached_find(string.capitalize)
            template = titleize(template) if template
          end

          if !template
            template = FastGettext.cached_find(string.downcase)
            template = titleize(template) if template
          end
        end
      end

      # try using '%{argument}' instead
      ["argument", "string", "number", "value"].each do |key|
        if !template && args && args[0] && args[0].keys.length > 0
          new_key = string.gsub('%{' + args.first.keys.first.to_s + '}', '%{' + key + '}')
          template = FastGettext.cached_find(new_key)
          args[0][key.to_sym] = args.first.values.first
        end
      end

      # nope, couldn't find anything
      if !template
        template = string
      end

      template % args
    end

    private

    def titleize(s)
      s.split(" ").map(&:capitalize).join(" ")
    end
  end
end
