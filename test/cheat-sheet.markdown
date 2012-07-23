## コールバックを検索する

  sinon.stub(NicoQuery, "Connection").yieldsTo "success", fixture

## stubは、unwrapしなければならない

  after ->
    NicoQuery.Connection.restore()
