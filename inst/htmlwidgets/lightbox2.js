HTMLWidgets.widget({
  name: 'lightbox2',
  type: 'output',
  factory: function(el, width, height) {
    lightbox.option({
      "wrapAround": true
    });

    var thumbnailImgFactor = function(image, gallery, tnImage, tnTitle, tnWidth, tnHeight) {
      return $("<a/>", {
        href: image,
        "data-lightbox": gallery,
        // added text-decoration: none to anchors since a small blue line was appearing on hover
        style: "text-decoration: none;",
        html: $("<img/>", {
          src: tnImage,
          title: tnTitle,
          alt: tnTitle,
          // images' width and height need to be in style attribute - R markdown was overwriting it when they were attributes
          style: `margin-right: 3px; margin-bottom: 3px; width: ${tnWidth}; height: ${tnHeight};`
        })
      });
    };

    var lightboxImgFactory = function(containerId, images, gallery, tnImages, tnTitles, tnWidth, tnHeight, textAlign, maxHeight, margin) {
      var res = $("<div/>", {
        id: containerId,
        class: "lightbox-thumbnail-container",
        style: `overflow-y: auto; text-align: ${textAlign}; max-height: ${maxHeight}; margin: ${margin};`
      });

      var n = images.length;
      for (var i = 0; i < n; i++) {
        res.append(thumbnailImgFactor(
          image = images[i],
          gallery = gallery,
          tnImage = tnImages[i],
          tnTitle = tnTitles[i],
          tnWidth = tnWidth,
          tnHeight = tnHeight
        ));
      }

      return res;
    };

    var searchBarFactory = function(divId, inputId, buttonId) {
      return $("<div/>", {
        style: "margin-bottom: 5px; text-align: left;",
        id: divId,
        class: "lightbox-search-bar-container",
        html: [
          $("<input/>", {
            style: "margin-right: 5px;",
            id: inputId,
            title: "Filter images",
            type: "text",
            placeholder: "Search..."
          }),
          $("<button/>", {
            style: "font-size: 12pt; border: none; background-color: inherit;",
            id: buttonId,
            title: "Clear",
            html: "&times;"
          })
        ]
      });
    };

    return {
      renderValue: function(x) {
        var thisId = el.getAttribute("id");
        var gallery = x.gallery;

        if (!Array.isArray(x.images)) { // account for only 1 image. if only 1 image x.images is not an array!
          x.images = [x.images];
        }

        if (!Array.isArray(x.titles)) { // account for only 1 image. if only 1 image x.images is not an array!
          x.titles = [x.titles];
        }

        if (!Array.isArray(x.thumbnailImages)) { // account for only 1 image. if only 1 image x.images is not an array!
          x.thumbnailImages = [x.thumbnailImages];
        }

        // create a/img tags and add to the document in order
        var lbId = `lightbox-thumbnail-container-${gallery}`;
        $(`#${thisId}`).append(lightboxImgFactory(
          containerId = lbId,
          images = x.images,
          gallery = gallery,
          tnImages = x.thumbnailImages,
          tnTitles = x.titles,
          tnWidth = x.thumbnailWidth,
          tnHeight = x.thumbnailHeight,
          textAlign = x.thumbnailAlign,
          maxHeight = x.maxHeight,
          margin = x.margin
        ));

        // add search bar
        if (x.searchable) {
          // add search bar to page
          var sbInputId = `lightbox-search-bar-${gallery}`;
          var sbButtonId = `lightbox-search-bar-clear-${gallery}`;
          var sb = searchBarFactory(divId = `lightbox-search-bar-container-${gallery}`, inputId = sbInputId, buttonId = sbButtonId);
          $(`#${thisId}`).prepend(sb); // add search bar above el so it does not disappear when there is a scroll bar
          var allAs = $(`#${lbId}`).children("a");

          // search bar filter behavior
          $(`#${sbInputId}`).keyup(function() {
            var search = $(this).val().toUpperCase();

            var matchAs = allAs.filter(function(i, a) {
              var title = $(a).children().first().attr("title").toUpperCase();
              var hasSearch = title.indexOf(search) > -1;
              return hasSearch;
            });

            allAs.hide();
            matchAs.show();
          });

          // search bar clear behavior
          $(`#${sbButtonId}`).click(function() {
            $(this).siblings("input").val(""); // clear the input box
            allAs.show(); // show all <a>'s again
          });
        }
      },
      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
        //console.log("in resize"); // when does this happen?
      }
    };
  }
});
