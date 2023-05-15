let people_table

function modal_disable_person(id) {
  $('#modal-disable-person #person_id').val(id)
  $('#modal-disable-person').modal('show')
}

$(document).ready(function(){
  people_table = $("#people_table").DataTable({
    'ajax': 'people',
    'columns': [
      {'data': 'name'},
      {'data': 'genre'},
      {'data': 'dni_type'},
			{'data': 'number'},
			{'data': 'direction'},
			{'data': 'neighborhood'},
      {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-person").on("ajax:success", function(event) {
    people_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-person").modal('hide')
  }).on("ajax:error", function(event) {
    console.log(event)
  })
})