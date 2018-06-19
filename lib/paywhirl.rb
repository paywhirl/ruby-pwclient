# PayWhirl API Ruby Library
#
# Documentation can be obtained at https://api.paywhirl.com
#
# API keys can be obtained at https://app.paywhirl.com/api-keys
#
# Example Usage:
# ==================
# <your_program>
# require_relative 'PayWhirl'
# api_key = '<your_api_key_here>'
# api_secret = '<your_secret_key_here>'
# paywhirl = PayWhirl.new(api_key, api_secret)
# paywhirl.<method>


require 'paywhirl/version'
require 'json'
require 'faraday'


class PayWhirl
  def initialize(api_key, api_secret, api_base="https://api.paywhirl.com")
    @api_key = api_key.to_s
    @api_secret = api_secret.to_s
    @api_base = api_base.to_s
    @headers = {:api_key => @api_key, :api_secret => @api_secret}
  end


  def get_customers(data = nil)
    return self.get('/customers', data)
  end

  def get_customer(customer_id = nil)
    cust = "/customer/#{customer_id}"
    return self.get(cust)
  end

  def get_addresses(customer_id = nil)
    cust = "/customer/addresses/#{customer_id}"
    return self.get(cust)
  end

  def get_address(address_id = nil)
    cust = "/customer/address/#{address_id}"
    return self.get(cust)
  end

  def get_profile(customer_id = nil)
    cust = "/customer/profile/#{customer_id}"
    return self.get(cust)
  end

  def create_customer(data = nil)
    return self.post('/create/customer', data)
  end

  def update_customer(data = nil)
    return self.post('/update/customer', data)
  end

  def update_answer(data = nil)
    return self.post('/update/answer', data)
  end

  def get_questions(data = 100)
    if data.respond_to?(:to_i)
      data = {"limit" => data}
    end
    return self.get('/questions', data)
  end

  def get_answers(data = nil)
    if data.respond_to?(:to_i)
      data = {"customer_id" => data}
    end
    return self.get('/answers', data)
  end

  def get_plans(data = nil)
    return self.get('/plans', data)
  end

  def get_plan(customer_id = nil)
    plan = "/plan/#{customer_id}"
    return self.get(plan)
  end

  def create_plan(data = nil)
    return self.post('/create/plan', data)
  end

  def update_plan(data = nil)
    return self.post('/update/plan', data)
  end

  def get_subscriptions(customer_id = nil)
    subs = "/subscriptions/#{customer_id}"
    return self.get(subs)
  end

  def get_subscription(customer_id = nil)
    sub = "/subscription/#{customer_id}"
    return self.get(sub)
  end

  def get_subscribers(data = nil)
    return self.get('/subscribers', data)
  end

  def subscribe_customer(data = nil)
    return self.post('/subscribe/customer', data)
  end

  def update_subscription(subscription_id = nil, plan_id = nil, quantity = nil)
    data = {'subscription_id'=>subscription_id, 'plan_id'=>plan_id}
    if (quantity) then
      data.merge!(quantity: quantity)
    end
    return self.post('/update/subscription', data)
  end

  def unsubscribe_customer(subscription_id = nil)
    data = {'subscription_id'=>subscription_id}
    return self.post('/unsubscribe/customer', data)
  end

  def get_invoice(customer_id = nil)
    format = "/invoice/#{customer_id}"
    return self.get(format)
  end

   def get_invoices(customer_id = nil, all_invoices = 0)
    format = "/invoices/#{customer_id}/#{all_invoices}"
    return self.get(format)
   end

   def process_invoice(invoice_id = nil)
    format = "/invoice/#{invoice_id}/process"
    return self.post(format)
   end

   def update_invoice_card(invoice_id = nil, card_id = nil)
    data = {'card_id'=>card_id}
    format = "/invoice/#{invoice_id}/card"
    return self.post(format, data)
   end

   def create_invoice(data = nil)
    format = "/invoices"
    return self.post(format, data)
   end

   def get_gateways()
     return self.get('/gateways')
   end

   def get_gateway(customer_id = nil)
     format = "/gateway/#{customer_id}"
     return self.get(format)
   end

  def create_charge(data = nil)
    return self.post('/create/charge', data)
  end

  def get_charge(customer_id = nil)
    format = "/charge/#{customer_id}"
    return self.get(format)
  end

  def get_card(customer_id = nil)
    format = "/card/#{customer_id}"
    return self.get(format)
  end

  def get_cards(customer_id = nil)
    format = "/cards/#{customer_id}"
    return self.get(format)
  end

  def create_card(data = nil)
    return self.post('/create/card', data)
  end

  def delete_card(customer_id = nil)
    data = {'id'=>customer_id}
    return self.post('/delete/card', data)
  end

  def get_promos()
    return self.get("/promo")
  end

  def get_promo(customer_id = nil)
    format = "/promo/#{customer_id}"
    return self.get(format)
  end

  def create_promo(data = nil)
    return self.post('/create/promo', data)
  end

  def delete_promo(promo_id = nil)
    data = {'id'=>promo_id}
    return self.post('/delete/promo', data)
  end

  def get_email_template(customer_id = nil)
    format = "/email/#{customer_id}"
    return self.get(format)
  end

  def send_email(data = nil)
    return self.post('/send-email', data)
  end

  def get_account()
    return self.get('/account')
  end

  def get_stats()
    return self.get('/stats')
  end

  def get_shipping_rules()
    return self.get("/shipping")
  end

  def get_shipping_rule(customer_id = nil)
    format = "/shipping/#{customer_id}"
    return self.get(format)
  end

  def get_tax_rule(customer_id = nil)
    format = "/tax/#{customer_id}"
    return self.get(format)
  end

  def get_tax_rules()
    return self.get('/tax')
  end

  def get_multi_auth_token(data = nil)
    return self.post('/multiauth', data)
  end

  def post(endpoint = nil, params = nil)
    conn = Faraday.new(url: @api_base)
    conn.headers = @headers
    response = conn.post(endpoint, params)
    json_object = JSON.parse(response.body)
    return json_object
  end

  def get(endpoint = nil, params = nil)
    conn = Faraday.new(url: @api_base)
    conn.headers = @headers
    response = conn.get(endpoint, params)
    json_object = JSON.parse(response.body)
    return json_object
  end

end
