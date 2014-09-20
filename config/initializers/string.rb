# coding: utf-8
class String  
  def upcase
    self.mb_chars.upcase.to_s
  end
 
  def downcase
    self.mb_chars.downcase.to_s
  end
 
  def titlecase
    self.mb_chars.titlecase.to_s
  end
 
  def titleize
    self.mb_chars.titleize.to_s
  end

  def print_and_flush
    print self
    $stdout.flush
  end

  def mini_encode
    Base64.encode64(UUIDTools::UUID.parse(self).raw).gsub(/\//,'_')[0..-4].reverse if self.present?
  end

  def mini_decode
    begin
      UUIDTools::UUID.parse(self)
      self
    rescue
      UUIDTools::UUID.parse_raw(Base64.decode64("#{self.reverse.gsub(/_/, '/')}==\n")).to_s if self.present?
    end
    #Base64.encode64(UUIDTools::UUID.parse('545c0626-bfe2-11e3-a5fc-080027129698').raw).gsub(/\//,'_')[0..-4].reverse
  end
end