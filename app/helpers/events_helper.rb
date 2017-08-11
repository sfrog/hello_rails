module EventsHelper

  WEEK_DAY = %w[日 一 二 三 四 五 六]

  def user_name(user_id)
    User.find_by_id(user_id)&.name if user_id.present?
  end

  def format_time(created_at)
    created_at&.strftime('%H:%M') if created_at.respond_to?(:strftime)
  end

  def format_due(due_at)
    return "没有截止日期" unless due_at

    begin
      date = Date.parse(due_at)
    rescue ArgumentError
      return nil
    end

    return "明天" if date == Date.tomorrow
    return "今天" if date == Date.current
    return "昨天" if date == Date.yesterday

    return "本周#{WEEK_DAY[date.wday]}" if this_week(date)
    return "上周#{WEEK_DAY[date.wday]}" if prev_week(date)
    return "下周#{WEEK_DAY[date.wday]}" if next_week(date)

    date.strftime('%m-%d')
  end

  def data_created(created_at)
    created_at&.strftime('%Y/%-m/%-d') if created_at.respond_to?(:strftime)
  end

private

  def this_week(date)
    today = Date.current
    date > today.prev_week(:sunday) && date < today.next_week(:monday)
  end

  def prev_week(date)
    today = Date.current
    date >= today.prev_week(:monday) && date <= today.prev_week(:sunday)
  end

  def next_week(date)
    today = Date.current
    date >= today.next_week(:monday) && date <= today.next_week(:sunday)
  end

end
