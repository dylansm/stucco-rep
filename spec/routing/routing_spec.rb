require "spec_helper"

describe "routing to profiles" do

  it "routes profile through pages#user to user_path" do
    expect(:get => "/profile").to route_to(
      :controller => "users",
      :action => "show"
    ) 
  end

end

describe "routing to delete user" do
  it "routes to users#destroy" do
    expect(delete: user_path('23')).to route_to(
      controller: 'users',
      action: 'destroy',
      id: '23'
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
