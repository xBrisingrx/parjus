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
  }
}

$(document).ready(function(){
  votes_table = $("#votes_table").DataTable({'language': {'url': datatables_lang}})
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