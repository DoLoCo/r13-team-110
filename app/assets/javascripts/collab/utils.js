// ES5 15.4.4.14
// http://es5.github.com/#x15.4.4.14
// https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/indexOf
if (!Array.prototype.indexOf || ([0, 1].indexOf(1, 2) != -1)) {
    Array.prototype.indexOf = function indexOf(sought /*, fromIndex */ ) {
        var self = splitString && _toString(this) == "[object String]" ?
                this.split("") :
                toObject(this),
            length = self.length >>> 0;

        if (!length) {
            return -1;
        }

        var i = 0;
        if (arguments.length > 1) {
            i = toInteger(arguments[1]);
        }

        // handle negative indices
        i = i >= 0 ? i : Math.max(0, length + i);
        for (; i < length; i++) {
            if (i in self && self[i] === sought) {
                return i;
            }
        }
        return -1;
    };
}

function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
}

function guid() {
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
}

ko.bindingHandlers.slide = {
	init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
		var $element = $(element),
			bindingOptions = ko.utils.unwrapObservable(valueAccessor());

		if (!bindingOptions.toggle()) {
			$element.hide();
		}

		bindingOptions.toggle.subscribe(function (value) {
			if (value) {
				$(element).css('visibility', 'visible');
			} else {
				$(element).css('visibility', 'hidden');
			}
			$(element).animate({width:'toggle'},350);
		});
	}	
};

(function (utils, undefined) {
	var $doc = $(document),
		$contentModal = $('#content-modal');

	utils.callAjaxService = function (route, type, data) {
		$doc.css('cursor', 'wait');

		var srvcCall = $.ajax({
							'url': route,
							'type': type,
							'data': data,
							'dataType': 'json'
						});

		srvcCall.done(function () {
			$doc.css('cursor', 'default');
		}).fail(function (data) {
			alert(data);
		});

		return srvcCall;
	};

	utils.showContentModal = function (title, content, onOpen) {
		$contentModal.find('#conent-modal-lbl').text(title);
		$contentModal.find('.modal-body').html(content);

		$contentModal.one('show', function () {
			if (onOpen)
				onOpen();
		});

		$contentModal.modal('show');
	};

	utils.hideContentModal = function () {
		$contentModal.modal('hide');
	};

})(Collab.utils = Collab.utils || {});