const ElmUIExplorer = {};

ElmUIExplorer.handleMode = function(mode) {
  const darkLink = document.getElementById("uie-dark-theme");
  if (darkLink) {
    darkLink.remove();
  }
  if (mode === "Dark") {
    const link = document.createElement("link");
    const head = document.getElementsByTagName("head")[0];
    link.rel = "stylesheet";
    link.href =
      "https://cdn.rawgit.com/tylingsoft/markdown-plus-themes/0.0.3/dark/index.css";
    link.id = "uie-dark-theme";
    link.type = "text/css";
    head.appendChild(link);
  }
};

window.ElmUIExplorer = ElmUIExplorer;
