jQuery ->
    states = $('#person_state_id').html()
    $('#person_country_id').change ->
        country = $('#person_country_id :selected').text()
        # escaped_country = country.repalce(,'\\$1') 
        $(states).filter("optgroup[label='#{country}']").html()
        if options
            $('#person_state_id').html(options)
            $('#person_state_id').parent().show ()
        else
            $('#person_state_id').empty()
            $('#person_state_id').parent().hide()