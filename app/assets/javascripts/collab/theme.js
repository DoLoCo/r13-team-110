Collab.viewModels.ThemeViewModel = function () {
	var self = this;

	self.themeId = null;
	self.themeTitle = null;
	self.ideas = ko.observableArray([]);
	self.members = ko.observableArray([]);

	self.addIdea = function () {
		var ideasEndpoint = Mustache.to_html(Collab.constants.routes.themeIdeas, {themeId: self.themeId});
		
		Collab.utils.callAjaxService(ideasEndpoint, 'post', {idea: {content: 'New Idea'}}).done(function (data) {
			var idea = new Collab.models.IdeaModel(data.idea);

			self.ideas.push(idea);

			idea.editing(true);
		});
	};

	self.removeIdea = function (idea) {
		var ideaEndpoint = Mustache.to_html(Collab.constants.routes.themeIdea, {themeId: self.themeId, ideaId: idea.ideaId});
		
		Collab.utils.callAjaxService(ideaEndpoint, 'delete').done(function (data) {
			self.ideas.remove(idea);
		});
	};

	self.commitIdea = function (idea) {
		var ideaEndpoint = Mustache.to_html(Collab.constants.routes.themeIdea, {themeId: self.themeId, ideaId: idea.ideaId});

		Collab.utils.callAjaxService(ideaEndpoint, 'put', {idea: {content: idea.content()}});
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