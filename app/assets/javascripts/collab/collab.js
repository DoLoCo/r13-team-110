var Collab = Collab || {};

Collab.viewModelLocator = {};
Collab.viewModels = {};
Collab.models = {};

Collab.constants = {};
Collab.constants.routes = {
	users: '/api/users/search',
	themeIdeas: '/api/themes/{{ themeId }}/ideas',
	themeIdea: '/api/themes/{{ themeId }}/ideas/{{ ideaId }}',
	themeMembers: '/api/themes/{{ themeId }}/members',
	ideaComments: '/api/themes/{{ themeId }}/ideas/{{ ideaId }}/comments'
};