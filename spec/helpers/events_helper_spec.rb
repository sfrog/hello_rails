require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EventsHelper. For example:
#
# describe EventsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EventsHelper, type: :helper do
  describe "user_name" do
    it "should return right user name" do
      user = create(:user)

      expect(helper.user_name(user.id)).to eq(user.name)
    end

    it "should return nil" do
      expect(helper.user_name(nil)).to eq(nil)
      expect(helper.user_name("notexist")).to eq(nil)
    end
  end

  describe "format_time" do
    it "should return right time string" do
      expect(helper.format_time(Time.zone.parse("2017-10-10 01:02:03"))).to eq("01:02")
      expect(helper.format_time(Time.zone.parse("2017-10-10 01:12:03"))).to eq("01:12")
      expect(helper.format_time(Time.zone.parse("2017-10-10 18:02:03"))).to eq("18:02")
      expect(helper.format_time(Time.zone.parse("2017-10-10 18:36:03"))).to eq("18:36")
    end

    it "should return nil" do
      expect(helper.format_time(nil)).to eq(nil)
      expect(helper.format_time("nothing")).to eq(nil)
    end
  end

  describe "format_due" do
    it "should return right due string" do
      today = Date.parse("2017-08-11")

      Timecop.freeze(today) do
        expect(helper.format_due(nil)).to eq("没有截止日期")

        expect(helper.format_due("2017-08-12")).to eq("明天")
        expect(helper.format_due("2017-08-11")).to eq("今天")
        expect(helper.format_due("2017-08-10")).to eq("昨天")

        expect(helper.format_due("2017-08-01")).to eq("上周二")
        expect(helper.format_due("2017-08-09")).to eq("本周三")
        expect(helper.format_due("2017-08-20")).to eq("下周日")
        expect(helper.format_due("2017-09-20")).to eq("09-20")
      end
    end

    it "should return nil" do
      expect(helper.format_due("error date string")).to eq(nil)
    end
  end

  describe "data_created" do
    it "should return right date string" do
      expect(helper.data_created(Time.zone.parse("2017-10-10 01:02:03"))).to eq("2017/10/10")
      expect(helper.data_created(Time.zone.parse("2017-02-01 01:12:03"))).to eq("2017/2/1")
      expect(helper.data_created(Time.zone.parse("2017-05-28 18:02:03"))).to eq("2017/5/28")
      expect(helper.data_created(Time.zone.parse("2017-12-28 18:02:03"))).to eq("2017/12/28")
    end

    it "should return nil" do
      expect(helper.data_created(nil)).to eq(nil)
      expect(helper.data_created("nothing")).to eq(nil)
    end
  end
end
