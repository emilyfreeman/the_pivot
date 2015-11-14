class Order < ActiveRecord::Base
  has_many :chip_orders
  has_many :chips, through: :chip_orders
  belongs_to :user
  scope :ordered,    -> { where status: 'Ordered' }
  scope :paid,       -> { where status: 'Paid' }
  scope :cancelled,  -> { where status: 'Cancelled' }
  scope :completed,  -> { where status: 'Completed' }

  def update_links
    if status == "Ordered"
      links = "[mark as paid] [cancel]"
    elsif status == "Paid"
      links = "[mark as complete] [cancel]"
    else
      links = nil
    end
    links
  end

  def size_of_order
    self.reduce(0) { |sum, n| sum + n.subtotal }
  end

  def self.scope_action(scope)
    if scope == "Ordered"
      Order.ordered
    elsif scope == "Paid"
      Order.paid
    elsif scope == "Cancelled"
      Order.cancelled
    else
      Order.completed
    end
  end
end
