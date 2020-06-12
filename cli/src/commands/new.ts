import { GluegunToolbox } from 'gluegun'
import * as path from 'path'

module.exports = {
  name: 'new',
  alias: ['n'],
  run: async (toolbox: GluegunToolbox) => {
    const {
      parameters,
      template: { generate },
      print: { info }
    } = toolbox
    const { options } = toolbox.parameters
    const name = parameters.first || 'Elm Ui Explorer'
    const templatesDir = path.join(__dirname, '..', 'templates')
    const logoSource = `${templatesDir}/elm-logo.png`

    if (!name) {
      return toolbox.print.error('Please provide a name of your')
    }

    if (!options.outputDir && process.env.NODE_ENV === 'test') {
      return toolbox.print.error('outputDir must be defined in TEST mode')
    }

    const destFolder = options.outputDir ? `${options.outputDir}/` : ''
    console.log('logoSource', logoSource)
    console.log('env', process.env.NODE_ENV)
    await Promise.all([
      generate({
        template: 'Explorer.elm.ejs',
        target: `${destFolder}src/Explorer.elm`,
        props: { name }
      }),
      generate({
        template: 'elm.json.ejs',
        target: `${destFolder}elm.json`
      }),
      generate({
        template: 'package.json.ejs',
        target: `${destFolder}package.json`
      }),
      generate({
        template: 'index.html.ejs',
        target: `${destFolder}public/index.html`
      }),
      toolbox.filesystem.copyAsync(logoSource, 'public/logo.png', {
        overwrite: true
      })
    ])

    info(`Generated your ui-explorer`)
  }
}
