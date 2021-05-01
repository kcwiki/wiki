$('#mw-content-text').contents().filter(function() {
  if (this.nodeType == 8)  {
        return (this.data.indexOf("Saved") > 0 ||
            this.data.indexOf("NewPP") > 0);
  } else return false;
}).replaceWith(function() {
  return "<pre>" + this.data + "</pre>";
});