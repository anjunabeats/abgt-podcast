argv = require('optimist')
    .demand(['guid', 'author', 'title', 'subtitle', 'pubdate', 'url', 'length', 'duration', 'link', 'category', 'i'])
    .string('i').alias('i', 'input').describe('i', 'input db')
    .string('o').alias('o', 'output').describe('o', 'output db file')
    .string('guid')
    .string('duration')
    .string('pubdate')
    .boolean('explicit')
    .default('type', 'audio/mpeg')
    .describe('type', 'Podcast type')
    .describe('description', 'Podcast description')
    .argv

fs = require 'fs'
moment = require 'moment'
 
shows = JSON.parse fs.readFileSync(argv.i).toString()

#date = moment argv.pubdate, "YYYYMMDDHHmmssZZ"

explicit = 'no'
explicit = 'yes' if argv.explicit

newShow =
    title: argv.title
    "itunes:author": argv.author
    description: argv.description || null
    "itunes:subtitle": argv.subtitle
    summary: argv.summary || null
    enclosure:
        url: argv.url
        length: argv.length
        type: argv.type
    link: argv.link
    guid: argv.guid
    pubDate: argv.pubdate
    category: argv.category
    "itunes:explicit": explicit
    "itunes:duration": argv.duration

#date.format 'ddd DD MMM YYYY HH:mm:ss ZZ'

search = shows.filter (show) -> show.guid == argv.guid
if search.length != 0
    console.log 'Same GUID error'
    return 1

shows.push newShow

output = argv.i
output = argv.o if argv.o 

fs.writeFile output, JSON.stringify(shows), (err) ->
    throw err if err
    console.log 'Podcast has been added succesfully'
