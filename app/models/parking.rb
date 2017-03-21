class Parking < ApplicationRecord

  belongs_to :user, :optional => true

  validates_presence_of :parking_type, :start_at

  validate :validate_end_at_and_amount

  # before_validation :calculate_amount

  def calculate_amount
    factor = (self.user.present?)? 50 : 100

    if self.amount.blank? && self.start_at.present? && self.end_at.present?
      if duration <= 60
        self.amount = 200
      else
        self.amount = 200 + ((duration - 60).to_f / 30).ceil * factor
      end
    end
  end

  #def calculate_amount
  #  if self.amount.blank? && self.start_at.present? && self.end_at.present?
  #    total = 0
  #    if duration <= 60
  #      total = 2
  #    else
  #      total += 2
  #      left_duration = duration - 60
  #      total += ( left_duration.to_f / 30 ).ceil
  #    end
#
  #    self.amount = total
  #  end
  #end

  def duration
    ( end_at - start_at ) / 60
  end

  protected

  def validate_end_at_and_amount
    if ( end_at.present? && amount.blank? )
      errors.add(:amount, "有結束時間就必須有金額")
    end

    if ( end_at.blank? && amount.present? )
      errors.add(:end_at, "有金額就必須有結束時間")
    end
  end

end
