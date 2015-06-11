module PayuIndia
  class InfoApiResponse

    attr_reader :status, :msg, :transaction_details, :request_id, :bank_ref_num, :mihpayid, :error_code, :command, :params

    def initialize(response_h, params)
      @status = response_h[:status].to_i
      @msg = response_h[:msg]
      @transaction_details = response_h[:transaction_details]
      @request_id = response_h[:request_id]
      @bank_ref_num = response_h[:bank_ref_num]
      @mihpayid = response_h[:mihpayid]
      @error_code = response_h[:error_code]
      @command = params[:command]
      @params = params
    end

    def success?
      status == 1
    end

    def as_json
      {status: status, msg: msg, transaction_details: transaction_details, request_id: request_id, bank_ref_num: bank_ref_num, mihpayid: mihpayid, error_code: error_code, command: command, params: params}
    end

    def to_json
      as_json.to_json
    end
  end
end