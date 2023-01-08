class PhlexIt < BasePhlex
  def initialize(title:)
    @title = title.upcase
  end

  def template
    section do
      h2 { @title }
      nav id: "main_nav" do
        ul do
          li { a(href: "/") { "Home" } }
          li { a(href: helpers.absolute_url("/about")) { "About" } }
          li { a(href: "/contact") { unsafe_raw helpers.markdownify("Co **nta** ct").delete_prefix("<p>").delete_suffix("</p>") } }
        end
      end
      div do
        render "partially", lets: "rock!"
      end
    end
  end
end
