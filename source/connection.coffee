class NicoQuery.Connection
  constructor : (@uri, @callback) ->
    @callback.success ?= ->
    @callback.failed ?= ->

    zombie = new Zombie
    zombie.runScripts = false

    zombie.visit @uri, (error, browser, status) =>
      @browser = browser
      @status = status
      @error = error

      switch @status
        when 200
          @callback.success @browser
        when 404
          @callback.failed @error, @status
          @callback._404 @error, @status
        when 500
          @callback.failed @error, @status
          @callback._500 @error, @status
        when 503
          @callback.failed @error, @status
          @callback._503 @error, @status
