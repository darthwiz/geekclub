class Shop < ActiveRecord::Base

  def manager_class
    Module.const_get(self.manager_name + 'Manager')
  end

  def uri
    self.manager_class.uri
  end

  def recognize_uri(absolute_uri)
    self.manager_class.recognize_uri(absolute_uri)
  end

end
