class Parking < ApplicationRecord

  validates_presence_of :parking_type, :start_at

  validate :validate_end_at_and_amount

  # before_validation :calculate_amount

  def calculate_amount
    if self.amount.blank? && self.start_at.present? && self.end_at.present?
      self.amount = 9487 # TODO: 等會再來處理
    end
  end

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
