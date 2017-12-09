module.exports = class TextMap
    constructor: (@width = 80, @height = 45) ->
        @clear()

    set: (x, y, sprite, maskSpace = true) =>
        sprite = sprite.replace(/\r/g, '')

        for t in sprite.split('\n')
            if y > @height
                return

            ix = x

            for c in t
                if ix >= @width
                    continue

                if c isnt ' ' or not maskSpace
                    @text[y] = @text[y].slice(0, ix) + c + @text[y].slice(++ix)

                else
                    ix++

            y++

    render: (linesep = '\n') =>
        return @text.join(linesep)

    clear: =>
        @text = (' '.repeat(@width) for _ in [0...@height])