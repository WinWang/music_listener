// function getParameterByName(name, url) {
//   if (!url) url = window.location.href;
//   name = name.replace(/[\[\]]/g, '\\$&'); // eslint-disable-line no-useless-escape
//   const regex = new RegExp(`[?&]${name}(=([^&#]*)|&|#|$)`);
//
//   const results = regex.exec(url);
//   if (!results) return null;
//   if (!results[2]) return '';
//   return decodeURIComponent(results[2].replace(/\+/g, ' '));
// }

class MusicUtil {
  void getParameterByName(String name, String url) {
    name = name.replaceAll("/[[]]/g", "\\&");
    var regExp = RegExp("[?&]${name}(=([^&#]*)|&|#|)");
    var results = regExp.stringMatch(url);
  }
}
