Collab.viewModels.ThemeViewModel = function () {
	var self = this;

	self.channel = null;
	self.themeId = null;
	self.themeTitle = null;
	self.ideas = ko.observableArray([]);
	self.members = ko.observableArray([]);
	self.newMemberEmail = ko.observable('');
	self.userSelection = ko.observableArray([]);

	self.commentIdea = ko.observable(new Collab.models.IdeaModel());

	self.ideaComments = ko.observableArray([]);
	self.newComment = ko.observable();
	self.openComments = ko.observable(false);

	self.addComment = function () {
		var commentsEndpoint = Mustache.to_html(Collab.constants.routes.ideaComments, {themeId: self.themeId, ideaId: self.commentIdea().ideaId});

		Collab.utils.callAjaxService(commentsEndpoint, 'post', {comment: {content: self.newComment()}}).done(function (data) {
			console.log(data)
			console.log(self.ideaComments());
			
			self.ideaComments.push(new Collab.models.CommentModel(data.comment));
		});
	};

	self.addMembers = function (user) {
		var membersEndpoint = Mustache.to_html(Collab.constants.routes.themeMembers, {themeId: self.themeId});

		Collab.utils.callAjaxService(membersEndpoint, 'post', {theme_member: {user_id: user.userId}}).done(function (data) {
			var member = new Collab.models.MemberModel(data.theme_member);

			self.members.push(member);
		});
	};

	self.searchMembers = function () {
		Collab.utils.callAjaxService(Collab.constants.routes.users, 'get', {email: self.newMemberEmail()}).done(function (data) {
			for (var i = 0; i < data.users.length; i++) {
				var user = new Collab.models.UserModel(data.users[i]);

				self.userSelection.push(user);
			}
		});
	};

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

	self.showIdeaComment = function (idea) {
		var commentsEndpoint = Mustache.to_html(Collab.constants.routes.ideaComments, {themeId: self.themeId, ideaId: idea.ideaId});

		Collab.utils.callAjaxService(commentsEndpoint, 'get').done(function (data) {
			var comments = data.comments;

			for (var i = 0; i < comments.length; i++) {
				var comment = comments[i];

				console.log(comment)

				self.ideaComments(comment);
			}
			console.log(idea);
			self.commentIdea(idea);

			self.openComments(true);
		});
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

		// set up pub/sub subscriptions
		self.channel = pusher.subscribe("theme-" + self.themeId);

		self.channel.bind('member-create', function(data) {
			console.log('theme#member-create');
			console.log(data);
			var memberIds = ko.utils.arrayMap(self.members(), function(member) {
				return member.memberId;
			});
			// if we don't have it yet, add it
			if($.inArray(data.theme_member.id, memberIds) == -1) {
				self.members.push(new Collab.models.MemberModel(data.theme_member));
			}
		});

		self.channel.bind('member-remove', function(data) {
			console.log('theme#member-remove');
			console.log(data);
			// TODO
		});

		/*
		self.channel.bind('group-create', function(data) {
			console.log('theme#group-create');
			console.log(data);
			// TODO
		});

		self.channel.bind('group-remove', function(data) {
			console.log('theme#group-remove');
			console.log(data);
			// TODO
		});
		*/

		self.channel.bind('idea-create', function(data) {
			console.log('theme#idea-create');
			console.log(data);
			var ideaIds = ko.utils.arrayMap(self.ideas(), function(idea) {
				return idea.ideaId;
			});
			// if we don't have it yet, add it
			if($.inArray(data.idea.id, ideaIds) == -1) {
				self.ideas.push(new Collab.models.IdeaModel(data.idea));
			}
		});

		self.channel.bind('idea-remove', function(data) {
			console.log('theme#idea-remove');
			console.log(data);
			var ideaIds = ko.utils.arrayMap(self.ideas(), function(i) { return i.ideaId });
			var index = $.inArray(data.idea.id, ideaIds);
			if(index != -1) {
				var idea = self.ideas.slice(index, index + 1).pop();
				self.ideas.remove(idea);
			}
		});

		self.channel.bind('update', function(data) {
			console.log('theme#update');
			console.log(data);
			// TODO
		});
	};

	self.init();
};

Collab.viewModelLocator.themeVM = new Collab.viewModels.ThemeViewModel();