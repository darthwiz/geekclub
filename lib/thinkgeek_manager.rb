class ThinkgeekManager < BaseManager

  def self.recognize_uri(absolute_uri)
    absolute_uri =~ /^http:\/\/[[:alnum:]]+\.thinkgeek\.com/
  end

  def self.massage(controller, parsed_document, page_uri)
    BaseManager.massage(controller, parsed_document, page_uri, :all)
    parsed_document.search('#submitcart').remove
    parsed_document.search('#loggedout').remove
    parsed_document.search('#cart').remove
    parsed_document.search('form#buy').each do |f|
      f['action'] = controller.send(:wishlist_add_path)
      f['method'] = 'post'
      f['name']   = 'buy'
      f.search('input').each do |field|
        field['name'] = 'quantity' if field['name'] == 'qty'
      end
      f.search('h3').each do |price_tag|
        unit_price = price_tag.inner_text.sub('$', '').strip.to_f
        f.add_child(
          new_element(
            'input',
            parsed_document,
            'name'  => 'unit_price',
            'type'  => 'hidden',
            'value' => unit_price.to_s
          )
        )
      end
      [ 'select#sku', 'select#skuwisher' ].each do |id|
        f.search(id).each do |sel|
          sel['onchange'] = "document.forms['buy'].unit_price.value = options[selectedIndex].attributes['price'].firstChild.wholeText"
        end
        f.search("#{id} option").each do |opt|
          opt['price'] = opt.inner_text.sub(/.*\$([0-9]+(\.[0-9]+)?).*/, "\\1").to_f.to_s
        end
      end
      f.add_child(
        new_element(
          'input',
          parsed_document,
          'name'  => 'authenticity_token',
          'type'  => 'hidden',
          'value' => controller.send(:form_authenticity_token)
        )
      )
    end
  end

end
