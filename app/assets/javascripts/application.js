//= require rails-ujs
//= require activestorage

//= require unify/jquery.min
//= require unify/jquery-migrate.min
//= require unify/popper.min
//= require unify/bootstrap
//= require unify/hs.megamenu
//= require unify/hs.core
//= require unify/components/hs.header
//= require unify/helpers/hs.hamburgers
//= require vendor/datatables/datatables
//= require vendor/noty/noty.min
//= require vendor/select2/select2.full
//= require custom

//= require vendor/jquery-validate/jquery.validate
//= require vendor/jquery-validate/additional-methods


//= require users
//= require provinces
//= require cities
//= require people
//= require institutions
//= require headquarters
//= require institutions
//= require political_parties
//= require votes
//= require neighborhoods

let politician_rols_table, institution_types_table, tables_table

$(document).on('ready', function () {
  // initialization of header
  $.HSCore.components.HSHeader.init($('#js-header'));
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

  $('.js-mega-menu').HSMegaMenu({
   event: 'hover',
   pageContainer: $('.container'),
   breakpoint: 991
  });
});