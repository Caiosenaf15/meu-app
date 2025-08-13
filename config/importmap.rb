# Pin npm packages by running ./bin/importmap

pin "application"

pin "bootstrap", preload: true
pin "@popperjs/core", to: "@popperjs--core.js", preload: true
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.16
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.13
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @8.0.200
