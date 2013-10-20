class ThemeMemberMailer < ActionMailer::Base
  default from: "notifications@thecrystalship.r13.railsrumble.com"

  def added_to_theme_email(theme, theme_member)
    @theme = theme
    @theme_member = theme_member
    mail(to: @theme_member.email, subject: 'You have been added as a collaborator to a project theme!')
  end
end
