require "spec_helper"

describe "routing to profiles" do

  it "routes profile through pages#user to user_path" do
    expect(:get => "/profile").to route_to(
      :controller => "pages",
      :action => "user"
    ) 
  end

end

describe "routing to user management screen" do
  it "routes to pages#manage_users" do
    expect(get: "/manage-users").to route_to(
      controller: "pages",
      action: "manage_users"
    )
  end
end
