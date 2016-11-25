// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require tether
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require pickadate/picker
//= require pickadate/picker.date
//= require pickadate/picker.time
//= require handlebars
//= require typeahead.bundle.min
//= require jquery.raty
//= require sweetalert
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.button-collapse').sideNav();
  Materialize.updateTextFields();
  $('select').material_select();
});


// Initialize select tag for Materialize
 $(document).ready(function() {
    $('select').material_select();
  });


// Date tag Materialize
 $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15 // Creates a dropdown of 15 years to control year
  });
