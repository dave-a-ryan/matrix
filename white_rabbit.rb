require "tty-table"

#these are the pools the characters can pull from
$code = ("A".."Z").to_a + ("0".."9").to_a + %w( # $ % & ) + %w(九 七 二 人 入 八 力 十 下 三 千 上 口 土 夕 大 女 子 小 山 川 五 天 中 六 円 手)

#these generate all the rows for the table
$rows = [
  row1 = Array.new(10, " "),
  row2 = Array.new(10, " "),
  row3 = Array.new(10, " "),
  row4 = Array.new(10, " "),
  row5 = Array.new(10, " "),
  row6 = Array.new(10, " "),
  row7 = Array.new(10, " "),
  row8 = Array.new(10, " "),
  row9 = Array.new(10, " "),
  row10 = Array.new(10, " "),
  row11 = Array.new(10, " "),
  row12 = Array.new(10, " "),
  row13 = Array.new(10, " "),
  row14 = Array.new(10, " "),
  row15 = Array.new(10, " "),
  row16 = Array.new(10, " "),
  row17 = Array.new(10, " "),
  row18 = Array.new(10, " "),
  row19 = Array.new(10, " "),
  row20 = Array.new(10, " "),
  row21 = Array.new(10, " "),
]
$rows = [row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14, row15, row16, row17, row18, row19, row20, row21]

$snake_metering = [0, 0, 0, -1, -2, -2, -3, -4, -5, -6, -7]

#these are the matrix code thingies
snakes = [
  snake1 = { row: $snake_metering.sample, column: rand(0..9) },
  snake2 = { row: $snake_metering.sample, column: rand(0..9) },
  snake3 = { row: $snake_metering.sample, column: rand(0..9) },
  snake4 = { row: $snake_metering.sample, column: rand(0..9) },
  snake5 = { row: $snake_metering.sample, column: rand(0..9) },
  snake6 = { row: $snake_metering.sample, column: rand(0..9) },
  snake7 = { row: $snake_metering.sample - 7, column: rand(0..9) },
  snake8 = { row: $snake_metering.sample - 7, column: rand(0..9) },
  snake9 = { row: $snake_metering.sample - 7, column: rand(0..9) },
  snake10 = { row: $snake_metering.sample - 14, column: rand(0..9) },
  snake11 = { row: $snake_metering.sample - 14, column: rand(0..9) },
  snake12 = { row: $snake_metering.sample - 14, column: rand(0..9) },
  snake13 = { row: $snake_metering.sample - 21, column: rand(0..9) },
  snake14 = { row: $snake_metering.sample - 21, column: rand(0..9) },
  snake15 = { row: $snake_metering.sample - 21, column: rand(0..9) },
]

#green-ify's the text
class String
  def green
    "\e[2;32m#{self}\e[0m"
  end

  def bright_green
    "\e[1;32m#{self}\e[0m"
  end
end

def matrix(snake)
  if snake[:row] == 40
    snake[:row] = $snake_metering.sample
    snake[:column] = rand(0..9)
  elsif snake[:row] > 15
    unless $rows[snake[:row]] == nil
      $rows[snake[:row]][snake[:column]] = $code.sample
    end
    unless $rows[snake[:row] - 1] == nil
      $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green
    end
    unless $rows[snake[:row] - 10] == nil
      $rows[snake[:row] - 10][snake[:column]] = $rows[snake[:row] - 10][snake[:column]].green
    end
    unless $rows[snake[:row] - 16] == nil
      $rows[snake[:row] - 16][snake[:column]] = " "
    end
  elsif snake[:row] > 8
    unless $rows[snake[:row]] == nil
      $rows[snake[:row]][snake[:column]] = $code.sample
    end
    unless $rows[snake[:row] - 1] == nil
      $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green
    end
    unless $rows[snake[:row] - 10] == nil
      $rows[snake[:row] - 10][snake[:column]] = $rows[snake[:row] - 10][snake[:column]].green
    end
  elsif snake[:row] >= 0
    unless $rows[snake[:row]] == nil
      $rows[snake[:row]][snake[:column]] = $code.sample
    end
    unless $rows[snake[:row] - 1] == nil
      $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green
    end
  end
  snake[:row] += 1
end

#this is the main loop, which runs forever
while true
  snakes.each { |snake| matrix(snake) }
  system("clear")
  table = TTY::Table.new(rows: $rows)
  puts table.render(:basic, column_widths: 2, alignment: [:center])
  sleep(0.05)
end
