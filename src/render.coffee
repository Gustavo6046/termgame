figlet = require('figlet')
TextMap = require('./textmap')

module.exports = class TerminalRenderer
    constructor: (@width = process.stdout.columns, @height = process.stdout.rows, @background = '') ->
        @map = new TextMap(@width, @height)
        @map.set(0, 0, @background, false)

    drawObject: (obj) =>
        @map.set(obj.x, obj.y, obj.sprite.data, obj.sprite.masked)

    drawText: (x, y, text) =>
        @map.set(x, y, text)

    drawBigText: (x, y, text, font = null, masked = true) =>
        @map.set(x, y, figlet.textSync(text, font and "figlet/#{font}"), masked)

    drawBox: (x, y, width, height, style = { corner: '+', horz: '-', vert: '|', mid: ' ' }) =>
        c = style.corner
        h = style.horz
        v = style.vert
        m = style.mid

        box = [c + h.repeat(Math.max(width - 2, 0)) + (if width > 1 then c else '')]

        for h in [0...--height]
            box.push(v + m.repeat(Math.max(width - 2, 0)) + (if width > 1 then v else ''))

        if height > 0
            box.push(c + h.repeat(Math.max(width - 2, 0)) + (if width > 1 then c else ''))

        @map.set(x, y, box.join('\n'))

    flush: (line_separator = '\n') =>
        res = @map.render(line_separator)
        @map.clear()
        @map.set(0, 0, @background, false)

        return res