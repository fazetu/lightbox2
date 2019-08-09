HTMLWidgets.widget({
  name: 'lightbox2',
  type: 'output',
  factory: function(el, width, height) {
    lightbox.option({
      "wrapAround": true
    });

    return {
      renderValue: function(x) {
        // decompose x
        var images = x.images;
        var n = images.length;
        var tnImages = x.thumbnailImages;
        var gallery = x.gallery;
        var titles = x.titles;
        var tna = x.thumbnailAlign;
        var tnw = x.thumbnailWidth;
        var tnh = x.thumbnailHeight;
        var mh = x.maxHeight;
        var margin = x.margin;

        // create tags and add to the document in order
        for (var i = 0; i < n; i++) {
          var image = images[i];
          var tnImage = tnImages[i];
          var title = titles[i];

          // added text-decoration:none to anchors since a small blue line was appearing on hover
          // images' width and height need to be in style attribute - R markdown was overwriting it when they were attributes
          $(`#${el.getAttribute("id")}`).append(`
            <a href="${image}" data-lightbox="${gallery}" style="text-decoration:none;">
              <img src="${tnImage}" title="${title}" alt="${title}" style="width:${tnw};height:${tnh};">
            </a>
          `);
        }

        el.style.textAlign = tna;
        el.style.maxHeight = mh;
        el.style.overflowY = "auto";
        el.style.margin = margin;
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
        //console.log("in resize"); // when does this happen?
      }
    };
  }
});
