class UpdatePersonTypeWorker
  include Sidekiq::Worker

  attr_reader :person

  def perform(person_id)
    @person = Person.includes(:messages).find(person_id)
    return if unprocessable

    person_update_type
    person.action if person.type_changed
    person.save!
  end

  private

  def unprocessable
    immutable_types.include?(person.type)
  end

  def immutable_types
    ['Dated', 'Lost']
  end

  def person_update_type
    if person_unopened
      person.type = 'Match'
    elsif opened_and_waiting
      person.type = 'Replied'
    elsif followed_up_and_waiting
      person.type = 'Responsive'
    end
  end

  def opened_and_waiting
    person_opened && person_awaiting_reply
  end

  def followed_up_and_waiting
    person_followed_up && person_waiting_reply
  end

  def person_awaiting_reply
    person.received_messages.last.created_at > person.sent_messages.last.created_at
  end

  def person_unopened
    person.sent_messages.length == 0
  end

  def person_opened
    person.sent_messages.length == 1
  end

  def person_followed_up
    person.sent_messages.length == 2
  end
end
