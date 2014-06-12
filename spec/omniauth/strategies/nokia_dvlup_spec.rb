require 'spec_helper'
require 'omniauth-dvlup'

describe OmniAuth::Strategies::NokiaDVLUP do
  before :all do
    OmniAuth.config.test_mode = true
  end

  let(:dvlup) {OmniAuth::Strategies::NokiaDVLUP.new({})}

  context "client options" do
    let(:options) {dvlup.options}
    let(:client_options) {options.client_options}

    it "has the correct name" do
      options.name.should == "dvlup"
    end

    it "points at the right site" do
      client_options.site.should == "https://www.dvlup.com/api"
    end

    it "points at the right auth url" do
      client_options.authorize_url.should == "https://accounts.dvlup.com/auth"
    end

    it "points at the right token url" do
      client_options.token_url.should == "https://accounts.dvlup.com/auth/token"
    end
  end

  context "#authorize_options" do
    it "has a basic scope" do
      dvlup.authorize_params.scope.should == OmniAuth::Strategies::NokiaDVLUP::BASIC_SCOPE
    end

    it "has 'code' as the response type" do
      dvlup.authorize_params.response_type.should == OmniAuth::Strategies::NokiaDVLUP::CODE_RESPONSE_TYPE
    end

    it "has a redirect uri" do
      redirect_uri = "http://www.foo.com/bar"
      dvlup = OmniAuth::Strategies::NokiaDVLUP.new({}, {:redirect_uri => redirect_uri})
      dvlup.authorize_params.redirect_uri.should == redirect_uri
    end
  end
end
