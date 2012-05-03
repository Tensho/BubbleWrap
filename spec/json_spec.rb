describe "JSON" do

  before do
    @json_string = <<-EOS
    {
  "public_gists": 248,
  "type": "User",
  "blog": "http://merbist.com",
  "location": "San Diego, CA",
  "followers": 303,
  "company": "LivingSocial",
  "html_url": "https://github.com/mattetti",
  "created_at": "2008-01-31T22:56:31Z",
  "email": "mattaimonetti@gmail.com",
  "hireable": true,
  "gravatar_id": "c69521d6e22fc0bbd69337ec8b1698df",
  "bio": "",
  "public_repos": 137,
  "following": 6,
  "name": "Matt Aimonetti",
  "login": "mattetti",
  "url": "https://api.github.com/users/mattetti",
  "id": 113,
  "avatar_url": "https://secure.gravatar.com/avatar/c69521d6e22fc0bbd69337ec8b1698df?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"
}
EOS
  end

  describe "parsing a basic JSON string" do
    
    before do
      @parsed = BubbleWrap::JSON.parse(@json_string)
    end

    it "should convert a top object into a Ruby hash" do
      obj = @parsed
      obj.class.should == Hash
      obj.keys.size.should == 19
    end

    it "should properly convert integers values" do
      @parsed["id"].is_a?(Integer).should == true
    end

    it "should properly convert string values" do
      @parsed["login"].is_a?(String).should == true
    end

    it "should convert an array into a Ruby array" do
      p Bacon::Counter.inspect
      obj = BubbleWrap::JSON.parse("[1,2,3]")
      obj.class.should == Array
      obj.size.should == 3
    end

  end

  describe "generating a JSON string from an object" do

    before do
      @obj = { foo: 'bar', 
               'bar' => 'baz', 
               baz: 123, 
               foobar: [1,2,3], 
               foobaz: {a: 1, b: 2} 
            }
    end

    it "should generate from a hash" do
      json = BubbleWrap::JSON.generate(@obj)
      json.class == String
      json.should == "{\"foo\":\"bar\",\"bar\":\"baz\",\"baz\":123,\"foobar\":[1,2,3],\"foobaz\":{\"a\":1,\"b\":2}}"
    end

    it "should encode and decode and object losslessly" do
      json = BubbleWrap::JSON.generate(@obj)
      obj = BubbleWrap::JSON.parse(json)
      obj.keys.sort.should == @obj.keys.sort
      obj.values.sort.should == @obj.values.sort
    end

  end

end

