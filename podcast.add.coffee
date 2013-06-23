argv = require('optimist')
    .demand(['guid', 'author', 'title', 'subtitle', 'pubdate', 'url', 'length', 'duration', 'link', 'category'])
    .string('guid')
    .string('itunes:duration')
    .string('pubdate')
    .boolean('explicit')
    .default('type', 'audio/mpeg')
    .describe('type', 'Podcast type')
    .describe('description', 'Podcast description')
    .argv
    
shows = require './shows.json'
moment = require 'moment'

date = moment argv.pubdate, "YYYYMMDDHHmmssZZ"

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
    pubDate: date.format 'ddd DD MMM YYYY HH:mm:ss ZZ'
    category: argv.category
    "itunes:explicit": explicit
    "itunes:duration": argv.duration


console.log newShow