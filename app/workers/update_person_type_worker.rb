class UpdatePersonTypeWorker
  include Sidekiq::Worker

  attr_reader :person

  def perform(person_id)
    @person = Person.includes(:messages).find(person_id)
    person.advance_stage
    person.save!
  end
end
