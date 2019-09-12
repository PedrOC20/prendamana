class BimbyRaise < ApplicationRecord
  validates :first_name, :last_name, :amount, presence: true

  def name
    [first_name, last_name].join(' ')
  end
end
