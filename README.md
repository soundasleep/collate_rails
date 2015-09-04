CollateRails
============

This project rocks.

Locales generated by [soundasleep/collate](https://github.com/soundasleep/collate).

Note that once you add this project, your server will take much longer to start up,
because it is loading all of the available locales at once - but after that,
you will have access to lots of languages for lots of strings.

## Enabling

Add to your gemfile:

```
gem "collate_rails", git: "https://github.com/soundasleep/collate_rails"
```

Run bundle:

```
bundle
```

Set your locale in your _ApplicationController_:

```
  before_action :set_locale

  def set_locale
    FastGettext.locale = params[:locale] || I18n.default_locale
  end
```

Add the translation helpers (`t()` etc) to all of your views, in your _ApplicationHelper_:

```
module ApplicationHelper
  include FastGettext::Translation
end
```

Now you can update your views as necessary:

```
  %h2=t("Dictionary")

  / p_ is an equivalent to pluralize()
  =t("%{words} in the dictionary", words: p_(Dictionary.count, "word"))
```

`t()` will try to make some intelligent guesses if it can't find the exact string:

```
  t("key:") ~= t("key") + ":"
  t("key!") ~= t("key") + "!"
  t("key?") ~= t("key") + "?"

  t("Key") ~= t("key").capitalize
  t("key") ~= t("key").downcase
  t("Key Abc") ~= t("key abc").titleize
```

## TODO

1. How to filter this data set to only get the strings used in your application
1. How to add your own custom translations

