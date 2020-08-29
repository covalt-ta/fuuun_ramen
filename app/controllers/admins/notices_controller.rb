class Admins::NoticesController < Admins::ApplicationController
  def index
    notice_count_delete
    @notices = current_admin.notices
    @notices.each do |notice|
      notice.update(checked: true)
    end
  end

    private

    # 既読30件のみを残して削除する
    def notice_count_delete
      notices = current_admin.notices.where(checked: true)
      while notices.count > 30 do
        notice = notices.order(cereated_at: :ASC).limit(1)
        notice.destroy_all
      end
    end
end
