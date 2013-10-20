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
				if(Collab.viewModelLocator.themeVM.commentIdea().ideaId == self.ideaId) {
					var comments = Collab.viewModelLocator.themeVM.ideaComments();
					var commentIds = ko.utils.arrayMap(comments, function(c) {
						return c.commentId();
					});

					if($.inArray(commentIds, data.comment.id) == -1) {
						var comment = new Collab.models.CommentModel(data.comment);
						Collab.viewModelLocator.themeVM.ideaComments.push(comment);
					}
				}
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