// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";

import "materialize-css"

document.addEventListener('DOMContentLoaded', function () {
  var elems_nav = document.querySelectorAll('.sidenav');
  M.Sidenav.init(elems_nav, {});

  var elems_select = document.querySelectorAll('select');
  M.FormSelect.init(elems_select, {});
});


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
