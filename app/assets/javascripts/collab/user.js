Collab.models.UserModel = function(model) {
  var self = this;

  self.userId = guid();
  self.email = '';
  self.name = '';
  
  self.init = function(model) {
    if(model) {
      self.userId = model.id;
      self.email = model.email;
      self.name = model.name;
    }
  }

  self.init(model);
};