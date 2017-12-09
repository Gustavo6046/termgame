clear = require('clear')
CES = require('ces')
TextRenderer = require('./render.coffee')

require('keypress')(process.stdin)

module.exports = class GameContext
    constructor: (@entities = []) ->
        @world = new CES.World()
        @renderer = new TextRenderer()

        systems = [
            @inputSystem = CES.System.extend({
                addedToWorld: (world) ->
                    process.stdin.on('keypress', (key, char) ->
                        @world.getEntities('input').foreach((ent) ->
                            ent.getComponent('input').keyPress(key, char)
                        )
                    )
            })

            @drawSystem = CES.System.extend({
                addedToWorld: (world) =>
                    world.renderer = @renderer

                update: (_) ->
                    renderer = @world.renderer

                    @world.getEntities('sprite', 'drawPos', 'drawMasked').foreach((ent) ->
                        renderer.drawObject({
                            x: (pos = ent.getComponent('drawPos')).x
                            y: pos.y
                            sprite: {
                                data: ent.getComponent('sprite')
                                masked: ent.getComponent('drawMasked')
                            }
                        })
                    )

                    clear()
                    console.log(@renderer.flush('\n'))
            })
        ]

        for system in systems
            @world.addSystem(system)

    spawn: (entity) =>
        @world.addEntity(entity)

    tick: (dt) =>
        time = Date.now()
        @world.update((time - (@last or time)) / 1000)
        @last = Date.now()