class Encryptor
  class Configuration
    getter :salt, :iv, :password

    def initialize
      @salt = ""
      @iv = ""
      @password = ""
      @key = ""
    end

    def salt=(value : String)
      if value.bytesize != 8
        raise "Salt must be exactly 8 bytes. Use `SecureRandom.random_bytes(8)`."
      end
      @salt = value
    end

    def iv=(value : String)
      if value.bytesize != 16
        raise "The IV must be exactly 16 bytes. Use `SecureRandom.random_bytes(16)`."
      end
      @iv = value
    end

    def password=(value : String)
      if value.size < 8
        raise "Your password must be 8 or more characters"
      end
      @password = value
    end

    def key
      OpenSSL::PKCS5.pbkdf2_hmac(password, salt, 100_000, :sha256, 256 // 8)
    end
  end

  CONFIG = Configuration.new
  MODE   = "aes-256-cbc"

  def self.config
    yield CONFIG
  end

  def initialize
    @cipher = OpenSSL::Cipher.new(MODE)
  end

  # Returns Base64 encoded encrypted string
  def encrypt(plaintext : String)
    begin
      @cipher.encrypt
      @cipher.key = CONFIG.key
      @cipher.iv = CONFIG.iv
      encrypted = String.new(@cipher.update(plaintext)) + String.new(@cipher.final)
      Base64.urlsafe_encode(encrypted)
    rescue exception
      exception.message
    end
  end

  # decodes token and returns plaintext
  def decrypt(base64token : String)
    text = Base64.decode(base64token)
    @cipher.decrypt
    @cipher.key = CONFIG.key
    @cipher.iv = CONFIG.iv
    decrypted = String.new(@cipher.update(text)) + String.new(@cipher.final)
    decrypted
  end
end
