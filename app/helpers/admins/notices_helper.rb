module Admins::NoticesHelper
  def unchecked_notices
    @notices = current_admin.notices.where(checked: false)
  end
end
