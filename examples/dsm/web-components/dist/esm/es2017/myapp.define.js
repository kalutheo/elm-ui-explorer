
// MyApp: Custom Elements Define Library, ES Module/es2017 Target

import { defineCustomElement } from './myapp.core.js';
import { COMPONENTS } from './myapp.components.js';

export function defineCustomElements(win, opts) {
  return defineCustomElement(win, COMPONENTS, opts);
}
