(function (utils, undefined) {
	var $doc = $(document);

	utils.callAjaxService = function (route, type, data) {
		$doc.css('cursor', 'wait');

		var srvcCall = $.ajax({
							'url': route,
							'type': type,
							'data': data
						});

		srvcCall.done(function () {
			$doc.css('cursor', 'default');
		}).fail(function (data) {
			alert(data);
		});

		return srvcCall;
	};

	utils.showContentModal = function (title, content, onOpen) {
		var modalEl = $('#content-modal');

		modalEl.find('#conent-modal-lbl').text(title);
		modalEl.find('.modal-body').html(content);

		modalEl.one('show', function () {
			if (onOpen)
				onOpen();
		});

		modalEl.modal('show');
	};

})(Collab.utils = Collab.utils || {});