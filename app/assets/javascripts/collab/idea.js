(function (idea, undefined){
	var $doc = $(document),
		routes = {
			create: '/api/themes/1/ideas'
		},
		_addIdeaTmpl = '<form class="form-horizontal">\
							<div class="control-group">\
								<label class="control-label">Idea Text</label>\
								<div class="control">\
									<textarea id="idea-txt"></textarea>\
								</div>\
							</div>\
							<div class="form-actions">\
								<button class="btn btn-success" id="add-idea-txt">Add Idea</button>\
							</div>\
						</form>',
		_ideaTmpl = '<li class="span3">\
					    <span class="thumbnail">{{ content }}</span>\
					  </li>'

	idea.openAddIdeaModal = function (){
		Collab.utils.showContentModal('Add Idea', _addIdeaTmpl, function () {
			$doc.one('click', '#add-idea-txt', function (e) {
				e.preventDefault();

				var ideaTxt = $('#idea-txt').val(),
					ideaHtml = Mustache.to_html(_ideaTmpl, {content: ideaTxt});

				Collab.utils.callAjaxService(routes.create, 'post', {idea: {content: ideaTxt}}).done(function (data) {
					$('#idea-list').append(ideaHtml);

					Collab.utils.hideContentModal();
				});
			});
		});
	};
})(Collab.idea = Collab.idea || {});