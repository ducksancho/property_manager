module ApplicationHelper
  include MenuHelper
  include SessionsHelper
  include HeaderHelper
  include FormHelper
  include PaginateHelper
  
  def haha
    # gateway = XeroGateway::PrivateApp.new(XERO_CONSUMER_KEY, XERO_CONSUMER_SECRET, XERO_PRIVATE_KEY_PATH)
    # gateway.get_invoices.response_xml
    # invoice = gatweay.bulid_invoice({
    #   :invoice_type => "ACCREC",
    #   :due_date => 1.month.from_now,
    #   :invoice_number => "YOUR INVOICE NUMBER",
    #   :status => "AUTHORISED"
    #   :reference => "111",
    #   :line_amount_types => "Inclusive" # "Inclusive", "Exclusive" or "NoTax"
    # })
    # 
    # invoice.contact.name = "hhhh"
    # invoice.contact.phone.number = "12345"
    # invoice.contact.address.line_1 = "LINE 1 OF THE ADDRESS"
    # 
    # line_item = XeroGateway::LineItem.new(
    #   :description => "aaaa",
    #   :account_code => 469,
    #   :unit_amount => 400
    # )
    # 
    # # line_item.tracking << XeroGateway::TrackingCategory.new(:name => “tracking category”, :options => “tracking option”)
    # invoice.line_items << line_item
    # 
    # invoice.create
    # # results =  gateway.get_invoices.response_xml
  end
end
