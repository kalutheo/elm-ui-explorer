const {Client}  = require('figma-js')
const token = 'xxxx';
const R = require("ramda")

const client = Client({
  personalAccessToken: token
});

const result = {}
const findObjectByLabel = (obj) => {
    R.map(item =>{
      if (item.styles) {
        result[item.styles.fill] = item
        return item
      } else if (item.children) {
        findObjectByLabel(item.children)
      } else {
        return item
      }
    }, obj)
};

client.file('LIuCW7SxwiNb3pxOp5kKueXA').then(({ data }) => {

  const styles = R.compose(
    R.map(id =>
      ({
        id,
        ...R.compose(
          R.prop(id),
          R.prop("styles")
        )(data)
      })
    ),
    R.keys,
  )(data.styles)

  findObjectByLabel(data.document.children)
  console.log("******")
  console.log(JSON.stringify(
    R.map(s => ({
      ...s,
      fills: result[s.id].fills
    }), styles)
  ))
}).catch(e => {
  console.log({e})
})
