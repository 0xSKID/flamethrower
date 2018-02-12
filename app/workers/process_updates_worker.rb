class ProcessUpdatesWorker
  include Sidekiq::Worker

  attr_reader :update

  def perform(update_id)
    @update = Update.includes(:raw_data, :account).find(update_id)

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
    # Tinder only sends a 'person' object when you first match, after that all we have in the match id
    tinder_id, tinder_match_id = match['person']&.[]('_id'), match['_id']
    person_by_tinder_id = people.find_by(tinder_id: tinder_id) if tinder_id
    person_by_match_id = people.find_by(tinder_match_id: tinder_match_id) if tinder_match_id
    person_by_tinder_id || person_by_match_id
  end

  def matches
    update.raw_data.data['matches'] || []
  end

  def people
    account.people.includes(:messages)
  end

  def account
    update.account
  end
end
