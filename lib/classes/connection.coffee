class NicoScraper.Connection
  constructor: (@uri) ->
    response = httpsync.get(@uri).end()

    switch response.statusCode
      when 200
        resource = $(response.data.toString())
      when 404
        ""
      when 500
        ""
      when 503
        ""

    return resource