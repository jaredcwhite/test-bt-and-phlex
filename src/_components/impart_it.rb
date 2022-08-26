class ImpartIt < Phlex::Component
  register_element :impart_it, :part_meta

  def initialize(title:, count: 1)
    @title = title.upcase
    @count = count
  end

  def template(&)
    impart_it count: @count.to_s do
      _raw web_component

      template_tag shadowroot: "open" do
        part_meta name: "count", reflect: "count", format: "number"
        part_meta name: "button", click_listener: "increment"

        style <<~CSS
          :host {
            display: block;
            opacity: 1;
            min-height: auto;
            padding-inline: 1rem;
          }

          :host(.yellow) {
            background: lightyellow;
          }

          [part=heading] {
            color: red;
            font-weight: bold;
          }

          [part=count] {
            color: green;
          }
          
          [part=heading] span {
            font-size: 150%; 
          }
          
          [part=button] {
            font-size: unset;
            padding: 0.75rem;
          }
        CSS

        p part: "heading" do
          text @title
          whitespace
          text "Count:"
          whitespace
          span @count.to_s, part: "count"
        end

        slot

        button part: "button" do
          text "Increment:"
          whitespace
          span @count.to_s, part: "count"
          whitespace
          text "+ 1"
        end
      end

      content(&)
    end

    style <<~CSS
      impart-it:not(:defined) {
        display: block;
        opacity: 0.5;
        min-height: 9.2rem;
      }
    CSS
  end

  def web_component
    <<~JS
      <script type="module">
        import { ImpartElement } from "https://cdn.jsdelivr.net/npm/impart-element@0.1.0/dist/index.min.js"
    
        class ImpartIt extends ImpartElement {
          static observedAttributes = ["count"]

          countCallback() {
            this.queryParts("count").forEach(item => item.textContent = this.count)
            this.classList.toggle("yellow", this.count % 2)
          }

          increment(e) {
            this.count++
          }
        }

        ImpartIt.define("impart-it")        
      </script>
    JS
  end
end
