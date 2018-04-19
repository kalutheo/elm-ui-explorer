#!/usr/bin/env node

const glob = require("glob");
const elmStaticHtml = require("elm-static-html-lib");
const fs = require("fs-extra");
const path = require("path");

const dir = "snapshot-tests";
const dirPath = path.join(process.cwd(), dir);

// options is optional
const options = {};
const R = require("ramda");

const getStoriesViews = configs => {
  return new Promise(resolve => {
    elmStaticHtml
      .multiple(__dirname, configs)
      .then(generatedHtmls => {
        resolve(generatedHtmls);
      })
      .catch(e => console.log(e));
  });
};

glob("**/*Stories.elm", options, async function(er, files) {
  if (er) {
    console.log("er", er);
  }

  const pathToElmModule = R.compose(
    R.dropLast(4),
    R.join("."),
    R.tail,
    R.split("/")
  );

  const elmModules = R.map(pathToElmModule, files);
  const configs = R.map(r => ({
    viewFunction: `${r}.viewSnapshot`,
    fileOutputName: r
  }))(elmModules);

  const generatedHtmls = await getStoriesViews(configs);
  console.log("stories", generatedHtmls);
  if (!fs.pathExists(dirPath)) {
    fs.mkdirSync(dirPath);
  }

  generatedHtmls.map(output => {
    const content = `
    const tree = \`${output.generatedHtml}\`;
    test("${output.fileOutputName}", () => {
      expect(tree).toMatchSnapshot();
    });
    `;
    const file = dirPath + "/" + output.fileOutputName + ".test.js";
    if (fs.pathExists(file)) {
      fs.removeSync(file);
    }
    fs.writeFileSync(file, content);
  });

  // files is an array of filenames.
  // If the `nonull` option is set, and nothing
  // was found, then files is ["**/*.js"]
  // er is an error object or null.
});
