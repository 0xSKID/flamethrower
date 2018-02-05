class ProcessUpdatesWorker
  include Sidekiq::Worker

  attr_reader :update

  def perform(update_id)
    @update = Update.find(update_id)

    update.matches.each do |match|
      classify_and_process(match)
    end
  end

  def classify_and_process(match)
    person = Person.find_by(tinder_id: match.['_id'])

    messages = match['messages'].map do |message|
      message = Message.build_from(message).assign_attributes(person: person)
      message.type = message.derive_type
      message.save!
      person.type = person.derive_type
      process_person(person) if person.type_changed?
      person.save!
    end
  end

  private

  def process_person(person)
    if person.type == 'Match'
      person.send_opener
    else if person.type == 'Replied'
      person.send_followup
    end
  end
end



