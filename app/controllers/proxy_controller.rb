class ProxyController < ApplicationController
  require 'mechanize'
  ensure_authenticated_to_facebook

  def get
    uri     = BaseManager.base64_to_uri(params[:uri])
    manager = nil
    Shop.all.each do |shop|
      manager = shop.manager_class if shop.recognize_uri(uri)
      break if manager.is_a?(Class)
    end
    if manager.is_a?(Class)
      client = WWW::Mechanize.new
      page   = client.get(uri)
      parsed = Nokogiri::HTML.parse(page.body)
      manager.massage(self, parsed, uri)
      render :text => parsed.to_html
    else
      render :nothing => true
    end
  end


end
