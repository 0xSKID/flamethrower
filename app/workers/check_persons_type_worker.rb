class CheckPersonsTypeWorker
  include Sidekiq::Worker

  attr_reader :person

  def perform(person_id)
    @person = Person.includes(:messages).find(person_id)
    person_change_type
    person_perform_action
    person.save!
  end

  private

  def person_change_type
    return if immutable_types.include(person.type)
    if person_unopened
      person.type = 'Match'
    elsif person_opened && person_waiting_reply
      person.type = 'Replied'
    elsif person_followed_up && person_waiting_reply
      person.type = 'Responsive'
    end
  end

  def immutable_types
    ['Dated', 'Lost']
  end

  def person_waiting_reply
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

  def person_perform_action
    person.action if person.type_changed?
  end
end
