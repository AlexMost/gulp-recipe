Q = require 'q'
{get_recipe_data} = require 'recipejs'
l = require 'lodash'

process_module = (recipe, opts, module, cb) ->


process_file = (recipe, opts, file, cb) ->


process_bundle = (recipe, modules, bundle, cb) ->


run_sequence = (recipe_path, opts, cb) ->
    q_data = Q.nfcall get_recipe_data, recipe_path
    q_data.then ({recipe, modules, bundles}) ->
        modulesMap = l.groupBy modules, ({name}) -> name
        bundles.map (bundle) ->
            bundle_modules = bundle.modules.map (m) -> modulesMap[m]
            console.log bundle_modules
#            Q.nfcall process_bundle recipe,
        cb()

module.exports = {run_sequence}
