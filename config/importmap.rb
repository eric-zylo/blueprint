# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "react", to: "https://cdn.skypack.dev/react"
pin "react-dom", to: "https://cdn.skypack.dev/react-dom"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@6.1.4-1/lib/assets/compiled/rails-ujs.js"
pin_all_from "app/javascript/controllers", under: "controllers"
