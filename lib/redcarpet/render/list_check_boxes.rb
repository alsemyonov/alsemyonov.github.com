module Redcarpet
  module Render
    module ListCheckBoxes
      CHECKBOX = /^\s*\[\s*( |x)\s*\]\s*/

      def list_item(text, list_type)
        tag = '<li'
        match = CHECKBOX.match(text)
        if match
          input_tag = %(<input type="checkbox"#{' checked="true"' if match[1] == 'x'} disabled>)
          text = text.gsub(CHECKBOX, input_tag)
          tag << ' class="b-task-item"'
        end
        tag << ">#{text}</li>"
      end
    end
  end
end
