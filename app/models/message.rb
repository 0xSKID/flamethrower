class Message < ApplicationRecord
  belongs_to :person
end

class PersonMessage < ApplicationRecord
  belongs_to :person, polymorphic: true
  belongs_to :message, polymorphic: true
end

class Opener < PersonMessage
  belongs_to :sent_message, column_name: :message, type: SentMessage
end
class Reply < PersonMessage
end
class Followup < PersonMessage
end

