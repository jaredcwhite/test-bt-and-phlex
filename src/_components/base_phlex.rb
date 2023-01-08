class BasePhlex < Phlex::HTML
  def site = Bridgetown::Current.site

  def helpers = @helpers ||= Bridgetown::RubyTemplateView::Helpers.new(self, site)
end
