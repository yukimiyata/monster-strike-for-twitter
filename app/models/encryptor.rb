module Encryptor
  def encrypt(my_secret_data)
    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = Rails.application.key_generator.generate_key(Rails.application.credentials.secure_words, key_len)
    crypt = ActiveSupport::MessageEncryptor.new(secret)
    crypt.encrypt_and_sign(my_secret_data)
  end

  def decrypt(encrypted_data)
    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = Rails.application.key_generator.generate_key(Rails.application.credentials.secure_words, key_len)
    crypt = ActiveSupport::MessageEncryptor.new(secret)
    crypt.decrypt_and_verify(encrypted_data)
  end
end
