module Redcarpet
  module Render
    module ListCheckBoxes
      CHECKBOX = /^\s*\[\s*( |x)\s*\]\s*/

      def list_item(text, list_type)
        tag = '<li'
        match = CHECKBOX.match(text)
        if match
          tag << ' class="b-task-item"'
          text = text.gsub(CHECKBOX, %(<input type="checkbox"#{' checked="true"' if match[1] == 'x'} disabled> ))
        end
        tag << ">#{text}</li>"
      end
    end
  end
end
