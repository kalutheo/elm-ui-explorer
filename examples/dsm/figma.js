const {Client}  = require('figma-js')
const token = 'xx';
const R = require("ramda")

const client = Client({
  personalAccessToken: token
});

const result = {}
const findObjectByLabel = (obj, n ) => {

    R.map(item =>{
      const f = (item.type === 'FRAME' && item.name) ? item.name : n
      if (item.styles) {
        result[item.styles.fill] = {...item, frame: f}
        return item
      } else if (item.children) {
        findObjectByLabel(item.children, f)
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
      frame: result[s.id].frame,
      fills: result[s.id].fills
    }), styles)
  ))
}).catch(e => {
  console.log({e})
})
