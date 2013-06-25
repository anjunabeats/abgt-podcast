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
                "itunes:author": show["itunes:author"][0]
                description: show.description[0]
                "itunes:subtitle": show["itunes:subtitle"][0]
                summary: show["itunes:summary"][0]
                enclosure: show.enclosure[0]["$"]
                link: show.link[0]
                guid: show.guid[0]
                pubDate: show.pubDate[0]
                category: show.category[0]
                "itunes:explicit": show["itunes:explicit"][0]
                "itunes:duration": show["itunes:duration"][0]
                "itunes:keywords": show["itunes:keywords"]
                
        console.log JSON.stringify shows, null, "\t"