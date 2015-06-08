module PayuIndia
  class Helper

    CHECKSUM_FIELDS = [ :txnid, :amount, :productinfo, :firstname, :email, :udf1, :udf2, :udf3, :udf4, :udf5, :udf6, :udf7, :udf8, :udf9, :udf10 ]

    def initialize(key, salt, options = {})
      @key, @salt, @options = key, salt, options
    end

    def form_fields
      sanitize_fields
      @options.merge(:hash => generate_checksum, :key => @key)
    end

    def generate_checksum
      checksum_payload_items = CHECKSUM_FIELDS.map { |field| @options[field] }
      PayuIndia.checksum(@key, @salt, checksum_payload_items )
    end

    def sanitize_fields
      [:address1, :address2, :city, :state, :country, :productinfo, :email, :phone].each do |field|
        @options[field].gsub!(/[^a-zA-Z0-9\-_@\/\s.]/, '') if @options[field]
      end
    end

  end
end