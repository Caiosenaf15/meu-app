# Pin npm packages by running ./bin/importmap

pin "application"

pin "bootstrap", preload: true
pin "@popperjs/core", to: "@popperjs--core.js", preload: true
