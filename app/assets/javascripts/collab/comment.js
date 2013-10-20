Collab.models.CommentModel = function (model) {
	var self = this;

	self.content = ko.observable(model.content);
	self.commentId = ko.observable(model.id);
};