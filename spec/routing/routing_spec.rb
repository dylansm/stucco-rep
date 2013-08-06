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
    expect(delete: admin_user_path('23')).to route_to(
      controller: 'admin/users',
      action: 'destroy',
      id: '23'
    )
  end
end

describe "routing to user management screen" do
  it "routes to admin/users#index" do
    expect(get: "/admin/users").to route_to(
      controller: "admin/users",
      action: "index"
    )
  end
end
