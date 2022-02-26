#!/usr/bin/env node
var glob = require('glob')
var fs = require('fs')
var marked = require('marked').marked
var template = fs.readFileSync(__dirname + '/template.html', 'utf8')

glob.sync('{./,**/*/}README.markdown').forEach(function (mdfile) {
  var target = mdfile.replace(/README.markdown$/, 'index.html')
  var targetStat
  try {
    targetStat = fs.statSync(target)
  } catch (er) {}

  var mdstat = fs.statSync(mdfile)
  if (targetStat && targetStat.mtime >= mdstat.mtime) {
    console.error('skipping %s, already up to date', target)
    return
  }

  var md = fs.readFileSync(mdfile, 'utf8')
  var title = md.match(/^#([^#].*)$/m)
  if (title) {
    title = title[1].trim()
  }
  if (!title) {
    title = '(untitled)'
  }

  var out = template
    .split('{{TITLE}}').join(title)
    .split('{{HTML}}').join(marked(md))

  fs.writeFileSync(target, out, 'utf8')
  console.error('ok ' + target)
})
