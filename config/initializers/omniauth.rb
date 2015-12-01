Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '544591069026303', '63c4baaddd3dba76658cefa94977d546', scope: 'email', info_fields: 'name, email'
end