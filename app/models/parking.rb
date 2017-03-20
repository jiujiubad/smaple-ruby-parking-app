class Parking < ApplicationRecord

  validates_presence_of :parking_type, :start_at

  validate :validate_end_at_and_amount

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