class Parking < ApplicationRecord

  belongs_to :user, :optional => true

  validates_presence_of :parking_type, :start_at

  validate :validate_end_at_and_amount

  before_validation :setup_amount

  def setup_amount
    if self.amount.blank? && self.start_at.present? && self.end_at.present?
      if self.user.blank?
        self.amount = calculate_guest_term_amount
      elsif self.parking_type == "long-term"
          self.amount = calculate_long_term_amount
      elsif self.parking_type == "short-term"
        self.amount = calculate_short_term_amount
      end
    end
  end

  def calculate_guest_term_amount
    if duration <= 60
      self.amount = 200
    else
      self.amount = 200 + ((duration - 60).to_f / 30).ceil * 100
    end
  end

  def calculate_short_term_amount
    if duration <= 60
      self.amount = 200
    else
      self.amount = 200 + ((duration - 60).to_f / 30).ceil * 50
    end
  end

  def calculate_long_term_amount
    # TODO
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
    if ( end_at.blank? && amount.present? )
      errors.add(:end_at, "有金額就必須有結束時間")
    end
  end

end
