import { GluegunToolbox } from 'gluegun'

module.exports = {
  name: 'init',
  alias: ['i'],
  run: async (toolbox: GluegunToolbox) => {
    const {
      template: { generate },
      print: { info }
    } = toolbox
    const { options } = toolbox.parameters

    if (!options.outputDir && process.env.NODE_ENV === 'test') {
      return toolbox.print.error('outputDir must be defined in TEST mode')
    }

    const destFolder = options.outputDir ? `${options.outputDir}/` : ''

    await Promise.all([
      generate({
        template: 'Explorer.elm.ejs',
        target: `${destFolder}src/Explorer.elm`,
        props: {}
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
      })
    ])
    if (process.env.NODE_ENV !== 'test') {
      await toolbox.system.run('npm i')
    }

    info(`Generated your ui-explorer`)
  }
}
