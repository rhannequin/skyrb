# frozen_string_literal: true

require "rails_helper"

describe Sky::Asterisms do
  subject { described_class.new }

  describe "#loads!" do
    let(:constellation) { FactoryBot.create(:constellation) }
    let(:pairs_count) { 1 }

    let!(:star1) do
      FactoryBot.create(
        :star,
        constellation: constellation,
        hip_id: 1
      )
    end

    let!(:star2) do
      FactoryBot.create(
        :star,
        constellation: constellation,
        hip_id: 2
      )
    end

    let(:mocked_content) do
      [
        "#{constellation.abbreviation} #{pairs_count}  #{star1.hip_id} #{star2.hip_id}",
      ].join("\n")
    end

    before do
      allow(File).to(
        receive(:read)
          .and_return(StringIO.new(mocked_content.to_s))
      )
    end

    it "doesn't fail" do
      expect { subject.load! }.not_to raise_error
    end

    it "creates AsterismPairs" do
      expect { subject.load! }.to change { AsterismPair.count }.by(pairs_count)
    end
  end
end
