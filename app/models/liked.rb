class Liked < Person
end


match: {
  messages: [{
    id: :message_iD
    to: :tinder_id
    from: :tinder_id
    message: 'ohai'
    created_at: timestamp
    **other irrelevant timestamps
  }]
}

messages.reject! messages.id ==  match.opener.tinder_id

messages.any? => true

match.type = Replied
match.replies << messages.map.build
match.followup = match.build_followup

=======================
messages.reject! message.id == replied.messages.tinder_id
messages.any? => true

replied.type = Responsive
replied.messages << 












