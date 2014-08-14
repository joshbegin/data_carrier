json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :phone, :address_line_1, :address_line_2, :address_line_3, :email, :gender_id, :title, :notes
  json.url contact_url(contact, format: :json)
end
