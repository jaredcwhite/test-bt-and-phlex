class Builders::InlinePhlex < SiteBuilder
  def build
    helper :phlex
  end

  def phlex(**kwargs, &block)
    phlex_component = Class.new(Phlex::Component)

    phlex_component.define_method :initialize do
      kwargs.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
    end

    phlex_component.define_method :template, &block

    site = self.site

    phlex_component.define_method :helpers do
      @helpers ||= Bridgetown::RubyTemplateView::Helpers.new(self, site)
    end

    phlex_component.new.().html_safe
  end
end
