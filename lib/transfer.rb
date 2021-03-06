class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, transfer_amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = transfer_amount
  end

  def both_valid?
    (sender.valid? && receiver.valid?)
  end

  def execute_transaction
    if both_valid? && sender.balance > amount && self.status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transfer
    end
  end

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if both_valid? && receiver.balance > amount && self.status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    end
  end
  
end