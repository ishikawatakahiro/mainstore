json.array!(@adminmails) do |adminmail|
  json.extract! adminmail, :id, :admin_mail
  json.url adminmail_url(adminmail, format: :json)
end
