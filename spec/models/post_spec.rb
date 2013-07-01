require 'spec_helper'

describe Post do

  let(:youtube_post) { create :post, :youtube }
  let(:vimeo_post) { create :post, :vimeo }

  it "identifies youtube video type" do
    # private method
    expect(youtube_post.instance_eval { video_type }).to eq("youtube")
  end

  it "identifies vimeo video type" do
    # private method
    expect(vimeo_post.instance_eval { video_type }).to eq("vimeo")
  end
end
