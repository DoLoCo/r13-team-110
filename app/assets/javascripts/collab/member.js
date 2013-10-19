Collab.models.MemberModel = function(model) {
  var self = this;

  self.memberId = guid();
  self.user = null;

  self.init = function(model) {
    if(model) {
      self.memberId = model.id;
      self.user = new Collab.models.UserModel(model.user);
    }
  }

  self.init(model);
};