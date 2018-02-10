class ProcessUpdatesWorker
  include Sidekiq::Worker

  attr_reader :update

  def perform(update_id)
    @update = Update.includes(:raw_data).find(update_id)

    matches.each do |match|
      process(match)
    end
  end

  private

  def process(match)
    person = find_person_by_raw_data(match)
    existing_message_ids = person.messages.map(&:tinder_id)

    match['messages'].each do |message|
      next if existing_message_ids.include?(message['_id'])
      message = Message.build_from(message)
      message.person = person
      message.save
    end

    UpdatePersonTypeWorker.perform_async(person.id)
  end

  def find_person_by_raw_data(match)
    # annoyingly.. Tinder doesn't always have a person object attached to their match object
    tinder_id, tinder_match_id = match['person']&.[]('_id'), match['_id']
    person_by_tinder_id = Person.includes(:messages).find_by(tinder_id: tinder_id) if tinder_id
    person_by_match_id = Person.includes(:messages).find_by(tinder_match_id: tinder_match_id) if tinder_match_id
    person_by_tinder_id || person_by_match_id
  end

  def matches
    update.raw_data.data['matches'] || []
  end
end
