class NicoQuery.Utility
  _convert_to_sec : (string) ->
    s = string.split ':'
    minute = Number s[0]
    second = Number s[1]
    minute * 60 + second

  _convert_to_unix_time : (string) ->
    s = string.match /\w+/g
    new Date(s[0], s[1] - 1, s[2], s[3], s[4], s[5], 0) / 1000
