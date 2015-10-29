-- encoding: UTF-8

-- Note: the changes in user.lua script may take effect only after ime restart.

-- Output date and time.
-- Author: lazyparser@gmail.com
-- Date: 2015-10-29
-- inspired by ibus-libpinyin-1.6.91/lua/base.lua:108
_DATE_TIME_PATTERN = "^(%d+)-(%d+)-(%d+) (%d+):(%d+)$"

function get_date_time(input)
  -- Ignore input.
  local now = os.date("%Y-%m-%d %H:%M")
  local year, month, day, hour, minute
  now:gsub(_DATE_TIME_PATTERN, function(y, m, d, h, mn)
    year = tonumber(y)
    month = tonumber(m)
    day = tonumber(d)
    hour = tonumber(h)
    minute = tonumber(mn)
  end)
  return {
    string.format("%d-%02d-%02d %02d:%02d", year, month, day, hour, minute),
    string.format("[d: %d-%02d-%02d]", year, month, day),
  }
end
ime.register_command("dt", "get_date_time", "输出日期和时间", "alpha", "直接输出日期和时间")

