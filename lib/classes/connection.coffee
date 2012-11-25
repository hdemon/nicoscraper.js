class NicoScraper.Connection
  constructor: (@uri) ->
    response = httpsync.get(@uri).end()

    return switch response.statusCode
      when 200
        response.data.toString()
      when 404, 500, 503
        ""
