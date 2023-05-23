let institutions_table

function modal_disable_institution(id) {
  $('#modal-disable-institution #institution_id').val(id)
  $('#modal-disable-institution').modal('show')
}

$(document).ready(function(){
  institutions_table = $("#institutions_table").DataTable({
    'ajax': 'institutions',
    'columns': [
      {'data': 'type'},
      {'data': 'name'},
      {'data': 'city'},
      {'data': 'neighborhood'},
      {'data': 'direction'},
      {'data': 'tables'},
      {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-institution").on("ajax:success", function(event) {
    institutions_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-institution").modal('hide')
  }).on("ajax:error", function(event) {
    console.log(event)
  })
})