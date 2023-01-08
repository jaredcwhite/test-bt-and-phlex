class Builders::InlinePhlex < SiteBuilder
  def build
    helper :phlex do |**kwargs, &block|
      hlps = helpers

      phlex_component = Class.new(Phlex::HTML)

      phlex_component.define_method :initialize do
        kwargs.each do |k, v|
          instance_variable_set(:"@#{k}", v)
        end
      end

      phlex_component.define_method :template, &block

      phlex_component.define_method :helpers do
        @helpers ||= hlps
      end

      hlps.view.render phlex_component.new
    end
  end
end
