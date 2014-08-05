{get_recipe_data} = require 'recipejs'
fs = require 'fs'
path = require 'path'
Q = require 'q'
bp = require 'browser-pack'
l = require 'lodash'
through = require 'through'


get_module_pack = (base_path, module, recipe, cb) ->
    modulesMap = {}
    modulesMap[m.getName()] = m for m in recipe.modules

    mod = modulesMap[module]
    mod_path = path.join base_path, mod.getPath()

    fs.readFile mod_path, (err, source) ->
        cb err, {
            id: mod.getName()
            source: source.toString()
            deps: {}
        }


exports.test_basic_bundle = (test) ->
    recipe_filename = './test/fixtures/test_bundling/recipe.yaml'
    base_path = path.dirname recipe_filename

    pack = bp({hasExports: true})
    get_recipe_data recipe_filename, (err, recipe) ->
        bundle = recipe.recipe.bundles.bundle1
        q_module = (m) -> Q.nfcall get_module_pack, base_path, m, recipe
        Q.all(bundle.modules.map q_module).then (result) ->
            stream = through().pause().queue(JSON.stringify result).end()
            stream.pipe(pack).pipe(process.stdout)
            stream.resume()
            test.done()