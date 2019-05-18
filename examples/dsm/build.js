const StyleDictionary = require('style-dictionary').extend(__dirname + '/config.json');
const handlebars = require('handlebars');
const fs = require("fs")
const helpers = require('handlebars-helpers')();

// In this case we are using an alternative templating engine (Handlebars)
const templateCustom = handlebars.compile(fs.readFileSync(__dirname + '/templates/colors-elm.hbs', 'utf8'));



function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
}



handlebars.registerHelper('elmColor', function(name, value, kind) {
  const {r, g, b} =  hexToRgb(value)
  return new handlebars.SafeString(
    `
      ${helpers.pascalcase(kind)}
          (${helpers.pascalcase(name)}
              { name = "${name}"
              , color = RawColor.rgb255 ${r} ${g} ${b}
              }
          )
    `
  );
});

StyleDictionary.registerFormat({
  name: 'custom/format/elm',
  formatter: function(dictionary, platform) {

    console.log(JSON.stringify(dictionary.properties, null, 3))
    return templateCustom({
      // this is just to show that the formatter function takes a "dictionary" and "platform" parameters
      // (and dictionary has a "properties" and "allProperties" attributes)
      // and returns a string. for more details about the "formatter" function refer to the documentation
      brandColors : dictionary.properties.color.brand,
      neutralColors : dictionary.properties.color.neutral,
      allProperties: dictionary.allProperties,
      properties: dictionary.properties,
      options: platform
    });
  }
});


StyleDictionary.buildAllPlatforms();
