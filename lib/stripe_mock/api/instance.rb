module StripeMock

  @instance = nil
  @original_request_method = Stripe.method(:request)

  def self.start
    @instance = Instance.new
    alias_stripe_method :request, @instance.method(:mock_request)
  end

  def self.stop
    return if @instance.nil?
    alias_stripe_method :request, @original_request_method
    @instance = nil
  end

  def self.alias_stripe_method(new_name, method_object)
    Stripe.define_singleton_method(new_name) {|*args| method_object.call(*args) }
  end

  def self.instance; @instance; end

end