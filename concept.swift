struct Prospect: Person {
  var tinderId: String
}

struct Passed: Person {
  var tinderId: String
}

struct Liked: Person {
  var tinderId: String
}

struct Matched: Person {
  var tinderId: String
  var opener: Assosciation<SentMessage>
}

struct Replied: Person {
  var tinderId: String
  var opener: Assosciation<SentMessage>
  var reply: Assosciation<ReceivedMessage>
  var followup: Assosciation<SentMessage>
}

struct Responsive: Person {
  var tinderId: String
  var sent: Assosciation<[SentMessage]>
  var received: Assosciation<[ReceivedMessage]>
}

struct SentMessage {
  var date: Date
  var content: String

  static var opener: SentMessage {
    return .init(date: Date(), content: "Hi you seem interesting...")
  }
}

struct ReceivedMessage {
  let date: Date
  let content: String
}


extension Passed {
  init(_ person: Prospect) {
    tinderId = person.tinderId
  }
}

extension Liked {
  init(_ person: Prospect) {
    tinderId = person.tinderId
  }
}

extension Matched {
  init(_ person: Liked, opener: SentMessage) {
    tinderId = person.tinderId
    self.opener = Assosciation(opener)
  }
}

extension Replied {
  init(_ person: Matched, reply: ReceivedMessage, followup: SentMessage) {
    tinderId = person.tinderId
    self.opener = person.opener
    self.reply = Assosciation(reply)
    self.followup = Assosciation(followup)
  }
}

extension Responsive {
  init(_ person: Replied) {
    tinderId = person.tinderId
    self.sent = Assosciation([person.opener.wrapped, person.followup.wrapped])
    self.received = Assosciation([person.reply.wrapped])
  }
}

let like = Liked(tinderId: "123")
let replied = Matched(like, opener: SentMessage.opener)

