###ruby
front_matter do
  layout :page
  title "Phlex This!"
end
###

phlex title: "Fantastic!" do
  article class: "callout" do
    render PhlexIt.new(title: @title)
  end
end
