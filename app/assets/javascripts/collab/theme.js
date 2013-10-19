Collab.viewModels.ThemeViewModel = function () {
	var self = this;


	self.themeId = null;
	self.themeTitle = null;
	self.ideas = ko.observableArray([]);

	self.addIdea = function () {
		self.ideas.push(new Collab.models.IdeaModel());
	};

	self.removeIdea = function (idea) {
		self.ideas.remove(idea);
	};

	self.init = function () {
		var dataModel = $('[data-theme]').data('theme'),
			theme = dataModel.theme,
			ideas = theme.ideas;

		self.themeId = theme.id;
		self.themeTitle = theme.title;

		for (var i = 0; i < ideas.length; i++) {
			self.ideas.push(new Collab.models.IdeaModel(ideas[i]));
		}
	};

	self.init();
};

Collab.viewModelLocator.themeVM = new Collab.viewModels.ThemeViewModel();