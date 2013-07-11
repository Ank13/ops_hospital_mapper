module StatsHelper

  def sum
    return self.inject(0){|acc,i|acc +i}
  end
 
  def avg
    return self.sum/self.length.to_f
  end
 
  def sample_variance
    avg=self.avg
    sum=self.inject(0){|acc,i|acc +(i-avg)**2}
    return(1/self.length.to_f*sum)
  end
 
  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end
 

end

Array.send :include, StatsHelper

