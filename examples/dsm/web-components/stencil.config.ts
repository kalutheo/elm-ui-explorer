import { Config } from "@stencil/core";

export const config: Config = {
  namespace: "MyApp",
  srcDir: "src",
  outputTargets: [
    {
      type: "dist"
    },
    {
      type: "www"
    }
  ]
};
