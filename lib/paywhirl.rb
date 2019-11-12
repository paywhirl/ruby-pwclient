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

  def get_customers(params = {})
    get('/customers', params)
  end

  def get_customer(customer_id)
    get("/customer/#{customer_id}")
  end

  def get_addresses(customer_id)
    get("/customer/addresses/#{customer_id}")
  end

  def get_address(address_id)
    get("/customer/address/#{address_id}")
  end

  def get_profile(customer_id)
    get("/customer/profile/#{customer_id}")
  end

  def auth_customer(email, password)
    post('/auth/customer', email: email, password: password)
  end

  def create_customer(params)
    post('/create/customer', params)
  end

  def update_customer(params)
    post('/update/customer', params)
  end

  def delete_customer(id, forget = false)
    params = { id: id, forget: forget ? '1' : nil }
    post('/delete/customer', params)
  end

  def get_questions(params_or_limit = 100)
    params =
      if params_or_limit.respond_to?(:to_i)
        { limit: params_or_limit }
      else
        params_or_limit
      end

    get('/questions', params)
  end

  def get_answers(params_or_customer_id)
    params =
      if params_or_customer_id.respond_to?(:to_i)
        { customer_id: params_or_customer_id }
      else
        params_or_customer_id
      end

    get('/answers', params)
  end

  def update_answer(params)
    post('/update/answer', params)
  end

  def get_plans(params = {})
    get('/plans', params)
  end

  def get_plan(plan_id = nil)
    get("/plan/#{plan_id}")
  end

  def create_plan(params)
    post('/create/plan', params)
  end

  def update_plan(params)
    post('/update/plan', params)
  end

  def get_subscriptions(customer_id)
    get("/subscriptions/#{customer_id}")
  end

  def get_subscription(subscription_id)
    get("/subscription/#{subscription_id}")
  end

  def get_subscribers(params = {})
    get('/subscribers', params)
  end

  def subscribe_customer(params)
    post('/subscribe/customer', params)
  end

  def update_subscription(subscription_id, plan_id, quantity = nil)
    params = { subscription_id: subscription_id, plan_id: plan_id }
    params[:quantity] = quantity if quantity
    post('/update/subscription', params)
  end

  def unsubscribe_customer(subscription_id)
    post('/unsubscribe/customer', subscription_id: subscription_id)
  end

  def get_invoices(customer_id, all_invoices = false)
    get("/invoices/#{customer_id}", all: all_invoices ? '1' : nil)
  end

  def get_invoice(invoice_id)
    get("/invoice/#{invoice_id}")
  end

  def process_invoice(invoice_id, params = {})
    post("/invoice/#{invoice_id}/process", params)
  end

  def mark_invoice_as_paid(invoice_id)
    post("/invoice/#{invoice_id}/mark-as-paid")
  end

  def add_promo_code_to_invoice(invoice_id, promo_code)
    post("/invoice/#{invoice_id}/add-promo", promo_code: promo_code)
  end

  def remove_promo_code_from_invoice(invoice_id)
    post("/invoice/#{invoice_id}/remove-promo")
  end

  def update_invoice_card(invoice_id, card_id)
    post("/invoice/#{invoice_id}/card", card_id: card_id)
  end

  def update_invoice_items(invoice_id, line_items = {})
    post("/invoice/#{invoice_id}/items", line_items)
  end

  def create_invoice(params)
    post('/invoices', params)
  end

  def delete_invoice(invoice_id)
    post('/delete/invoice', id: invoice_id)
  end

  def get_gateways
    get('/gateways')
  end

  def get_gateway(gateway_id)
    get("/gateway/#{gateway_id}")
  end

  def create_charge(params)
    post('/create/charge', params)
  end

  def get_charge(charge_id)
    get("/charge/#{charge_id}")
  end

  def refund_charge(charge_id, params = {})
    post("/refund/charge/#{charge_id}", params)
  end

  def get_cards(customer_id)
    get("/cards/#{customer_id}")
  end

  def get_card(card_id)
    get("/card/#{card_id}")
  end

  def create_card(params)
    post('/create/card', params)
  end

  def delete_card(card_id)
    post('/delete/card', id: card_id)
  end

  def get_promos
    get('/promo')
  end

  def get_promo(promo_id)
    get("/promo/#{promo_id}")
  end

  def create_promo(params)
    post('/create/promo', params)
  end

  def delete_promo(promo_id)
    post('/delete/promo', id: promo_id)
  end

  def get_email_template(template_id)
    get("/email/#{template_id}")
  end

  def send_email(params)
    post('/send-email', params)
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

  def get_shipping_rule(shipping_rule_id)
    get("/shipping/#{shipping_rule_id}")
  end

  def get_tax_rules
    get('/tax')
  end

  def get_tax_rule(tax_rule_id)
    get("/tax/#{tax_rule_id}")
  end

  def get_multi_auth_token(params)
    post('/multiauth', params)
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
