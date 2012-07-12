util = require 'util'
fs = require 'fs'
muffin = require 'muffin'

requires = './source/requires.coffee'
namespace = './source/namespace.coffee'
exports = './source/exports.coffee'

files = [
    './source/module.coffee'
  , './source/utility.coffee'
  , './source/connection.coffee'
  , './source/entry_atom.coffee'
  , './source/getthumbinfo.coffee'
  , './source/movie.coffee'
  , './source/mylist.coffee'
  , './source/mylist_atom.coffee'
  , './source/tag_search.coffee'
  , './source/tag_search_atom.coffee'
]

task 'build', 'compile muffin', (options) ->
  joinFiles files, './production/nicoquery.coffee'

  muffin.run
    files: './production/*.coffee'
    options: options
    map:
      'nicoquery.coffee' : (matches) ->
        target = "./production/#{matches[0]}"
        console.log "cat ./source/requires.coffee #{target} ./source/exports.coffee > ./production/tmp"


        muffin.compileScript "#{target}", 'production/nicoquery.js', options


joinFiles = (files, targetFile) ->
  util.log 'Building'
  console.log files
  muffin.exec "cat #{files.join ' '} > #{targetFile}"
  muffin.exec "cat #{requires} #{namespace} #{targetFile} #{exports} > ./production/tmp"
  muffin.exec "mv ./production/tmp #{targetFile}"