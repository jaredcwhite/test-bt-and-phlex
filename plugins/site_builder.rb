require "phlex"

class SiteBuilder < Bridgetown::Builder
  # write builders which subclass SiteBuilder in plugins/builders
end

# module Phlex
#   module Bridgetown
#     module Renderable
#       def render_in(view_context, &block)
#         if block_given?
#           content = view_context.capture(&block)
#         end
  
#         if content
#           call(view_context: view_context) { @_target << content }.html_safe
#         else
#           call(view_context: view_context).html_safe
#         end
#       end
#     end
#   end
# end

# Phlex::Context.include(Phlex::Bridgetown::Renderable)