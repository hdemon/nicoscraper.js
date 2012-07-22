util = require 'util'
fs = require 'fs'
watchr = require 'watchr'
muffin = require 'muffin'
_ = require 'underscore'
exec = (require 'child_process').exec

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

task 'test', 'test by mocha', (options) ->
  watchr.watch
    path: "./source"
    listener: (eventName,filePath) ->
      child = exec "mocha -R spec --compilers coffee:coffee-script -t 10000 ./test/#{getFileName(filePath)}", (error, stdout, stderr) ->
        console.log('stdout: ' + stdout);
        console.log('stderr: ' + stderr);

getFileName = (filePath) ->
  _.last (filePath.split '/')

joinFiles = (files, targetFile) ->
  util.log 'Building'
  console.log files
  muffin.exec "cat #{files.join ' '} > #{targetFile}"
  muffin.exec "cat #{requires} #{namespace} #{targetFile} #{exports} > ./production/tmp"
  muffin.exec "mv ./production/tmp #{targetFile}"