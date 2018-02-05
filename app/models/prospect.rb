class Prospect < Person

  def self.build_from(raw_data)
    new.tap do |prospect|
      prospect.build_raw_data(data: raw_data)
      prospect.name = raw_data['name']
      prospect.photos = raw_data['photos'].map { |photo| photo['url'] }.join(' ')
      prospect.tinder_id = raw_data['_id']
    end
  end
end
