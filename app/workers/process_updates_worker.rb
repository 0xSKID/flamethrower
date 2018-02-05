class ProcessUpdatesWorker
  include Sidekiq::Worker

  attr_reader :update

  def perform(update_id)
    @update = Update.find(update_id)

    update['matches'].each do |match|
      process(match)
    end
  end

  private

  def process(match)
    return if match['person'].nil? # sometimes this value is nil in tinders response?

    person = Person.includes(:messages).find_by(tinder_id: match['person']['_id'])
    existing_message_ids = person.messages.map(&:tinder_id)

    match['messages'].each do |message|
      next if existing_message_ids.include?(message['_id'])
      message = Message.build_from(message)
      message.person = person
      message.set_type
      message.save
    end

    person.set_type
    kickoff_perform_action = person.type_changed?
    person.save

    if kickoff_perform_action
      TypeActionWorker.perform_async(person.id)
    end
  end
end

