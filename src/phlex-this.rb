###ruby
front_matter do
  layout :page
  title "Phlex This!"
end
###

phlex title: "Fantastic!" do
  article.callout do
    component PhlexIt, title: @title
  end
end
