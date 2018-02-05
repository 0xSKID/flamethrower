class TypeActionWorker
  include Sidekiq::Worker

  def perform(person_id)
    person = Person.find(person_id)
    person.perform_type_action
  end
end
