require_relative "spec_helper"

describe View do
  describe "#pretty_attribute" do
    it "prints attribute without underscores" do
      expect(subject.pretty_attribute("abc")).to eq("Abc")
    end

    it "prints attribute with one underscore" do
      expect(subject.pretty_attribute("abc_def")).to eq("Abc Def")
    end

    it "prints attribute with two underscores" do
      expect(subject.pretty_attribute("abc_def_ghi")).to eq("Abc Def Ghi")
    end
  end

  describe "#link_up" do
    it "create hyperlink for http URL" do
      expect(subject.link_up("https://example.org")).to eq("<a href='https://example.org'>example.org</a>")
    end
  end
end
