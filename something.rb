






updates = client.updates

updates['matches'].each do |match|
  next if match['person'].nil?
  person = Person.find_by(tinder_id: match['person']['_id'])

  PersonProcessor.new(person: person, data: match).process
end

MatchProcessor.new(match)

class PersonTypeAdjuster
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def like
    person.type = 'Liked'
    person.like
    peron.save!
  end

  def pass
    person.type = 'Passed'
    person.pass
    person.save!
  end

  def process
    person_change_type
    person_perform_type_action
    person.save!
  end

  private

  def person_change_type
    if person_unopened
      person.type = 'Match'
    elsif person_opened && person_waiting_reply
      person.type = 'Replied'
    elsif person_followed_up && person_waiting_reply
      person.type = 'Responsive'
    end
  end

  def person_waiting_reply
    person.received_messages.last.created_at > person.sent_messages.last.created_at
  end

  def person_unopened
    person.sent_messages == 0
  end

  def person_opened
    person.sent_messages == 1
  end

  def person_followed_up
    person.sent_messages == 2
  end

  def person_perform_type_action
    person.perform_action if person.type_changed?
  end
end
