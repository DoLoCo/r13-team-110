function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
}

function guid() {
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
}

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