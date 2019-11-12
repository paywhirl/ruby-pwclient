# frozen_string_literal: true

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

# PayWhirl API Client
class PayWhirl
  def initialize(api_key, api_secret, api_base = 'https://api.paywhirl.com')
    @api_base = api_base
    @headers = { api_key: api_key, api_secret: api_secret }
  end

  def get_customers(data = nil)
    get('/customers', data)
  end

  def get_customer(customer_id = nil)
    cust = "/customer/#{customer_id}"
    get(cust)
  end

  def get_addresses(customer_id = nil)
    cust = "/customer/addresses/#{customer_id}"
    get(cust)
  end

  def get_address(address_id = nil)
    cust = "/customer/address/#{address_id}"
    get(cust)
  end

  def get_profile(customer_id = nil)
    cust = "/customer/profile/#{customer_id}"
    get(cust)
  end

  def auth_customer(email = nil, password = nil)
    post('/auth/customer', email: email, password: password)
  end

  def create_customer(data = nil)
    post('/create/customer', data)
  end

  def update_customer(data = nil)
    post('/update/customer', data)
  end

  def delete_customer(id = nil, forget = nil)
    data = { 'id' => id }
    data['forget'] = forget unless forget.nil?
    post('/delete/customer', data)
  end

  def update_answer(data = nil)
    post('/update/answer', data)
  end

  def get_questions(data = 100)
    data = { 'limit' => data } if data.respond_to?(:to_i)
    get('/questions', data)
  end

  def get_answers(data = nil)
    data = { 'customer_id' => data } if data.respond_to?(:to_i)
    get('/answers', data)
  end

  def get_plans(data = nil)
    get('/plans', data)
  end

  def get_plan(customer_id = nil)
    plan = "/plan/#{customer_id}"
    get(plan)
  end

  def create_plan(data = nil)
    post('/create/plan', data)
  end

  def update_plan(data = nil)
    post('/update/plan', data)
  end

  def get_subscriptions(customer_id = nil)
    subs = "/subscriptions/#{customer_id}"
    get(subs)
  end

  def get_subscription(customer_id = nil)
    sub = "/subscription/#{customer_id}"
    get(sub)
  end

  def get_subscribers(data = nil)
    get('/subscribers', data)
  end

  def subscribe_customer(data = nil)
    post('/subscribe/customer', data)
  end

  def update_subscription(subscription_id = nil, plan_id = nil, quantity = nil)
    data = { 'subscription_id' => subscription_id, 'plan_id' => plan_id }
    data.merge!(quantity: quantity) if quantity
    post('/update/subscription', data)
  end

  def unsubscribe_customer(subscription_id = nil)
    data = { 'subscription_id' => subscription_id }
    post('/unsubscribe/customer', data)
  end

  def get_invoice(customer_id = nil)
    format = "/invoice/#{customer_id}"
    get(format)
  end

  def get_invoices(customer_id = nil, all_invoices = 0)
    format = "/invoices/#{customer_id}/#{all_invoices}"
    get(format)
  end

  def process_invoice(invoice_id = nil, data = nil)
    format = "/invoice/#{invoice_id}/process"
    post(format, data)
  end

  def mark_invoice_as_paid(invoice_id = nil)
    format = "/invoice/#{invoice_id}/mark-as-paid"
    post(format)
  end

  def add_promo_code_to_invoice(invoice_id = nil, promo_code = nil)
    format = "/invoice/#{invoice_id}/add-promo"
    post(format, 'promo_code' => promo_code)
  end

  def remove_promo_code_from_invoice(invoice_id = nil)
    format = "/invoice/#{invoice_id}/remove-promo"
    post(format)
  end

  def update_invoice_card(invoice_id = nil, card_id = nil)
    data = { 'card_id' => card_id }
    format = "/invoice/#{invoice_id}/card"
    post(format, data)
  end

  def update_invoice_items(invoice_id = nil, line_items = nil)
    format = "/invoice/#{invoice_id}/items"
    post(format, line_items)
  end

  def create_invoice(data = nil)
    format = '/invoices'
    post(format, data)
  end

  def delete_invoice(invoice_id = nil)
    data = { 'id' => invoice_id }
    post('/delete/invoice', data)
  end

  def get_gateways
    get('/gateways')
  end

  def get_gateway(customer_id = nil)
    format = "/gateway/#{customer_id}"
    get(format)
  end

  def create_charge(data = nil)
    post('/create/charge', data)
  end

  def get_charge(customer_id = nil)
    format = "/charge/#{customer_id}"
    get(format)
  end

  def refund_charge(charge_id, data = nil)
    post("/refund/charge/#{charge_id}", data)
  end

  def get_card(customer_id = nil)
    format = "/card/#{customer_id}"
    get(format)
  end

  def get_cards(customer_id = nil)
    format = "/cards/#{customer_id}"
    get(format)
  end

  def create_card(data = nil)
    post('/create/card', data)
  end

  def delete_card(customer_id = nil)
    data = { 'id' => customer_id }
    post('/delete/card', data)
  end

  def get_promos
    get('/promo')
  end

  def get_promo(customer_id = nil)
    format = "/promo/#{customer_id}"
    get(format)
  end

  def create_promo(data = nil)
    post('/create/promo', data)
  end

  def delete_promo(promo_id = nil)
    data = { 'id' => promo_id }
    post('/delete/promo', data)
  end

  def get_email_template(customer_id = nil)
    format = "/email/#{customer_id}"
    get(format)
  end

  def send_email(data = nil)
    post('/send-email', data)
  end

  def get_account
    get('/account')
  end

  def get_stats
    get('/stats')
  end

  def get_shipping_rules
    get('/shipping')
  end

  def get_shipping_rule(customer_id = nil)
    format = "/shipping/#{customer_id}"
    get(format)
  end

  def get_tax_rule(customer_id = nil)
    format = "/tax/#{customer_id}"
    get(format)
  end

  def get_tax_rules
    get('/tax')
  end

  def get_multi_auth_token(data = nil)
    post('/multiauth', data)
  end

  protected

  def request(method, path, params = nil)
    conn = Faraday.new(url: @api_base, headers: @headers)
    response = conn.public_send(method, path, params)
    JSON.parse(response.body)
  end

  def post(path, params = nil)
    request(:post, path, params)
  end

  def get(path, params = nil)
    request(:get, path, params)
  end
end
