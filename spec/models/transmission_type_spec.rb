require 'spec_helper'

describe TransmissionType do
  it { is_expected.to respond_to(:name) }

  it "has the correct values" do
    transmission_types = [
      "FTP",
      "SFTP",
      "FTPS",
      "REST Web Service",
      "SOAP Web Service",
      "Local Directory",
      "Database"
    ]

    transmission_types.each do |f|
      expect(TransmissionType.find_by_name(f)).to be_valid
    end
  end

  it { should have_many(:souce_transmission_type_feeds).class_name('Feed') }
  it { should have_many(:destination_transmission_type_feeds).class_name('Feed') }
end
