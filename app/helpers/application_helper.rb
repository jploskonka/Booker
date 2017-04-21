module ApplicationHelper
  def body_html_class
    return 'css-debug' if params['css-debug'] == 'please'

    ''
  end
end
