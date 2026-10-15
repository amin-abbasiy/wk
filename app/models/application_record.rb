class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def has_html_tag?(string)
    string =~ /<html.*?>/
  end
end
