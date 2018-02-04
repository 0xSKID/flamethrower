class ProcessUpdatesWorker
  include Sidekiq::Worker

  attr_reader :update

  def perform(update_id)
    @update = Update.find(update_id)

    update.matches.each do |match|
      classify_and_process(match)
    end
  end
  # might want to seralize updates as something more

  def classify_and_process(match)
    person = Person.find_by(tinder_id: match._id)
    person.type = classification(associated_record)
    process(person
  end

  def classify_match(match)
    match_record = Person.find_by(tinder_id: match._id)
    match_record.type = find_classification(associated_record, match)
    process_match(match_record) if associated_record.type_changed?
    match_record.save
    # we want to classify this record and make the asosciative changes
  end

  def process_match(match_record)
  end

  def find_classification(associated_record, match)
    return Match if match.messages.empty?
    return Replied if respon
    # Match => opened
    # Replied => replied, next up
    # Responsive => replied again

    # need to add tinder id to account
  end

  def account
    update.account
  end
end

# match
#  => [:_id, :closed, :common_friend_count, :common_like_count, :created_date, :dead, :last_activity_date,
#  :message_count, :messages, :participants, :pending, :is_super_like, :is_boost_match, :is_fast_match, :following,
#  :following_moments, :id, :person]
