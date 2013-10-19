Collab.models.IdeaModel = function (model) {
	var self = this;

	self.ideaId = guid();
	self.content = ko.observable('');

	self.addIdeaComment = function () {

	};

	self.content.subscribe(function () {
		console.log("save idea");
	});

	self.init = function (model) {
		if (model) {
			self.ideaId = model.id;
			self.content(model.content)
		}
	}

	self.init(model);
};