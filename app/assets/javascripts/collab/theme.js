Collab.viewModels.ThemeViewModel = function () {
	var self = this;

	self.themeId = null;
	self.themeTitle = null;
	self.ideas = ko.observableArray([]);
	self.members = ko.observableArray([]);

	self.addIdea = function () {
		var ideaEndpoint = Mustache.to_html(Collab.constants.routes.createIdea, {themeId: self.themeId});
		
		Collab.utils.callAjaxService(ideaEndpoint, 'post', {idea: {content: 'New Idea'}}).done(function (data) {
			var idea = new Collab.models.IdeaModel(data.idea);

			self.ideas.push(idea);

			idea.editing(true);
		});
	};

	self.removeIdea = function (idea) {
		self.ideas.remove(idea);
	};

	self.init = function () {
		var dataModel = $('[data-theme]').data('theme'),
				theme 		= dataModel.theme,
				members 	= theme.theme_members,
				ideas 		= theme.ideas;

		self.themeId = theme.id;
		self.themeTitle = theme.title;

		for(var i = 0; i < members.length; i++) {
			self.members.push(new Collab.models.MemberModel(members[i]));
		}

		for (var i = 0; i < ideas.length; i++) {
			self.ideas.push(new Collab.models.IdeaModel(ideas[i]));
		}
	};

	self.init();
};

Collab.viewModelLocator.themeVM = new Collab.viewModels.ThemeViewModel();