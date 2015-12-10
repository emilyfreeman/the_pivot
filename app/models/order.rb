class Order < ActiveRecord::Base
  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user
  validates :total_price, numericality: { greater_than: 0 }
  scope :ordered,       -> { where status: 'Ordered' }
  scope :paid,          -> { where status: 'Paid' }
  scope :cancelled,     -> { where status: 'Cancelled' }
  scope :complete,     -> { where status: 'Complete' }
  scope :desc_by_date,  -> { order(id: :desc) }

  def update_links
    if status == "Ordered"
      links = ["mark as paid", "cancel"]
    elsif status == "Paid"
      links = ["mark as complete", "cancel"]
    else
      links = []
    end
    links
  end

  def status_update(new_status)
    if new_status == "cancel"
      self.status = "Cancelled"
    elsif new_status == "mark as paid"
      self.status = "Paid"
    elsif new_status == "mark as complete"
      self.status = "Complete"
    end
  end 
end
