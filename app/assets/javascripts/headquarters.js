let headquarters_table

function modal_disable_headquarter(id) {
  $('#modal-disable-headquarter #headquarter_id').val(id)
  $('#modal-disable-headquarter').modal('show')
}

$(document).ready(function(){
  headquarters_table = $("#headquarters_table").DataTable({
    'ajax': 'headquarters',
    'columns': [
      {'data': 'name'},
			{'data': 'neighborhood'},
			{ 'data': 'in_charge'},
      {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-headquarter").on("ajax:success", function(event) {
    headquarters_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-headquarter").modal('hide')
  }).on("ajax:error", function(event) {
    console.log(event)
  })
})