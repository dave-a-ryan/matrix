#the code will be generated with this table, going down the 'columns'
require "tty-table"

#these are the pools the characters can pull from
$code = ("A".."Z").to_a + ("0".."9").to_a + %w( # $ % & ) + %w(九 七 二 人 入 八 力 十 下 三 千 上 口 土 夕 大 女 子 小 山 川 五 天 中 六 円 手)

#these generate all the rows for the table
$rows = [
  row1 = Array.new(15, " "),
  row2 = Array.new(15, " "),
  row3 = Array.new(15, " "),
  row4 = Array.new(15, " "),
  row5 = Array.new(15, " "),
  row6 = Array.new(15, " "),
  row7 = Array.new(15, " "),
  row8 = Array.new(15, " "),
  row9 = Array.new(15, " "),
  row10 = Array.new(15, " "),
  row11 = Array.new(15, " "),
  row12 = Array.new(15, " "),
  row13 = Array.new(15, " "),
  row14 = Array.new(15, " "),
  row15 = Array.new(15, " "),
  row16 = Array.new(15, " "),
  row17 = Array.new(15, " "),
  row18 = Array.new(15, " "),
  row19 = Array.new(15, " "),
  row20 = Array.new(15, " "),
]
$rows = [row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14, row15, row16, row17, row18, row19, row20]

#this is just a way to make the code snakes spawn at different intervals
$snake_metering = [0, -1, -2, -3]

#these are the matrix code thingies
snakes = [
  snake1 = { row: $snake_metering.sample, column: rand(0..14) },
  snake2 = { row: $snake_metering.sample, column: rand(0..14) },
  snake3 = { row: $snake_metering.sample, column: rand(0..14) },
  snake4 = { row: $snake_metering.sample - 3, column: rand(0..14) },
  snake5 = { row: $snake_metering.sample - 3, column: rand(0..14) },
  snake6 = { row: $snake_metering.sample - 3, column: rand(0..14) },
  snake7 = { row: $snake_metering.sample - 7, column: rand(0..14) },
  snake8 = { row: $snake_metering.sample - 7, column: rand(0..14) },
  snake9 = { row: $snake_metering.sample - 7, column: rand(0..14) },
  snake10 = { row: $snake_metering.sample - 14, column: rand(0..14) },
  snake11 = { row: $snake_metering.sample - 14, column: rand(0..14) },
  snake12 = { row: $snake_metering.sample - 14, column: rand(0..14) },
  snake13 = { row: $snake_metering.sample - 21, column: rand(0..14) },
  snake14 = { row: $snake_metering.sample - 21, column: rand(0..14) },
  snake15 = { row: $snake_metering.sample - 21, column: rand(0..14) },
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

#this is the code generation method. It's pretty janky because of all the nil checks..
def matrix(snake)

  #glitch effect
  # glitch = rand(10..18)
  # if snake[:row] == glitch
  #   $rows[snake[:row]][snake[:column]] = "TEST"
  # end

  #resets the snake up to the top
  if snake[:row] == 47
    snake[:row] = $snake_metering.sample
    snake[:column] = rand(0..14)

    #delete old code
  elsif snake[:row] > 22
    unless $rows[snake[:row]] == nil
      $rows[snake[:row]][snake[:column]] = $code.sample
    end
    unless $rows[snake[:row] - 13] == nil
      $rows[snake[:row] - 13][snake[:column]] = $rows[snake[:row] - 13][snake[:column]].green
    end
    unless $rows[snake[:row] - 23] == nil
      $rows[snake[:row] - 23][snake[:column]] = " "
    end
  elsif snake[:row] > 12
    unless $rows[snake[:row]] == nil
      $rows[snake[:row]][snake[:column]] = $code.sample
    end
    unless $rows[snake[:row] - 1] == nil
      $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green
    end
    unless $rows[snake[:row] - 13] == nil
      $rows[snake[:row] - 13][snake[:column]] = $rows[snake[:row] - 13][snake[:column]].green
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
