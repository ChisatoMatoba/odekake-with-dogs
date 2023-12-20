// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "preview"
import "preview_dog"
import "tab"
import "modal"
import "facility_index"
import "tags"

import jQuery from "jquery"
window.jQuery = jQuery
window.$ = jQuery

import "select2"
