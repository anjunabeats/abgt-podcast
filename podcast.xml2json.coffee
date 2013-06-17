fs = require 'fs',
xml2js = require 'xml2js'
util = require 'util'

shows = []

parser = new xml2js.Parser()
fs.readFile process.argv[2], (err, data) ->
    parser.parseString data, (err, result) ->
        for show in result.rss.channel[0].item
            shows.push
                title: show.title[0]
                

        console.log JSON.stringify shows