require 'spec_helper'

describe "dashboard/admin.html.haml" do
  
  it "renders admin_tools partial" do
    render
    expect(view).to render_template(:partial => "_admin_tools")
  end

end
