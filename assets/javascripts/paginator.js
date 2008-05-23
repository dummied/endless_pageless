function getMoreHistory() {
	var indexVal = $("items_index").value;
	var params = "page=" + (parseInt(indexVal) + 1);
	if ((indexVal < $("total_pages").value) && (parseInt($("total_pages").value) > 1)) {
		new Ajax.Request(document.location, {asynchronous:true, method: 'post', onComplete: addMoreHistory, onFailure: failure, parameters: params});
	}
}

function failure() {
	$("no_results").innerHTML = "<p><strong>Could not contact the server.</strong><br />Please wait awhile and try again. <br /><br />We apologize for the inconvenience.</p>";
}

function addMoreHistory(ajax){
	var response = ajax.responseText;

	if (response == "No results!") {
		Element.show("no_results");
		Element.hide("more_loading");
	} else {
		if (parseInt($("total_pages").value) == 1) {
			Element.hide("more_loading");
			Element.hide("page_end");
		} else {
			if (parseInt($("items_index").value) == (parseInt($("total_pages").value)) - 1) {
				Element.hide("more_loading");
				Element.show("page_end");
				$("items_index").value = parseInt($("items_index").value) + 1;
			} else {
				Element.show("more_loading");
				$("items_index").value = parseInt($("items_index").value) + 1;
			}
		}
	}
	
	isUpdating = false;
}

function updatePage(){
	if (isUpdating == false && mouseState == "up" && getPageHeight() - getScrollHeight() < preloadDistance) {
		isUpdating = true;
		getMoreHistory();
	}
	if (parseInt($("items_index").value) <= parseInt($("total_pages").value) && parseInt($("total_pages").value) != 1) {
		setTimeout("updatePage()", checkInterval);
	}
}

function onMouseDown(e ){
	mouseState = "down";
}

function onMouseUp(){
	mouseState = "up";
}

var checkInterval = 200;
var preloadDistance = 1000;
var isUpdating = false;
var mouseState = "up";
var id;

function init( ){
	document.onmousedown = onMouseDown;
	document.onmouseup = onMouseUp;

	if ($("page_id")) {
		id = $("page_id").value;
	
		$$("div.pageless_navigation").each(function(value, index) {
			value.remove();
		});

		$("items_index").value = 1;
		setTimeout("updatePage()", 0);
	}
}

Event.observe(window, 'load', init, false);

function getPageHeight(){
  var y;
  var test1 = document.body.scrollHeight;
  var test2 = document.body.offsetHeight
  if (test1 > test2) {
    y = document.body.scrollHeight;
  } else {
	  y = document.body.offsetHeight;
  }
  return parseInt(y);
}

function _getWindowHeight(){
  if (self.innerWidth) {
		frameWidth = self	.innerWidth;
		frameHeight = self.innerHeight;
  } else if (document.documentElement && document.documentElement.clientWidth) {
    frameWidth = document.documentElement.clientWidth;
    frameHeight = document.documentElement.clientHeight; 
  } else if (document.body) {
    frameWidth = document.body.clientWidth;
    frameHeight = document.body.clientHeight;
  }
  return parseInt(frameHeight);
}

function getScrollHeight(){
  var y;
  // all except Explorer
  if (self.pageYOffset) {
      y = self.pageYOffset;
  } else if (document.documentElement && document.documentElement.scrollTop) {
      y = document.documentElement.scrollTop;
  } else if (document.body)	{
      y = document.body.scrollTop;
  }
  return parseInt(y)+_getWindowHeight();
}