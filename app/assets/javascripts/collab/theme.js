(function (theme, undefined){
	var $doc = $(document),
		routes = {};

	function _bindDescTogle (btnEl) {
		var btnIcon = btnEl.find('i'),
			iconClass = btnIcon.attr('class');
			newIconClass = iconClass === "icon-double-angle-up" ? "icon-double-angle-down" : "icon-double-angle-up";

		$('.theme-desc').slideToggle();

		btnIcon.attr('class', newIconClass);
	}

	$doc.on('click', '#add-idea', function (e) {
		e.preventDefault();

		Collab.idea.openAddIdeaModal();
	});

	$doc.on('click', '#desc-toggle', function (e) {
		e.preventDefault();

		_bindDescTogle($(this));
	});
})(Collab.theme = Collab.theme || {});