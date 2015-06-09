require "payuindia/version"
require 'payuindia/helper'
require 'payuindia/notification'
require 'payuindia/return'
require 'payuindia/action_view_helper'
ActionView::Base.send(:include, PayuIndia::ActionViewHelper)

module PayuIndia
  mattr_accessor :test_url
  mattr_accessor :production_url

  self.test_url = 'https://test.payu.in/_payment.php'
  self.production_url = 'https://secure.payu.in/_payment.php'

  def self.service_url force_production = false
    unless force_production
      defined?(Rails) && Rails.env == 'production' ? self.production_url : self.test_url
    else
      self.production_url
    end
  end

  def self.notification(post, options = {})
    Notification.new(post, options)
  end

  def self.return(post, options = {})
    Return.new(post, options)
  end

  def self.checksum(merchant_id, secret_key, payload_items )
    Digest::SHA512.hexdigest([merchant_id, *payload_items, secret_key].join("|"))
  end
end