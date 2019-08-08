HTMLWidgets.widget({
  name: 'lightbox2',
  type: 'output',
  factory: function(el, width, height) {
    lightbox.option({
      "wrapAround": true
    });

    return {
      renderValue: function(x) {
        var images = x.images; // these are full paths to images
        var titles = x.titles;
        var tnw = x.thumbnailWidth;
        var tnh = x.thumbnailHeight;

        // create tags and add to the document in order.
        // <a href="image" data-lightbox="gallery">
        //   <img src="image" width="thumbnailWidth" height="thumbnailHeight">
        // </a>

        for (var i = 0; i < images.length; i++) {
          var image = images[i];
          var title = titles[i];
          $("#" + el.getAttribute("id")).append("<a href='"+image+"' data-lightbox='lb-gallery'><img src='"+image+"' alt='"+title+"' title='"+title+"' width='"+tnw+"' height='"+tnh+"'></a>");
        }

        el.style.width = "100%"; // add 100% width for Rmarkdown html output
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
        // when does this happen?
        console.log("in resize");
      }
    };
  }
});
