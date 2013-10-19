Collab.models.IdeaModel = function (model) {
	var self = this;

	self.ideaId = guid();
	self.content = ko.observable('');
	self.editing = ko.observable(false);

	self.addIdeaComment = function () {

	};

	self.edit = function() { self.editing(true) }

	self.init = function (model) {
		if (model) {
			self.ideaId = model.id;
			self.content(model.content)
		}
	}

	self.init(model);

	self.content.subscribe(function () {
		Collab.viewModelLocator.themeVM.commitIdea(self);
	});
};