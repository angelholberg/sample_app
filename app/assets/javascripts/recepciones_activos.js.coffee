# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.recepcion_activo').dataTable
    "oLanguage": lanES,
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap"
    
jQuery ->
  $("#combo_agente").select2(); 

jQuery ->
  $("#combo_vehiculo").select2(); 
