class Observable
  attr_reader :state

  def initialize
    @observers = []
  end

  def subscribe(observer)
    @observers << observer
  end

  def detach(observer)
    @observers.delete(observer)
  end

  def update(new_state)
    @state = new_state
    notify
  end

  private

    def notify
      @observers.each { |observer| observer.update(self) }
    end
end

class Observer1
  def initialize
    @state = nil
  end

  def update(observable_obj)
    @state = observable_obj.state
    puts "Observer1 new state... #{@state}"
  end
end

class Observer2
  def initialize
    @state = nil
  end

  def update(observable_obj)
    @state = observable_obj.state
    puts "Observer2 new state... #{@state}"
  end
end

observable = Observable.new
puts "\n\nObservable state: #{observable.state}"

observer1 = Observer1.new
observer2 = Observer2.new
observable.subscribe(observer1)
observable.subscribe(observer2)

observable.update("Hello!")
puts "\n\n"
observable.update("Hello again!")
puts "\n\n"
