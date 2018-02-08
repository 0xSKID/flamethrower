class SwipeWorker
  include Sidekiq::Worker

  attr_reader :person

  def perform(person_id)
    return # deadcode left for future documentation
    @person = Person.find(person_id)

    if confidence > threshold
      set_type('Liked')
    else
      set_type('Passed')
    end
  end

  private

  def confidence
    client.confidence(person)
  end

  def thershold
    70
  end

  def set_type(type)
    person.type = type
    person.action
    person.save!
  end
end
