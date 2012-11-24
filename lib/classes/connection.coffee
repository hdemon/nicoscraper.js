class NicoScraper.Connection
  constructor : (@uri, @callback) ->
    @callback.success ?= ->
    @callback.failed ?= ->

    request = new request

    request @uri, (error, response, body) =>

      switch response.statusCode
        when 200
          @callback.success body
        when 404
          @callback.failed
          @callback._404
        when 500
          @callback.failed
          @callback._500
        when 503
          @callback.failed
          @callback._503
