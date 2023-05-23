let political_parties_table, count_politicians, count_political_parties

function modal_disable_political_partie(id) {
  $('#modal-disable-political_partie #political_partie_id').val(id)
  $('#modal-disable-political_partie').modal('show')
}

$(document).ready(function(){
  political_parties_table = $("#political_parties_table").DataTable({
    'ajax': 'political_parties',
    'columns': [
      {'data': 'name'},
			{'data': 'politicians'},
			{ 'data': 'description'},
      {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-political_partie").on("ajax:success", function(event) {
    political_parties_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-political_partie").modal('hide')
  }).on("ajax:error", function(event) {
    console.log(event)
  })
})