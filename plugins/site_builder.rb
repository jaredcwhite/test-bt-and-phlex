require "phlex"

class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builders
end

ViewForPhlex = Class.new(Bridgetown::ERBView) # need to figure out how to avoid hard-coding

module Phlex
  module Bridgetown
    module Context
      def render(partial = nil, **kwargs)
        if @_rendering || @_rendering_block
          convertible = HashWithDotAccess::Hash.new({
            data: {},
            site: respond_to?(:site) ? site : Bridgetown::Current.site,
          })
          _raw ViewForPhlex.new(convertible).render(partial, locals: kwargs)
        else
          call.html_safe
        end
      end

      def render_in(context, *args, **kwargs, &)
        if block_given?
          content = context.capture(&)
          @_content = Phlex::Block.new(self) { _raw content }
        end

        render
      end

      def format
        :html
      end
    end
  end
end

Phlex::Context.include(Phlex::Bridgetown::Context)