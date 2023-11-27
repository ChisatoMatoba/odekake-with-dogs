# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "preview", to: "preview.js"
pin "preview_dog", to: "preview_dog.js"
pin "tab", to: "tab.js"
pin "modal", to: "modal.js"
pin "facility_index", to: "facility_index.js"
