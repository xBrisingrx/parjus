let neighborhoods_table

function modal_disable_neighborhood(id) {
  $('#modal-disable-neighborhood #neighborhood_id').val(id)
  $('#modal-disable-neighborhood').modal('show')
}

$(document).ready(function(){
  neighborhoods_table = $("#neighborhoods_table").DataTable({
    'ajax': 'neighborhoods',
    'columns': [
      {'data': 'name'},
      {'data': 'people'},
      {'data': 'institutions'},
      {'data': 'actions'}
    ],
    'language': {'url': datatables_lang}
  })

  $("#form-disable-neighborhood").on("ajax:success", function(event) {
    neighborhoods_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-neighborhood").modal('hide')
  }).on("ajax:error", function(event) {
    console.log(event)
  })
})