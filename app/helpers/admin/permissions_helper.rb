module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create tickets" => "Create Tickets",
      "update tickets" => "Update Tickets",
      "delete tickets" => "Delete Tickets",
      "change states" => "Change States"
    }
  end
end
