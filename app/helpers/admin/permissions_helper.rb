module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create tickets" => "Create Tickets",
      "update tickets" => "Update Tickets",
      "delete tickets" => "Delete Tickets"
    }
  end
end