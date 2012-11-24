## コールバックを検索する

  sinon.stub(NicoScraper, "Connection").yieldsTo "success", fixture

## stubは、unwrapしなければならない

  after ->
    NicoScraper.Connection.restore()
