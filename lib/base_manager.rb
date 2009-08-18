class BaseManager

  def self.massage(controller, parsed_document, page_uri, what)
    what = [ :images, :css_links, :links ] if what == :all
    parsed_document.search('title').each { |t| t.inner_html = 'Geek Club // ' + t.inner_text }
    for el_type in what
      case el_type
      when :images
        parsed_document.search('img').each do |i|
          i['src'] = absolute_uri(i['src'], page_uri)
        end
        parsed_document.search('input').each do |i|
          i['src'] = absolute_uri(i['src'], page_uri) if i['src']
        end
      when :css_links
        parsed_document.search('link').each do |i|
          i['href'] = absolute_uri(i['href'], page_uri) if i['rel'] =~ /stylesheet/i
        end
      when :links
        parsed_document.search('a').each do |i|
          i['href'] = relative_uri(controller, i['href'], page_uri)
        end
      when :forbidden
        parsed_document.search('object').each { |i| i.remove }
        parsed_document.search('noscript').each { |i| i.remove }
        parsed_document.search('*').each { |i| i.remove_attribute('oncontextmenu') }
        body = parsed_document.search('body').first
        body.name = 'div'
        body_id = 'gk_body'
      end
    end
    parsed_document
  end

  def self.absolute_uri(path, base_uri)
    if path.blank?
      return path
    elsif path =~ /^[a-z+]+:/
      return path
    elsif path =~ /^\//
      root_uri = URI.parse(base_uri)
      root_uri.path  = ''
      root_uri.query = nil
      return root_uri.to_s + path
    elsif path =~ /^[[:alnum:]]/
      base_uri = URI.parse(base_uri)
      base_uri.query = nil
      return base_uri.to_s.sub(/\/[^\/]*$/, "/#{path}")
    else
      raise "don't know how to make '#{path}' absolute"
    end
  end

  def self.relative_uri(controller, path, base_uri)
    if path.blank?
      return path
    elsif path =~ /^http:\/\//
      return controller.send(:proxy_path, :uri => uri_to_base64(path))
    elsif path =~ /^[[:alnum:]]/
      return path
    elsif path =~ /^\//
      root_uri = URI.parse(base_uri)
      root_uri.path  = ''
      root_uri.query = nil
      return controller.send(:proxy_path, :uri => uri_to_base64(root_uri.to_s + path))
    else
      raise "don't know how to make '#{path}' relative"
    end
  end

  def self.base64_to_uri(b64)
    ActiveSupport::Base64.decode64(b64)
  end

  def self.uri_to_base64(uri)
    ActiveSupport::Base64.encode64(uri).lines.collect(&:strip).join
  end

  def self.new_element(tag_name, document, attributes={})
    element = Nokogiri::XML::Element.new(tag_name, document)
    attributes.each_pair { |key, value| element[key] = value }
    element
  end

end
