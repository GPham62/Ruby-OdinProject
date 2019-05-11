  module Enumerable
    def my_each
      return self.to_enum unless block_given?
      for i in self
        yield(i)
      end
      self
    end

    def my_each_with_index
      for i in self
        index = self.index(i)
        yield(i, index)
      end
    end

    def my_select
      result = []
      self.my_each do |e|
        if yield(e)
          result << e
        end
      end
      result
    end

    def my_all?
      self.my_each do |e|
        unless yield(e)
          return false
        end
      end
      true
    end

    def my_any?
      self.my_each do |e|
        if yield(e)
          return true
        end
      end
      false
    end

    def my_none?
      self.my_all? do |e|
        !yield(e)
      end
    end

    def my_count(num=nil)
      count = 0
      if block_given?
        self.my_each do |e|
          if yield(e)
            count += 1
          end
        end
      elsif num!= nil
        self.my_each{|e| count += 1 if e == num}
      else
        self.my_each{|e| count += 1}
      end
      count
    end

    def my_map(&proc)
      return self.to_enum(:my_map) unless block_given?
      arr = []
      self.my_each do |e|
        arg = proc.call(e)
        arr << arg
      end
      arr
    end

    def my_inject(*args)
      sum = 0
      i = 0
      raise ArgumentError, "wrong number of arg(expected 0..2)" if args.length > 2
      if (args.length == 0)
        if (block_given?)
          self.my_each do |element|
            (i == 0) ? sum += element : sum = yield(sum, element)
            i += 1
          end
        end
      elsif (args.length == 1)
        if (block_given? == false)
          if (args[0].is_a?(Symbol))
            self.my_each do |element|
                (i == 0) ? sum += element : sum = sum.method(args[0]).call(element)
                i += 1
            end
          end
        elsif (block_given?)
          if (args[0].is_a? Integer)
            sum = args[0]
            self.my_each do |element|
              sum = yield(sum, element)
            end
          end
        end
      elsif (args.length == 2)
        if (args[0].is_a?(Integer) && args[1].is_a?(Symbol))
          sum = args[0]
          self.my_each do |element|
            sum = sum.method(args[1]).call(element)
          end
        end
      end
      sum
    end
  end

  def multiply_els(array)
    array.my_inject(:*)
  end

  # puts multiply_els([2,4,5])
  a = [1, 2, 3]
  print a.my_map

