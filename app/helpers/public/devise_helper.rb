module Public::DeviseHelper
  def bootstrap_alert(message_type)
    case message_type
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    else
      message_type
    end
  end
end
