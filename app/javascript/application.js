// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "./custom"
import "./sidebars"
import jquery from "jquery"

window.jQuery = jquery 
window.$ = jquery

$(function(){

    console.log("Hello from jquery")
})