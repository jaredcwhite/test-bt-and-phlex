class PhlexIt < Phlex::Component
  def initialize(title:)
    @title = title.upcase
  end

  def template
    section do
      h2 @title
      nav id: "main_nav" do
        ul do
          li { a "Home", href: "/" }
          li { a "About", href: helpers.absolute_url("/about") }
          li { a(href: "/contact") { _raw helpers.markdownify("Co **nta** ct").delete_prefix("<p>").delete_suffix("</p>") } }
        end
      end
      div do
        render "partially", lets: "rock!"
      end
    end
  end

  def site = Bridgetown::Current.site

  def helpers = @helpers ||= Bridgetown::RubyTemplateView::Helpers.new(self, site)
end
