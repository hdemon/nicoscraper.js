class NicoQuery.Movie
  constructor : (@provisional_id) ->
    @type = get_type()

  get_type : ->
    switch _(@provisional_id)
      when startsWith 'nm'
        'Niconico Movie Maker'
      when startsWith 'sm'
        'Smile Video'
      else
        'unknown'
