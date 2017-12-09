ComponentPool = require('./components')
CES = require('ces')

module.exports.EntityTemplateHolder = class EntityTemplateHolder
    constructor: (@templates = {}) ->

    template: (name, template) =>
        return (template and (@templates[name] = template)) or @templates[name]

    spawn: (name, properties = {}) =>
        if name not of @templates
            throw new Error("Tried to spawn entity of unknown template:  '#{name}'")

        return @templates[name].spawn(properties)

module.exports.EntityTemplate = class EntityTemplate
    constructor: (@components = []) ->

    addComponent: (component) =>
        @components.push(component)

    spawn: (properties) =>
        e = new CES.Entity()

        for c in @components
            e.addComponent(new c(properties[c.name]))

        return e