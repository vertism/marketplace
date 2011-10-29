shared_examples_for "a request" do
  subject { a_request(method, url) }
  before { stub_request(method, url) }

  context "with a url" do
    before { Marketplace.call(method, url: url) }

    it "visits the urls" do
      should have_been_made
    end
  end
end
