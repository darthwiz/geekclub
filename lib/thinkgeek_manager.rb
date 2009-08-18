class ThinkgeekManager < BaseManager

  def self.massage(controller, parsed_document, page_uri)
    BaseManager.massage(controller, parsed_document, page_uri, :all)
    parsed_document.search('#submitcart').remove
    parsed_document.search('#loggedout').remove
    parsed_document.search('#cart').remove
    parsed_document.search('form#buy').each do |f|
      f['action'] = controller.send(:wishlist_add_path)
      f.search('h3').each do |price_tag|
        unit_price  = price_tag.inner_text.sub('$', '').strip.to_f
        price_field = Nokogiri::XML::Element.new('input', parsed_document)
        price_field['name']  = 'unit_price'
        price_field['type']  = 'hidden'
        price_field['value'] = unit_price.to_s
        f.add_child(price_field)
      end
    end
  end

  def self.recognize_uri(absolute_uri)
    absolute_uri =~ /^http:\/\/[[:alnum:]]+\.thinkgeek\.com/
  end

end
