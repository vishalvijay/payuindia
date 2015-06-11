module PayuIndia
  class InfoApi

    TEST_URL = "https://test.payu.in/merchant/postservice.php?form=2"
    PRODUCTION_URL = "https://info.payu.in/merchant/postservice.php?form=2"

    attr_reader :key, :salt, :options, :force_production

    def initialize(key, salt, opts = {})
      @force_production = opts.delete :force_production
      @key, @salt, @options = key, salt, opts
      validate
    end

    def service_url
      unless force_production
        defined?(Rails) && Rails.env.production? ? PRODUCTION_URL : TEST_URL
      else
        PRODUCTION_URL
      end
    end

    def process
      result = nil
      params = options.merge({hash: checksum, key: key})
      begin
        r = HTTParty.post(service_url, body: params).parsed_response
        result = PayuIndia::InfoApiResponse.new JSON.parse(r, symbolize_names: true), options
      rescue => e
      end
      result
    end

    private

    def validate
      def rails_exp opts, value
        raise "'#{value}' can't be nil" unless opts[value]
      end
      rails_exp options, :command
      case options[:command]
      when "verify_payment", "check_payment", "check_action_status"
        rails_exp options, :var1
      when "cancel_refund_transaction"
        rails_exp options, :var1
        rails_exp options, :var2
        rails_exp options, :var3
      when "capture_transaction"
        rails_exp options, :var1
        rails_exp options, :var2
      else
        raise "'validate' method not implemented for this command"
      end
    end

    def sanitize
      options.each do |k, v|
        v.to_s.gsub!(/[^a-zA-Z0-9\-_@\/\s.]/, '')
      end
    end

    def checksum
      PayuIndia.checksum(key, salt, [options[:command], options[:var1]])
    end
  end
end