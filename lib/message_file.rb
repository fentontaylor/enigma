class MessageFile
  attr_reader :text_file,
              :ciphertext_file,
              :text,
              :ciphertext,
              :key,
              :date

  def initialize(args)
    @text_file = args[:text_file]
    @ciphertext_file = args[:ciphertext_file]
    @text = args[:text]
    @ciphertext = args[:ciphertext]
    @key = args[:key]
    @date = args[:date]
  end

  def self.encrypt(in_file, out_file)
    message = File.read(in_file)
    enigma = Enigma.new
    encrypted = enigma.encrypt(message)
    MessageFile.new(text_file: in_file,
                ciphertext_file: out_file,
                text: message,
                ciphertext: encrypted[:encryption],
                key: encrypted[:key],
                date: encrypted[:date])
  end

  def self.decrypt(in_file, out_file, key, date)
    message = File.read(in_file)
    enigma = Enigma.new
    decrypted = enigma.decrypt(message, key, date)
    MessageFile.new(text_file: out_file,
                ciphertext_file: in_file,
                text: decrypted[:decryption],
                ciphertext: message,
                key: decrypted[:key],
                date: decrypted[:date])
  end
end
