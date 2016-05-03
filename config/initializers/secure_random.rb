module SecureRandom
  def self.issue_unique_identifier
    chars = base64(128).delete("^a-zA-Z").upcase.scan(/.{3}/)

    "#{chars.shift}-#{hex(1).to_s.upcase}-#{chars.shift}-#{hex(1).to_s.upcase}-#{chars.shift}"
  end
end
