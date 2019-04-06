class Person
  attr_reader :name
  attr_accessor  :job
  
  def initialize(name, job)
    @name = name
    @job = job
  end
end

person = Person.new("Pham Van A", "none")

person.job = "IT"
puts person.job
