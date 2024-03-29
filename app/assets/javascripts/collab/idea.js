Collab.models.IdeaModel = function (model) {
	var self = this;

	self.channel = null
	self.ideaId = guid();
	self.themeId = null;
	self.groupId = null;
	self.content = ko.observable('');
	self.editing = ko.observable(false);

	self.addIdeaComment = function () {

	};

	self.edit = function() { self.editing(true) }

	self.addComment = function (comment) {
		Collab.viewModelLocator.themeVM.pushComment(comment, self.ideaId);
	};

	self.init = function (model) {
		if (model) {
			self.ideaId = model.id;
			self.themeId = model.theme_id;
			self.groupId = model.group_id;
			self.content(model.content);

			self.channel = pusher.subscribe("theme-" + self.themeId + "-idea-" + self.ideaId);

			self.channel.bind('comment-create', function(data) {
				console.log('idea#comment-create');
				console.log(data);
				
				self.addComment(data.comment)
			});

			self.channel.bind('update', function(data) {
				console.log('idea#update');
				console.log(data);
				self.content(data.idea.content);
			});
		}
	}

	self.init(model);

	self.editing.subscribe(function (newValue) {
		if(!newValue) {
			Collab.viewModelLocator.themeVM.commitIdea(self);
		}
	});
};