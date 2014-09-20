class Hash
  def clean!
      self.delete_if do |key, val|
          if block_given?
              yield(key,val)
          else
              # Prepeare the tests
              test1 = val.nil?
              test2 = val === 0
              test3 = val === false
              test4 = val.empty? if val.respond_to?('empty?')
              test5 = val.strip.empty? if val.is_a?(String) && val.respond_to?('empty?')

              # Were any of the tests true
              test1 || test2 || test3 || test4 || test5
          end
      end

      self.each do |key, val|
          if self[key].is_a?(Hash) && self[key].respond_to?('clean!')
              if block_given?
                  self[key] = self[key].clean!(&Proc.new)
              else
                  self[key] = self[key].clean!
              end
          end
      end

      return self
  end

  #{'caminho_do_elemento'=>'valor','caminho_do_elemento2'=>'valor2'}.params2hash
  def params2hash
    x = {}
    self.map {|elx, val|
      x.recursive_merge( route_params( elx.split('__') , val ) )
    }
    x
  end

  def route_params ( els, val )
    da_vez = els.shift
    if els.count == 0
      { da_vez => val}
    else
      { da_vez => route_params( els, val) }
    end
  end

  def recursive_merge( merge_from )
  	  merge_to = self
      merged_hash = merge_to
      first_key = merge_from.keys[0]
      if merge_to.has_key?(first_key)
          merged_hash[first_key] = recursive_merge( merge_from[first_key], merge_to[first_key] )
      else
          merged_hash[first_key] = merge_from[first_key]
      end
      merged_hash
  end

  #{"oi"=>{"ddd"=>{"xx"=>"x"}}, "iu"=>{"xxx_tchau"=>"o"}}.hash2params
  def hash2params
    out = {}
    self.map{ |elx, val|
      if val.is_a? Hash
        x = elx + "__" + val.hash2params
      else
        out[x] = val
      end
    }
    out
  end
end
