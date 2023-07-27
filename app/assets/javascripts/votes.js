let votes_table
let votes = {
  grafica: '',
  etiquetas: '',
  datosVentas2020: '',
  chargeBarGrafic(){
    const data = this.fetch_grafic_data()
    console.log('=>', data)

  }, 
  fetch_grafic_data(){
    fetch('/votes/grafic_data')
    .then( response => {
      const datos = response.json()
      console.log( datos )
      return datos
    })
    .then( response => response )
  },
  count_votes: ( rol_id ) => {
    const votes_inputs = document.getElementsByClassName(`rol_${rol_id}`)
    let count_rol_votes = 0
    for (let rol_vote of votes_inputs ) {
      const vote = parseInt( rol_vote.querySelector('#vote_number').value )
      if (!isNaN(vote)) {
        count_rol_votes += vote
      }
    }
    document.getElementById(`agrupacion_${rol_id}`).querySelector('#vote_number').value = count_rol_votes

    let count_other_rol_votes = count_rol_votes
    const other_votes_inputs = document.getElementsByClassName(`other_votes_rol_${rol_id}`)
    for (let rol_vote of other_votes_inputs ) {
      const vote = parseInt( rol_vote.querySelector('#vote_number').value )
      if (!isNaN(vote)) {
        count_other_rol_votes += vote
      }
    }
    document.getElementById(`all_votes_rol_${rol_id}`).value = count_other_rol_votes
  }
}

$(document).ready(function(){
  votes_table = $("#votes_table").DataTable({
    ordering:  false,
    'language': {'url': datatables_lang}
    }
  )
})

function create_vote_table(){
  let form = document.getElementById('form-vote-table')
  let form_data = new FormData()
  form_data.append('table_id', form.querySelector('#vote_table_id').value )

  const votes = document.getElementsByClassName('register_vote')
  let votes_index = 0
  for (let vote of votes) {
    if (vote.querySelector('#vote_number').value == '') {
      continue;
    } else {
      let vote_number = parseInt( vote.querySelector('#vote_number').value )
      if ( isNaN(vote_number) ) {
        vote.querySelector('#vote_number').classList.add('is-invalid')
        return
      } else {
        votes_index++
        form_data.append( `political_party_id_${votes_index}`, vote.querySelector('#vote_political_party_id').value )
        form_data.append( `number_${votes_index}`, vote_number )
      }
    }
  }

  form_data.append('cant', votes_index)

  if (votes_index > 0) {
    fetch('/votes', {
      method: 'POST',
      headers: {           
          'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
        },
        body: form_data
    })
    .then( response => response.json() )
    .then( response => {
      if (response.status === 'success') {
        window.location.href = "/votes/mesa";
      }
    })
  } else {
    noty_alert('info', 'No ingreso votos')
  }
}

window.onload = (event) => {
  if ( document.getElementById('form-vote') != null ) {
    $('.select-table').select2({ 
      width: '100%',theme: "bootstrap4", placeholder: "Seleccione mesa (*)" })

    document.getElementById('form-vote').addEventListener('submit', e => {
      e.preventDefault()
      e.stopPropagation()
      let form = new FormData()

      form.append('vote[table_id]', e.target.querySelector('#vote_table_id').value )

      const votes = document.getElementsByClassName('votes')
      const other_votes = document.getElementsByClassName('other_votes')

      let votes_index = 0
      for (let vote of votes) {
        const political_party_id = vote.querySelector('#vote_political_party_id').value
        const votes_rol = document.getElementsByClassName(`votes_rol_${political_party_id}`)

        for (let vote_rol of votes_rol) {
          vote_quantity = parseInt( vote_rol.querySelector('#vote_number').value )
          if (!isNaN(vote_quantity) && vote_quantity > 0 ) {
            votes_index++
            form.append(`vote[political_party_id][${votes_index}]`, political_party_id )
            form.append( `vote[number][${votes_index}]`, vote_quantity )
            form.append( `vote[politician_rol_id][${votes_index}]`, vote_rol.querySelector('#vote_politician_rol_id').value )
            form.append( `vote[category][${votes_index}]`, vote_rol.querySelector('#vote_category').value )
          }
        }
      }

      for (let vote of other_votes) {
        const votes_value = vote.getElementsByClassName('votes_value')
        for (let vote of votes_value) {
            vote_quantity = parseInt( vote.querySelector('#vote_number').value )
            if (!isNaN(vote_quantity) && vote_quantity > 0 ) {
              votes_index++
              form.append( `vote[number][${votes_index}]`, vote_quantity )
              form.append( `vote[politician_rol_id][${votes_index}]`, vote.querySelector('#vote_politician_rol_id').value )
              form.append( `vote[category][${votes_index}]`, vote.querySelector('#vote_category').value )
            }
          }
      }

      form.append('vote[entry_votes]', votes_index )
      fetch(e.target.action, {
        method: 'POST',
        headers: {           
            'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
          },
          body: form
      })
      .then( response => response.json() )
      .then( response => {
        if (response.status === 'success') {
          noty_alert(response.status, response.msg)
          window.location.href = response.url
        }
      })
    })
  }
};

$("#form-vote").on("ajax:success", function(event) {
    // votes_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    location.reload()
    $("#modal").modal('hide')
  }).on("ajax:error", function(event) {
  let msg = JSON.parse( event.detail[2].response )
  set_input_status_form('form-vote', 'vote', msg)
})

