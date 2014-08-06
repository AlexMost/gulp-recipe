{get_recipe_data} = require 'recipejs'
{run_sequence} = require '../src/recipe_sequence'


exports.test_basic_bundle = (test) ->
    recipe_filename = './test/fixtures/test_bundling/recipe.yaml'
    run_sequence recipe_filename, {}, (err, result) ->
        console.log 'here'
        test.done()