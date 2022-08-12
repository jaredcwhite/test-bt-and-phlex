require "phlex"

class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builders
end

module Phlex
  module Bridgetown
    VIEW_CONTEXT = Class.new(::Bridgetown::ERBView) # need to figure out how to avoid hard-coding

    module Renderable
      def render(...)
        convertible = HashWithDotAccess::Hash.new({
          data: {},
          site: respond_to?(:site) ? site : ::Bridgetown::Current.site,
        })
        @_target << VIEW_CONTEXT.new(convertible).render(...)
      end

      def render_in(context, *args, **kwargs, &)
        if block_given?
          content = context.capture(&)
          @_content = Phlex::Block.new(self) { @_target << content }
        end

        call.html_safe
      end

      def format
        :html
      end
    end
  end
end

Phlex::Context.include(Phlex::Bridgetown::Renderable)