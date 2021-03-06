module ViewComponents
  class ViewComponent
    include ActionView::Helpers::TagHelper
    include Mandate

    def react_component(id, data)
      tag :div, {
        "data-react-#{id}": true,
        "data-react-data": data.to_json
      }
    end
  end
end
